Repo
```
[el-8-for-x86_64-kernel-rpms]
baseurl = file:///.repos/kernel
name = Enterprise Linux 8 for x86_64 - Kernel (RPMs)
enabled = 1
gpgcheck = 0
proxy=_none_
```

```
[el-9-for-x86_64-kernel-rpms]
baseurl = file:///.repos/kernel
name = Enterprise Linux 9 for x86_64 - Kernel (RPMs)
enabled = 1
gpgcheck = 0
proxy=_none_
```

```
[root@al9 ~]# yum --showduplicates list bpftool
Last metadata expiration check: 0:27:07 ago on Mon Oct 21 11:23:17 2024.
Installed Packages
bpftool.x86_64                     7.3.0-427.40.1.el9_4                  @baseos                    
Available Packages
bpftool.x86_64                     6.6.57-20241020.el9                   el-9-for-x86_64-kernel-rpms
bpftool.x86_64                     7.3.0-427.13.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.16.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.18.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.20.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.22.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.24.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.26.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.28.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.31.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.33.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.35.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.37.1.el9_4                  baseos                     
bpftool.x86_64                     7.3.0-427.40.1.el9_4                  baseos                     
[root@al9 ~]# 
[root@al9 ~]# yum install bpftool-6.6.57-20241020.el9

```


查询所有repo
```
[root@al9 ~]# yum repolist
repo id                                  repo name
appstream                                AlmaLinux 9 - AppStream
baseos                                   AlmaLinux 9 - BaseOS
crb                                      AlmaLinux 9 - CRB
el-9-for-x86_64-kernel-rpms              Enterprise Linux 9 for x86_64 - Kernel (RPMs)
epel                                     Extra Packages for Enterprise Linux 9 - x86_64
epel-cisco-openh264                      Extra Packages for Enterprise Linux 9 openh264 (From Cisco) - x86_64
extras                                   AlmaLinux 9 - Extras
plus                                     AlmaLinux 9 - Plus
[root@al9 ~]# 

yum repolist all/enabled/disabled
yum repolist --all/--enabled/--disabled

yum-config-manager --enable "repo id"
yum-config-manager --enable plus
dnf config-manager --set-enabled plus

yum makecache

yum --disablerepo="*" --enablerepo=crb list available

```

```
cp -vf ../.config .config
make -s ARCH=x86_64 listnewconfig | grep -E '^CONFIG_'

make ARCH=x86_64 oldconfig

make ARCH=x86_64 menuconfig
make ARCH=x86_64 defconfig
make ARCH=x86_64 olddefconfig
make distclean

```


查询内核kernel
```
查询所有可用的kernel
[root@al9 ~]# grubby --info=ALL
index=0
kernel="/boot/vmlinuz-6.6.56-20241011.el9.x86_64"
args="ro crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M resume=/dev/mapper/almalinux-swap rd.lvm.lv=almalinux/root rd.lvm.lv=almalinux/swap"
root="/dev/mapper/almalinux-root"
initrd="/boot/initramfs-6.6.56-20241011.el9.x86_64.img"
title="AlmaLinux (6.6.56-20241011.el9.x86_64) 9.4 (Seafoam Ocelot)"
id="6c12765bd20f4e39b8c4e0a30b8fa6a4-6.6.56-20241011.el9.x86_64"
index=1
kernel="/boot/vmlinuz-5.14.0-427.37.1.el9_4.x86_64"
args="ro crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M resume=/dev/mapper/almalinux-swap rd.lvm.lv=almalinux/root rd.lvm.lv=almalinux/swap"
root="/dev/mapper/almalinux-root"
initrd="/boot/initramfs-5.14.0-427.37.1.el9_4.x86_64.img"
title="AlmaLinux (5.14.0-427.37.1.el9_4.x86_64) 9.4 (Seafoam Ocelot)"
id="6c12765bd20f4e39b8c4e0a30b8fa6a4-5.14.0-427.37.1.el9_4.x86_64"
index=2
kernel="/boot/vmlinuz-5.14.0-427.13.1.el9_4.x86_64"
args="ro crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M resume=/dev/mapper/almalinux-swap rd.lvm.lv=almalinux/root rd.lvm.lv=almalinux/swap"
root="/dev/mapper/almalinux-root"
initrd="/boot/initramfs-5.14.0-427.13.1.el9_4.x86_64.img"
title="AlmaLinux (5.14.0-427.13.1.el9_4.x86_64) 9.4 (Seafoam Ocelot)"
id="6c12765bd20f4e39b8c4e0a30b8fa6a4-5.14.0-427.13.1.el9_4.x86_64"
index=3
kernel="/boot/vmlinuz-0-rescue-6c12765bd20f4e39b8c4e0a30b8fa6a4"
args="ro crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M resume=/dev/mapper/almalinux-swap rd.lvm.lv=almalinux/root rd.lvm.lv=almalinux/swap"
root="/dev/mapper/almalinux-root"
initrd="/boot/initramfs-0-rescue-6c12765bd20f4e39b8c4e0a30b8fa6a4.img"
title="AlmaLinux (0-rescue-6c12765bd20f4e39b8c4e0a30b8fa6a4) 9.4 (Seafoam Ocelot)"
id="6c12765bd20f4e39b8c4e0a30b8fa6a4-0-rescue"
[root@al9 ~]#

查询默认kernel , 输出使用的 vmlinuz
[root@al9 ~]# grubby --default-kernel
/boot/vmlinuz-5.14.0-427.37.1.el9_4.x86_64
[root@al9 ~]# 

```

