#! /bin/sh

ASUSWRT_REPO_DIR=$HOME/asuswrt-merlin  ## path to your local "Asuswrt-Merlin_John_fork" repo
ASUSWRT_PATCHES_DIR=$HOME/asuswrt_artix  ## path to your local "Artix_Asuswrt-Merlin_John_fork" repo

PATH="$PATH:$ASUSWRT_REPO_DIR/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin"

cd $ASUSWRT_REPO_DIR 
git clean -dxf && git reset --hard
##git pull
git checkout 374.43_2-update

clear

## incomplete data in sources of asuswrt_johns fork
cp $ASUSWRT_PATCHES_DIR/pptpd-1.3.4/plugins/Makefile $ASUSWRT_REPO_DIR/release/src/router/pptpd/plugins/Makefile
cp $ASUSWRT_PATCHES_DIR/openssl-1.0.2u/Makefile.org $ASUSWRT_REPO_DIR/release/src/router/openssl-1.0
cp -r $ASUSWRT_PATCHES_DIR/wget-1.19.5/* $ASUSWRT_REPO_DIR/release/src/router/wget/
cp $ASUSWRT_PATCHES_DIR/wlconf $ASUSWRT_REPO_DIR/release/src/router/wlconf_arm/prebuilt
cp -v $ASUSWRT_PATCHES_DIR/cipher-negotiation.rst $ASUSWRT_REPO_DIR/release/src/router/openvpn/doc/man-sections/

## patch because of newer awk in Artix; Makefile.in need to be patched not Makefile.am (not used)!
patch -p1 -d$ASUSWRT_REPO_DIR/release/src/router/libgpg-error-1.10 < $ASUSWRT_PATCHES_DIR/libgpg-error.patch 

## if Makefile.in exists, autotools insists on automake 1.15, without Makefile.in it uses existing automake version
rm -f $ASUSWRT_REPO_DIR/release/src/router/wget/Makefile.in

#patch -i $ASUSWRT_PATCHES_DIR/Makefile.patch $ASUSWRT_REPO_DIR/release/src/router/Makefile
cp -v $ASUSWRT_PATCHES_DIR/Makefile $ASUSWRT_REPO_DIR/release/src/router/Makefile

rm -f $ASUSWRT_REPO_DIR/release/src/router/nettle/desdata.stamp

## conflict of older gnulib m4 script with newest autoconf
#rm -vf $ASUSWRT_REPO_DIR/release/src/router/nano/m4/std-gnu11.m4
patch -i $ASUSWRT_PATCHES_DIR/std-gnu11.m4.patch $ASUSWRT_REPO_DIR/release/src/router/nano/m4/std-gnu11.m4
#cp -v $ASUSWRT_PATCHES_DIR/std-gnu11.m4_mod $ASUSWRT_REPO_DIR/release/src/router/nano/m4/std-gnu11.m4

## due to use of gcc-10
patch -p1 -d$ASUSWRT_REPO_DIR/release/src/router/config < $ASUSWRT_PATCHES_DIR/config_gcc10.patch

## use of too old autoconf macro, which crashes
patch -i $ASUSWRT_PATCHES_DIR/libxml2_configure.in.patch $ASUSWRT_REPO_DIR/release/src/router/libxml2/configure.in

cd release/src-rt-6.x.4708 && make rt-ac56u   ## e.g. for ac56u 
