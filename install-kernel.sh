#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ

_os_id="$(cat /etc/os-release | grep '^ID=' | cut -d"=" -f2 | sed 's|"||g')"
if [[ ${_os_id} != "rhel" ]]; then
    echo
    printf "\e[01;31m%s\e[0m\n" 'This OS is not a "Red Hat Enterprise Linux Server"'
    echo Aborted
    exit 1
fi

cd "$(dirname "$0")"

_VERSION="$(ls -1 | grep -i '^[3-9]')"

cd "${_VERSION}"
cat linux-"${_VERSION}".tar.gz.par* > linux-"${_VERSION}".tar.gz
sleep 2
echo
sha256sum --check linux-"${_VERSION}".tar.gz.sha256
rc=$?
if [[ $rc != 0 ]]; then
    exit 1
fi
rm -fr linux-"${_VERSION}".tar.gz.par*
echo
tar -xf linux-"${_VERSION}".tar.gz
cd linux-"${_VERSION}"
sha256sum --check sha256sums.txt
rc=$?
if [[ $rc != 0 ]]; then
    exit 1
fi
echo
sleep 5
yum -y install kernel-"${_VERSION}"-*.rpm
yum -y install kernel-devel-*.rpm
rpm -evh --nodeps kernel-headers
yum -y install kernel-headers-*.rpm
cd ..
echo
sleep 10
rm -fr linux-"${_VERSION}"

cd /tmp
rpm -qa | grep -i kernel- | grep -i "${_VERSION}"
echo
exit
