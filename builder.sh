#!/bin/sh 

# Check if running as root
if [ $(whoami) != "root" ]
then
	echo "Run me as root!"
	exit
fi

# Make directories to work with
# TODO

# Download libraries and tools
apt-get update
apt-get -y bison flex gcc make exuberant-ctags bc libssl-dev

# Download Kernel, Syslinux, Busybox, tinyxserver, dwm, xterm
# Kernel
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.0.7.tar.xz
# Syslinux
wget https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/6.xx/syslinux-6.03.tar.xz
# Busybox
wget https://www.busybox.net/downloads/busybox-1.30.1.tar.bz2
# dwm
wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz
# tinyxserver
wget https://github.com/dimkr/tinyxserver/archive/master.zip -O tinyxserver.zip
# xterm
wget https://invisible-island.net/datafiles/release/xterm.tar.gz

# Unpack everything
# TODO

# Build everything
# TODO
