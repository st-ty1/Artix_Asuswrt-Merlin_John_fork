#! /bin/sh

 ## path to your local "Asuswrt-Merlin_John_fork" repo
ASUSWRT_REPO_DIR=$HOME/asuswrt-merlin   

## path to your local copy of this repo
ASUSWRT_PATCHES_DIR=$HOME/Dokumente/buildroot-2016.02/asuswrt_mips  

## path to mips-toolchain with gcc 5.3 and binutils 2.23.2
ASUSWRT_TOOLCHAIN_DIR=$HOME/buildroot-2016.02_mips_asuswrt/output/host

export PATH=$ASUSWRT_REPO_DIR/tools/brcm/K26/hndtools-mipsel-uclibc-5.3/usr/bin:$PATH

cd $ASUSWRT_REPO_DIR 
git clean -dxf
git reset --hard
#git pull

git checkout 374.43_2-update

clear

### insert new toolchain
rm -rf  $ASUSWRT_REPO_DIR/tools/brcm/K26/hndtools-mipsel-uclibc-4.2.4
rm -rf  $ASUSWRT_REPO_DIR/tools/brcm/K26/hndtools-mipsel-linux-uclibc-4.2.3
mkdir -p $ASUSWRT_REPO_DIR/tools/brcm/K26/hndtools-mipsel-uclibc-5.3/usr
cp -rf $ASUSWRT_TOOLCHAIN_DIR/usr/* $ASUSWRT_REPO_DIR/tools/brcm/K26/hndtools-mipsel-uclibc-5.3/usr


### kernel built-in
## turn off warnings "... not used"
patch -i $ASUSWRT_PATCHES_DIR/Makefile_linux.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/Makefile
patch -p1 -d$ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6 < $ASUSWRT_PATCHES_DIR/linux-2.6.32.60-gcc5.patch

patch -i $ASUSWRT_PATCHES_DIR/mksquashfs.c.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/scripts/squashfs/mksquashfs.c

## binutils >=2.24 differentiate much more between soASUSWRT-float and hard-float; adapted from https://marc.info/?l=linux-mips&m=141302219906796&w=2
patch -i $ASUSWRT_PATCHES_DIR/r4k_fpu.S.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/arch/mips/kernel/r4k_fpu.S
patch -i $ASUSWRT_PATCHES_DIR/r4k_switch.S.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/arch/mips/kernel/r4k_switch.S
patch -i $ASUSWRT_PATCHES_DIR/genex.S.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/arch/mips/kernel/genex.S
patch -i $ASUSWRT_PATCHES_DIR/branch.c.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/arch/mips/kernel/branch.c
patch -i $ASUSWRT_PATCHES_DIR/mipsregs.h.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/include/asm-mips/mipsregs.h
patch -i $ASUSWRT_PATCHES_DIR/fpregdef.h.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/include/asm-mips/fpregdef.h
patch -i $ASUSWRT_PATCHES_DIR/asmmacro-32.h.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/include/asm-mips/asmmacro-32.h
patch -i $ASUSWRT_PATCHES_DIR/Makefile_arch-mips.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/arch/mips/Makefile

## "alias"-functions not allowed anymore in binutils 2.23 - both patch versions similar to  https://patchwork.linux-mips.org/patch/3866
patch -i $ASUSWRT_PATCHES_DIR/page.c.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/arch/mips/mm/page.c
patch -i $ASUSWRT_PATCHES_DIR/uasm.h.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/arch/mips/mm/uasm.h
patch -i $ASUSWRT_PATCHES_DIR/uasm.c.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/arch/mips/mm/uasm.c

patch -i $ASUSWRT_PATCHES_DIR/Makefile_mm_2.6.26.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/arch/mips/mm/Makefile
patch -i $ASUSWRT_PATCHES_DIR/war.h.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/include/asm-mips/war.h
patch -i $ASUSWRT_PATCHES_DIR/bugs.h.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/include/asm-mips/bugs.h
patch -i $ASUSWRT_PATCHES_DIR/cpu-features.h.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/include/asm-mips/cpu-features.h
patch -i $ASUSWRT_PATCHES_DIR/page-funcs.S.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/arch/mips/mm/page-funcs.S
patch -i $ASUSWRT_PATCHES_DIR/mips_ksyms.c.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/arch/mips/kernel/mips_ksyms.c

## compressed kernel 
patch -i $ASUSWRT_PATCHES_DIR/bzip2_inflate.c_RT-AC.patch $ASUSWRT_REPO_DIR/release/src-rt-6.x/shared/bzip2_inflate.c

## lzma-loader
patch -i $ASUSWRT_PATCHES_DIR/head.S.patch $ASUSWRT_REPO_DIR/release/src/lzma-loader/head.S
patch -i $ASUSWRT_PATCHES_DIR/Makefile_lzma-loader.patch $ASUSWRT_REPO_DIR/release/src/lzma-loader/Makefile

#### userland
## router/Makefiles
patch -i $ASUSWRT_PATCHES_DIR/Makefile $ASUSWRT_REPO_DIR/release/src/router/Makefile
patch -i $ASUSWRT_PATCHES_DIR/platform.mak $ASUSWRT_REPO_DIR/release/src-rt/platform.mak
patch -i $ASUSWRT_PATCHES_DIR/common.mak $ASUSWRT_REPO_DIR/release/src/router/common.mak

## router/shared
patch -i $ASUSWRT_PATCHES_DIR/shutils.h.patch $ASUSWRT_REPO_DIR/release/src/router/shared/shutils.h

## router/rc
patch -i $ASUSWRT_PATCHES_DIR/ctype.h.patch $ASUSWRT_REPO_DIR/tools/brcm/K26/hndtools-mipsel-uclibc-5.3/usr/mipsel-brcm-linux-uclibc/sysroot/usr/include/ctype.h

## router/nvram
patch -i $ASUSWRT_PATCHES_DIR/Makefile_nvram.patch $ASUSWRT_REPO_DIR/release/src/router/nvram/Makefile

## router/libdisk
patch -i $ASUSWRT_PATCHES_DIR/Makefile_libdisk $ASUSWRT_REPO_DIR/release/src/router/libdisk/Makefile

## router/ntpclient
patch -i $ASUSWRT_PATCHES_DIR/Makefile_ntpclient.patch $ASUSWRT_REPO_DIR/release/src/router/ntpclient/Makefile
patch -i $ASUSWRT_PATCHES_DIR/ntpclient.c.patch $ASUSWRT_REPO_DIR/release/src/router/ntpclient/ntpclient.c

## router/rstats
patch -i $ASUSWRT_PATCHES_DIR/Makefile_rstats.patch $ASUSWRT_REPO_DIR/release/src/router/rstats/Makefile

## router/cstats
patch -i $ASUSWRT_PATCHES_DIR/Makefile_cstats.patch $ASUSWRT_REPO_DIR/release/src/router/cstats/Makefile

## router/u2ec
patch -i $ASUSWRT_PATCHES_DIR/Makefile_u2ec.patch $ASUSWRT_REPO_DIR/release/src/router/u2ec/Makefile

## router/LPRng
patch -i $ASUSWRT_PATCHES_DIR/Makefile_LPRng.patch $ASUSWRT_REPO_DIR/release/src/router/LPRng/src/Makefile

## router/networkmap
patch -i $ASUSWRT_PATCHES_DIR/Makefile_networkmap.patch $ASUSWRT_REPO_DIR/release/src/router/networkmap/Makefile

## router/infosvr
patch -i $ASUSWRT_PATCHES_DIR/Makefile_infosvr.patch $ASUSWRT_REPO_DIR/release/src/router/infosvr/Makefile

## router/ez-ipupdate
patch -i $ASUSWRT_PATCHES_DIR/Makefile_ez-ipupdate.patch $ASUSWRT_REPO_DIR/release/src/router/ez-ipupdate/Makefile

## router/hotplug2
patch -i $ASUSWRT_PATCHES_DIR/mem_utils.c.patch $ASUSWRT_REPO_DIR/release/src/router/hotplug2/mem_utils.c
patch -i $ASUSWRT_PATCHES_DIR/hotplug2_utils.c.patch $ASUSWRT_REPO_DIR/release/src/router/hotplug2/hotplug2_utils.c

## libfoo.pl
patch -i $ASUSWRT_PATCHES_DIR/libfoo.pl.patch $ASUSWRT_REPO_DIR/release/src/btools/libfoo.pl

## if Makefile.in exists, autotools insists on automake 1.15, without Makefile.in it uses existing host version of automake
rm -f $ASUSWRT_REPO_DIR/release/src/router/wget/Makefile.in

## needed for gcc 10
patch -p1 -d$ASUSWRT_REPO_DIR/release/src/router/config < $ASUSWRT_PATCHES_DIR/config_gcc10.patch

## needed for autoconf2.70
patch -i $ASUSWRT_PATCHES_DIR/libxml2_configure.in.patch $ASUSWRT_REPO_DIR/release/src/router/libxml2/configure.in


cd release/src-rt-6.x && make rt-ac66u       ## for rt-ac66u 
#cd release/src-rt-6.x && make rt-n66u       ## for rt-n66u 