使用 `grubby --set-default` 或者 `grub2-set-default` 的这是默认内核

```
1. grubby
设置默认kernel , --set-default 等于 grubby --info=ALL 中的 kernel 的值
[root@al9 ~]# grubby --set-default=/boot/vmlinuz-5.14.0-284.11.1.rt14.296.el9_2.x86_64

2. grub2-set-default
grub2-set-default index的值  或 grub2-set-default id的值

使用 grubby --info=ALL 查询 index 和 id

grub2-set-default id的值
[root@al9 ~]# grub2-set-default 1
[root@al9 ~]# cat /boot/grub2/grubenv | grep saved
saved_entry=1
[root@al9 ~]# 

grub2-set-default index的值
[root@al9 ~]# grub2-set-default "6c12765bd20f4e39b8c4e0a30b8fa6a4-5.14.0-427.40.1.el9_4.x86_64"
[root@al9 ~]# 
[root@al9 ~]# cat /boot/grub2/grubenv | grep saved
saved_entry=6c12765bd20f4e39b8c4e0a30b8fa6a4-5.14.0-427.40.1.el9_4.x86_64
[root@al9 ~]# 

/etc/default/grub 中 GRUB_DEFAULT=saved
[root@al9 ~]# cat /etc/default/grub 
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M resume=/dev/mapper/almalinux-swap rd.lvm.lv=almalinux/root rd.lvm.lv=almalinux/swap"
GRUB_DISABLE_RECOVERY="true"
GRUB_ENABLE_BLSCFG=true
[root@al9 ~]# 

[root@al9 ~]# ls -la /etc/grub2.cfg
lrwxrwxrwx. 1 root root 22 Sep  3 04:13 /etc/grub2.cfg -> ../boot/grub2/grub.cfg
[root@al9 ~]# 
[root@al9 ~]# grub2-mkconfig -o /etc/grub2.cfg
Generating grub configuration file ...
Adding boot menu entry for UEFI Firmware Settings ...
done
[root@al9 ~]# 

```


# fedora config
```

General setup ->
    Kernel compression mode (XZ)  --->
    Preemption Model (Fully Preemptible Kernel (Real-Time))  --->
    <*> Kernel .config support

Networking support > Networking options > TCP: advanced congestion control
    <*>   BBR TCP

Networking support > Networking options > Network packet filtering framework (Netfilter) > Core Netfilter Configuration

Networking support > Networking options
    <M> The DCCP Protocol  --->
    <M>     Multi-Protocol Over ATM (MPOA) support
    <M> CCITT X.25 Packet Layer
    <M> LAPB Data Link Driver
    <M> Phonet protocols family
    <M>   TUN device for Qualcomm IPC Router
  

Networking support > Networking options > Distributed Switch Architecture

Networking support > Networking options > QoS and/or fair queueing
    <*>   Ingress/classifier-action Qdisc
        *** Classification ***
    <*>   BPF-based classifier
    [*]   Actions

Networking support
    <M>   CAIF support  --->

Networking support > NFC subsystem support
Networking support > NFC subsystem support > Near Field Communication (NFC) devices

Security options
    Default integrity hash algorithm (SHA512)  --->

Cryptographic API > Public-key cryptography
    <*> Curve25519
Cryptographic API > AEAD (authenticated encryption with associated data) ciphers
    <*> ChaCha20-Poly1305

Cryptographic API > Accelerated Cryptographic Algorithms for CPU (x86)

```

