#! /bin/sh

## path to your local "Asuswrt-Merlin_John_fork" repo
ASUSWRT_REPO_DIR=$HOME/asuswrt-merlin 

## path to your local copy of this repo
ASUSWRT_PATCHES_DIR=$HOME/Dokumente/buildroot-2016.02/asuswrt_arm  

## path to mips-toolchain with gcc 5.3 and binutils 2.23.2
ASUSWRT_TOOLCHAIN_DIR=$HOME/buildroot-2016.02_arm_asuswrt

export PATH=$ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/toolchains/hndtools-arm-uclibc-5.3/usr/bin:$PATH

cd $ASUSWRT_REPO_DIR 
git clean -dxf 
git reset --hard
#git pull

git checkout 374.43_2-update

clear

#### new toolchain
rm -rf  $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3
mkdir -p $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/toolchains/hndtools-arm-uclibc-5.3/usr
cp -rf $ASUSWRT_TOOLCHAIN_DIR/usr/* $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/toolchains/hndtools-arm-uclibc-5.3/usr

####kernel
## kernel built-in
patch -p1 -d$ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/linux/linux-2.6.36 < $ASUSWRT_PATCHES_DIR/linux-2.6.32.60-gcc5.patch
#cp -rf  $ASUSWRT_PATCHES_DIR/Makefile_linux_arm $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/linux/linux-2.6.36/Makefile
patch -i $ASUSWRT_PATCHES_DIR/Makefile_linux_arm.patch $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/linux/linux-2.6.36/Makefile

## module: et-driver
patch -i $ASUSWRT_PATCHES_DIR/etc.c.patch $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/et/sys/etc.c
patch -i $ASUSWRT_PATCHES_DIR/etc_adm.c.patch $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/et/sys/etc_adm.c
patch -i $ASUSWRT_PATCHES_DIR/etc47xx.c.patch $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/et/sys/etc47xx.c
patch -i $ASUSWRT_PATCHES_DIR/etcgmac.c.patch $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/et/sys/etcgmac.c
patch -i $ASUSWRT_PATCHES_DIR/etc_fa.c.patch $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/et/sys/etc_fa.c


#### userland
## router/Makefiles
#cp -vf $ASUSWRT_PATCHES_DIR/Makefile $ASUSWRT_REPO_DIR/release/src/router/Makefile
patch -i $ASUSWRT_PATCHES_DIR/Makefile.patch $ASUSWRT_REPO_DIR/release/src/router/Makefile
#cp -vf $ASUSWRT_PATCHES_DIR/platform.mak $ASUSWRT_REPO_DIR/release/src-rt/platform.mak
patch -i $ASUSWRT_PATCHES_DIR/platform.mak.patch $ASUSWRT_REPO_DIR/release/src-rt/platform.mak
#cp -vf $ASUSWRT_PATCHES_DIR/common.mak $ASUSWRT_REPO_DIR/release/src/router/common.mak
patch -i $ASUSWRT_PATCHES_DIR/common.mak.patch $ASUSWRT_REPO_DIR/release/src/router/common.mak

## router/shared
patch -i $ASUSWRT_PATCHES_DIR/shutils.h.patch $ASUSWRT_REPO_DIR/release/src/router/shared/shutils.h

##router/rc
patch -i $ASUSWRT_PATCHES_DIR/ctype.h.patch $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/toolchains/hndtools-arm-uclibc-5.3/usr/arm-brcm-linux-uclibcgnueabi/sysroot/usr/include/ctype.h

##router/libdisk
#cp -vf $ASUSWRT_PATCHES_DIR/Makefile_libdisk_arm $ASUSWRT_REPO_DIR/release/src/router/libdisk/Makefile
patch -i $ASUSWRT_PATCHES_DIR/Makefile_libdisk_arm.patch $ASUSWRT_REPO_DIR/release/src/router/libdisk/Makefile

##router/ntpclient
#cp -vf $ASUSWRT_PATCHES_DIR/ntpclient.c $ASUSWRT_REPO_DIR/release/src/router/ntpclient/ntpclient.c
patch -i $ASUSWRT_PATCHES_DIR/ntpclient.c.patch $ASUSWRT_REPO_DIR/release/src/router/ntpclient/ntpclient.c

##router/rstats
#cp -vf $ASUSWRT_PATCHES_DIR/Makefile_rstats_arm $ASUSWRT_REPO_DIR/release/src/router/rstats/Makefile
patch -i $ASUSWRT_PATCHES_DIR/Makefile_rstats_arm.patch $ASUSWRT_REPO_DIR/release/src/router/rstats/Makefile

##router/cstats
#cp -vf $ASUSWRT_PATCHES_DIR/Makefile_cstats_arm $ASUSWRT_REPO_DIR/release/src/router/cstats/Makefile
patch -i $ASUSWRT_PATCHES_DIR/Makefile_cstats_arm.patch $ASUSWRT_REPO_DIR/release/src/router/cstats/Makefile

##router/LPRng
#cp -vf $ASUSWRT_PATCHES_DIR/Makefile_LPRng_arm $ASUSWRT_REPO_DIR/release/src/router/LPRng/src/Makefile
patch -i $ASUSWRT_PATCHES_DIR/Makefile_LPRng_arm.patch $ASUSWRT_REPO_DIR/release/src/router/LPRng/src/Makefile

##router/hotplug2
patch -i $ASUSWRT_PATCHES_DIR/mem_utils.c.patch $ASUSWRT_REPO_DIR/release/src/router/hotplug2/mem_utils.c
patch -i $ASUSWRT_PATCHES_DIR/hotplug2_utils.c.patch $ASUSWRT_REPO_DIR/release/src/router/hotplug2/hotplug2_utils.c

##router/ffmpeg
patch -i $ASUSWRT_PATCHES_DIR/h264dsp_init_arm.c.patch $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/router/ffmpeg/libavcodec/arm/h264dsp_init_arm.c
patch -i $ASUSWRT_PATCHES_DIR/h264pred_init_arm.c.patch $ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/router/ffmpeg/libavcodec/arm/h264pred_init_arm.c

## patch because of newer awk in Artix; Makefile.in need to be patched not Makefile.am (not used)!
patch -p1 -d$ASUSWRT_REPO_DIR/release/src/router/libgpg-error-1.10 < $ASUSWRT_PATCHES_DIR/libgpg-error.patch 
patch -p1 -d$ASUSWRT_REPO_DIR/release/src/router/libgpg-error-1.10 < $ASUSWRT_PATCHES_DIR/001-gcc5_libgpg-error2.patch

##router/samba-3.5.8
#cp -vf $ASUSWRT_PATCHES_DIR/configure_samba-3.5.8 $ASUSWRT_REPO_DIR/release/src/router/samba-3.5.8/source3/configure
patch -i $ASUSWRT_PATCHES_DIR/configure_samba-3.5.8.patch $ASUSWRT_REPO_DIR/release/src/router/samba-3.5.8/source3/configure

## if Makefile.in exists, autotools insists on automake 1.15, without Makefile.in it uses existing host version of automake
rm -f $ASUSWRT_REPO_DIR/release/src/router/wget/Makefile.in

## needed for gcc 10
patch -p1 -d$ASUSWRT_REPO_DIR/release/src/router/config < $ASUSWRT_PATCHES_DIR/config_gcc10.patch

## needed for autoconf2.70
patch -i $ASUSWRT_PATCHES_DIR/libxml2_configure.in.patch $ASUSWRT_REPO_DIR/release/src/router/libxml2/configure.in

cd release/src-rt-6.x.4708 
time make rt-ac68u   ## e.g. for ac56u 
