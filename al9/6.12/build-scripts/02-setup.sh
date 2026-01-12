#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ
umask 022
set -e
cd "$(dirname "$0")"

_linux_kernel_ver=$(ls -1 linux-*.tar.xz | sed -E 's/.*linux-([0-9]+\.[0-9]+\.[0-9]+)\.tar\.xz/\1/')

IFS='.' read -r _major _minor _patch <<< "${_linux_kernel_ver}"
_patch=${_patch:-0}

rm -f kernel-"${_major}.${_minor}"*.spec

if ls .kernel-*.spec >/dev/null 2>&1; then
    cp -f .kernel-*.spec kernel-"${_major}.${_minor}.${_patch}".spec
    chmod 0644 kernel-*.spec
fi

_kernel_spec_file=kernel-"${_major}.${_minor}.${_patch}".spec

# 7
#%define pkg_release 1%{?buildid}%{?dist}

# 8
#%define pkg_release 1%{?dist}%{?buildid}

# 9
#%global pkg_release 1%{?buildid}%{?dist}

_datenow="$(date -u +%Y%m%d)"
sed "/^%global LKAver /s|LKAver .*|LKAver ${_linux_kernel_ver}|g" -i "${_kernel_spec_file}"
sed "/^%global pkg_release /s|pkg_release .*|pkg_release ${_datenow}%{?dist}%{?buildid}|g" -i "${_kernel_spec_file}"

sed 's|^NoSource:|#NoSource:|g' -i "${_kernel_spec_file}"

sed -e '/^%changelog/,$d' -i "${_kernel_spec_file}"
echo '%changelog' >> "${_kernel_spec_file}"

if [[ "${_patch}" > 0 ]]; then
    for (( i = "${_patch}"; i >= 0; i-- )); do
        if [[ ${i} == 0 ]]; then
            _changelog_date="$(wget -qO- "https://www.kernel.org/pub/linux/kernel/v${_major}.x/ChangeLog-${_major}.${_minor}" | head -n 4 | grep -i '^Date:' | sed 's/^Date://g' | sed "s/^[ \t]*//" | awk '{print $1,$2,$3,$5}')"
            _changelog_author="$(wget -qO- "https://www.kernel.org/pub/linux/kernel/v${_major}.x/ChangeLog-${_major}.${_minor}" | head -n 4 | grep -i '^Author:' | sed 's/^Author://g' | sed "s/^[ \t]*//")"
            echo "* ${_changelog_date} ${_changelog_author} - ${_major}.${_minor}" >> "${_kernel_spec_file}"
            echo "- Updated with the ${_major}.${_minor} source tarball." >> "${_kernel_spec_file}"
            echo "- [https://www.kernel.org/pub/linux/kernel/v${_major}.x/ChangeLog-${_major}.${_minor}]" >> "${_kernel_spec_file}"
        else
            _changelog_date="$(wget -qO- "https://www.kernel.org/pub/linux/kernel/v${_major}.x/ChangeLog-${_major}.${_minor}.${i}" | head -n 4 | grep -i '^Date:' | sed 's/^Date://g' | sed "s/^[ \t]*//" | awk '{print $1,$2,$3,$5}')"
            _changelog_author="$(wget -qO- "https://www.kernel.org/pub/linux/kernel/v${_major}.x/ChangeLog-${_major}.${_minor}.${i}" | head -n 4 | grep -i '^Author:' | sed 's/^Author://g' | sed "s/^[ \t]*//")"            
            echo "* ${_changelog_date} ${_changelog_author} - ${_major}.${_minor}.${i}" >> "${_kernel_spec_file}"
            echo "- Updated with the ${_major}.${_minor}.${i} source tarball." >> "${_kernel_spec_file}"
            echo "- [https://www.kernel.org/pub/linux/kernel/v${_major}.x/ChangeLog-${_major}.${_minor}.${i}]" >> "${_kernel_spec_file}"
            echo >> "${_kernel_spec_file}"
        fi
    done
elif [[ "${_patch}" == "0" ]]; then
    _changelog_date="$(wget -qO- "https://www.kernel.org/pub/linux/kernel/v${_major}.x/ChangeLog-${_major}.${_minor}" | head -n 4 | grep -i '^Date:' | sed 's/^Date://g' | sed "s/^[ \t]*//" | awk '{print $1,$2,$3,$5}')"
    _changelog_author="$(wget -qO- "https://www.kernel.org/pub/linux/kernel/v${_major}.x/ChangeLog-${_major}.${_minor}" | head -n 4 | grep -i '^Author:' | sed 's/^Author://g' | sed "s/^[ \t]*//")"
    echo "* ${_changelog_date} ${_changelog_author} - ${_major}.${_minor}" >> "${_kernel_spec_file}"
    echo "- Updated with the ${_major}.${_minor} source tarball." >> "${_kernel_spec_file}"
    echo "- [https://www.kernel.org/pub/linux/kernel/v${_major}.x/ChangeLog-${_major}.${_minor}]" >> "${_kernel_spec_file}"
fi

echo >> "${_kernel_spec_file}"

# System libbpf
#_LIBBPF_MAJOR_VERSION=$(rpm -qa | grep -i '^libbpf-[0-9]' | sed -e 's|libbpf-||g' -e 's|-[0-9].*||g' | awk -F. '{print $1}')
#_LIBBPF_MINOR_VERSION=$(rpm -qa | grep -i '^libbpf-[0-9]' | sed -e 's|libbpf-||g' -e 's|-[0-9].*||g' | awk -F. '{print $2}')

# Source libbpf
_tmp_dir="$(mktemp -d)"
tar -xof linux-*.tar* -C "${_tmp_dir}"/
_LIBBPF_MAJOR_VERSION=$(cat "${_tmp_dir}"/linux-*/tools/lib/bpf/libbpf_version.h | grep -i '#define LIBBPF_MAJOR_VERSION' | head -n 1 | awk '{print $NF}')
_LIBBPF_MINOR_VERSION=$(cat "${_tmp_dir}"/linux-*/tools/lib/bpf/libbpf_version.h | grep -i '#define LIBBPF_MINOR_VERSION' | head -n 1 | awk '{print $NF}')

_BPFTOOL_MAJOR_VERSION=$((_LIBBPF_MAJOR_VERSION+6))
_BPFTOOL_MINOR_VERSION=${_LIBBPF_MINOR_VERSION}
_bpftoolversion="${_BPFTOOL_MAJOR_VERSION}.${_BPFTOOL_MINOR_VERSION}.0"
sed "s|^%define bpftoolversion .*|%define bpftoolversion ${_bpftoolversion}|g" -i "${_kernel_spec_file}"
rm -fr "${_tmp_dir}"
_tmp_dir=''

echo
grep '%global LKAver' "${_kernel_spec_file}"
echo
grep '%define bpftoolversion' "${_kernel_spec_file}"
echo
grep -i 'https://www.kernel.org/pub/linux/kernel/' "${_kernel_spec_file}"

###############################################################################

rm -fr config-*
if [[ -f .config ]]; then
    cp -f .config config-"${_linux_kernel_ver}"-x86_64
    sleep 1
    sed -i -e "/Kernel Configuration/s|^# Linux/x86_64 .*Kernel Configuration|# Linux/x86_64 ${_linux_kernel_ver} Kernel Configuration|g" config-"${_linux_kernel_ver}"-x86_64
fi

echo
echo ' done'
exit