# fedora el8
```
cat kernel-ml-6.12.spec | sed -e '/^%changelog/,$d' > ../kernel-6.12.spec
sed 's|kernel-ml|kernel|g' -i kernel-6.12.spec
sed 's|Kernel-ml|Kernel|g' -i kernel-6.12.spec
sed 's|kernel_ml|kernel|g' -i kernel-6.12.spec
sed 's|Kernel_ml|Kernel|g' -i kernel-6.12.spec
sed '/^%global __spec_install_pre/a\\n%global dist .el8' -i kernel-6.12.spec

# Patch
Patch1: bpftool-feature.patch

# Do not package the source tarball.
#NoSource: 0

%setup -q -n %{name}-%{version} -c
mv linux-%{LKAver} linux-%{KVERREL}
pushd linux-%{KVERREL} > /dev/null

%patch1 -p1

olddefconfig

%{__rm} -f .config.old

%{_bindir}/xargs --no-run-if-empty -P%{zcpu} %{__xz} -9
```

# fedora el9
```
cat kernel-ml-6.12.spec | sed -e '/^%changelog/,$d' > ../kernel-6.12.spec
sed 's|kernel-ml|kernel|g' -i kernel-6.12.spec
sed 's|Kernel-ml|Kernel|g' -i kernel-6.12.spec
sed 's|kernel_ml|kernel|g' -i kernel-6.12.spec
sed 's|Kernel_ml|Kernel|g' -i kernel-6.12.spec
sed '/^%global __spec_install_pre/a\\n%global dist .el9' -i kernel-6.12.spec

# Patch
Patch1: bpftool-feature.patch

# Do not package the source tarball.
#NoSource: 0

%setup -q -n %{name}-%{version} -c
mv linux-%{LKAver} linux-%{KVERREL}
pushd linux-%{KVERREL} > /dev/null

%patch1 -p1

olddefconfig

%{__rm} -f .config.old

%{_bindir}/xargs --no-run-if-empty -P%{zcpu} %{__xz} -9
```

# al9 6.12 , CONFIG_LSM apparmor then selinux
```
#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_HAVE_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_KEY_NOTIFICATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_PROC_MEM_ALWAYS_FORCE=y
# CONFIG_PROC_MEM_FORCE_PTRACE is not set
# CONFIG_PROC_MEM_NO_FORCE is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_INFINIBAND=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SELINUX_DEBUG is not set
# CONFIG_SECURITY_SMACK is not set
CONFIG_SECURITY_TOMOYO=y
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
# CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
CONFIG_SECURITY_TOMOYO_POLICY_LOADER="/sbin/tomoyo-init"
CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER="/usr/lib/systemd/systemd"
# CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_SECURITY_IPE=y
CONFIG_IPE_BOOT_POLICY=""
CONFIG_IPE_POLICY_SIG_SECONDARY_KEYRING=y
CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING=y

#
# IPE Trust Providers
#
CONFIG_IPE_PROP_DM_VERITY=y
CONFIG_IPE_PROP_DM_VERITY_SIGNATURE=y
CONFIG_IPE_PROP_FS_VERITY=y
# end of IPE Trust Providers

CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_PLATFORM_KEYRING=y
CONFIG_INTEGRITY_MACHINE_KEYRING=y
CONFIG_INTEGRITY_CA_MACHINE_KEYRING=y
CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX=y
CONFIG_LOAD_UEFI_KEYS=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_KEXEC=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
# CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH_SHA512=y
CONFIG_IMA_DEFAULT_HASH="sha512"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_APPRAISE_MODSIG=y
CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,integrity,apparmor,selinux,bpf,landlock,ipe"
```


```
# usb4
> Device Drivers
    <*> Unified support for USB4 and Thunderbolt  --->

# usb
> Device Drivers > USB support 

> Device Drivers > USB support > USB Gadget Support M 
> Device Drivers > USB support > USB Gadget Support > USB Peripheral Controller M

# usb typec
> Device Drivers > USB support 
    <*>   USB Type-C Support  ---> all M

# network device 
> Device Drivers > Network device support
> Device Drivers > Network device support > Ethernet driver support
> Device Drivers > Network device support > Wireless LAN
> Device Drivers > Network device support > Wan interfaces support
> Device Drivers > Network device support > Wireless WAN
> Device Drivers > Network device support > USB Network Adapters

```



