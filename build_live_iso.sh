#!/bin/sh 
#mkisofs -o live.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V liveiso ./liveiso/

mkdir isolive
cd isolive
mkdir bin dev isolinux lib lib64 proc sbin sys

# copy kernel
cp ../linux-5.0.7/arch/x86_64/boot/bzImage .

# copy isolinux files
cp ../syslinux-6.03/bios/core/isolinux.bin ./isolinux/isolinux.bin
cp ../syslinux-6.03/bios/com32/elflink/ldlinux/ldlinux.c32 ./isolinux/ldlinux.c32

# copy busybox
cp ../busybox-1.30.1/busybox ./bin/
cp ../busybox-1.30.1/busybox ./sbin/

# copy libs
cp /lib64/ld-linux-x86-64.so.2 ./lib64/
mkdir lib/x86_64-linux-gnu
cp /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/libresolv.so.2 ./lib/x86_64-linux-gnu/

# build isolinux config
echo "prompt 1" > isolinux/isolinux.cfg
echo "default 1" >> isolinux/isolinux.cfg
echo "label 1" >> isolinux/isolinux.cfg
echo "	kernel /bzImage" >> isolinux/isolinux.cfg
# IF KERNEL SAYS THAT IT CANT MOUNT ROOT, CHANGE THIS
echo "	append root=/dev/sr0 init=/init" >> isolinux/isolinux.cfg

# build init
echo "#!/bin/ash" > init
echo "mount -t proc none /proc" >> init
echo "mount -t sysfs none /sys" >> init
echo "ash" >> init
chmod +x init

# make busybox links
cd bin
ln -s busybox ash
ln -s busybox mount
ln -s busybox ls
ln -s busybox cd
ln -s busybox uname
ln -s busybox echo
cd ..

cd sbin
ln -s busybox init
cd ..

# build image
cd ..
mkisofs -o FSQLive.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V liveiso ./isolive/

# apply syslinux mbr
./syslinux-6.03/bios/utils/isohybrid FSQLive.iso

# done
echo "Done"
