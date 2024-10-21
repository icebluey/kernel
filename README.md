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

查询所有repo
```
[root@al9 ~]# yum repolist
repo id                                                                            repo name
appstream                                                                          AlmaLinux 9 - AppStream
baseos                                                                             AlmaLinux 9 - BaseOS
crb                                                                                AlmaLinux 9 - CRB
el-9-for-x86_64-kernel-rpms                                                        Enterprise Linux 9 for x86_64 - Kernel (RPMs)
epel                                                                               Extra Packages for Enterprise Linux 9 - x86_64
epel-cisco-openh264                                                                Extra Packages for Enterprise Linux 9 openh264 (From Cisco) - x86_64
extras                                                                             AlmaLinux 9 - Extras
plus                                                                               AlmaLinux 9 - Plus
[root@al9 ~]# 

yum repolist all/enabled/disabled
yum repolist --all/--enabled/--disabled

yum-config-manager --enable "repo id"
yum-config-manager --enable plus
dnf config-manager --set-enabled plus

yum makecache

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


