#!/bin/sh

cd /tmp

wget -q http://deb.devuan.org/devuan/pool/main/d/devuan-keyring/devuan-keyring_2017.10.03_all.deb
wget -q http://ftp.br.debian.org/debian/pool/main/c/ca-certificates/ca-certificates_20200601~deb9u1_all.deb
wget -q http://ftp.br.debian.org/debian/pool/main/o/openssl/openssl_1.1.0l-1~deb9u1_amd64.deb
wget -q http://ftp.br.debian.org/debian/pool/main/o/openssl/libssl1.1_1.1.0l-1~deb9u1_amd64.deb
dpkg -i --force-all ./devuan-keyring_2017.10.03_all.deb ./ca-certificates_20200601~deb9u1_all.deb ./openssl_1.1.0l-1~deb9u1_amd64.deb ./libssl1.1_1.1.0l-1~deb9u1_amd64.deb

echo deb     http://deb.devuan.org/merged chimaera main >  /etc/apt/sources.list
echo deb-src http://deb.devuan.org/merged chimaera main >> /etc/apt/sources.list
apt-get update
touch /etc/mtab

DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade --no-install-recommends

#install SysVinit & remove systemd
apt install sysvinit-core sysvinit-utils
cp /usr/share/sysvinit/inittab /etc/inittab
apt remove  --purge --auto-remove systemd
