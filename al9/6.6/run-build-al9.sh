#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ
umask 022
set -e
cd "$(dirname "$0")"
systemctl start docker
sleep 5
echo
lscpu
echo
cat /proc/cpuinfo
echo
if [ "$(cat /proc/cpuinfo | grep -i '^processor' | wc -l)" -gt 1 ]; then
    docker run --cpus="$(cat /proc/cpuinfo | grep -i '^processor' | wc -l).0" --hostname 'x86-040.build.eng.bos.redhat.com' --rm --name al9 -itd almalinux:9 bash
else
    docker run --hostname 'x86-040.build.eng.bos.redhat.com' --rm --name al9 -itd almalinux:9 bash
fi
sleep 2
docker exec al9 yum clean all
docker exec al9 yum makecache
docker exec al9 yum install -y wget bash
docker exec al9 /bin/bash -c 'ln -svf bash /bin/sh'
docker exec al9 /bin/bash -c 'rm -fr /tmp/*'
docker cp ../.preinstall_al9 al9:/home/
docker cp build-scripts al9:/home/
docker exec al9 /bin/bash /home/.preinstall_al9
echo
docker exec al9 cat /etc/os-release
echo
docker exec al9 /bin/bash /home/build-scripts/00-run-all.sh
mkdir -p /tmp/_output_assets
docker cp al9:/tmp/_output /tmp/_output_assets/
exit
