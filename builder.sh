#!/bin/sh 

# Check if running as root
if [ $(whoami) != "root" ]
then
	echo "Run me as root!"
	exit
fi

# Download libraries and tools
apt-get update
apt-get -y install bison flex gcc make exuberant-ctags bc libssl-dev libelf-dev nasm uuid-dev

# Download Kernel, Syslinux, Busybox, tinyxserver, dwm, xterm
# Kernel
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.0.7.tar.xz
# Syslinux
wget https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/6.xx/syslinux-6.03.tar.xz
# Busybox
wget https://www.busybox.net/downloads/busybox-1.30.1.tar.bz2

# 		NOT YET!
# dwm
#wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz
# tinyxserver
#wget https://github.com/dimkr/tinyxserver/archive/master.zip -O tinyxserver.zip
# xterm
#wget https://invisible-island.net/datafiles/release/xterm.tar.gz

# Unpack everything
tar xvf linux-5.0.7.tar.xz
tar xvf syslinux-6.03.tar.xz
tar xvf busybox-1.30.1.tar.bz2

# Build everything
# syslinux
cd syslinux-6.03; make bios installer -j4; cd ..
# busybox
cd busybox-1.30.1; make defconfig; make -j4; cd ..
# kernel
cd linux-5.0.7; make defconfig; make -j4; cd ..

# Done
echo "Everything downloaded and built."
