#! /bin/sh

ASUSWRT_REPO_DIR=$HOME/asuswrt-merlin    ## path to your local "Asuswrt-Merlin_John_fork" repo
ASUSWRT_PATCHES_DIR=$HOME/asuswrt_artix  ## path to your local copy of this repo

PATH="$PATH:$ASUSWRT_REPO_DIR/tools/brcm/hndtools-mipsel-uclibc/bin:$ASUSWRT_REPO_DIR/tools/brcm/hndtools-mipsel-linux/bin"

cd $ASUSWRT_REPO_DIR 
git clean -dxf
git reset --hard
#git pull

git checkout 374.43_2-update

## missing files
cp $ASUSWRT_PATCHES_DIR/pptpd-1.3.4/plugins/Makefile $ASUSWRT_REPO_DIR/release/src/router/pptpd/plugins/Makefile
cp $ASUSWRT_PATCHES_DIR/openssl-1.0.2u/Makefile.org $ASUSWRT_REPO_DIR/release/src/router/openssl-1.0
cp -r $ASUSWRT_PATCHES_DIR/wget-1.19.5/* $ASUSWRT_REPO_DIR/release/src/router/wget


## patch because of newer awk in Artix; Makefile.in need to be patched not Makefile.am (not used)!
patch -p1 -d$ASUSWRT_REPO_DIR/release/src/router/libgpg-error-1.10 < $ASUSWRT_PATCHES_DIR/libgpg-error.patch 

## if Makefile.in exists, autotools insists on automake 1.15, without Makefile.in it uses existing automake version
rm -f $ASUSWRT_REPO_DIR/release/src/router/wget/Makefile.in

patch -i $ASUSWRT_PATCHES_DIR/Makefile.patch $ASUSWRT_REPO_DIR/release/src/router/Makefile

## needed for gcc 10
patch -p1 -d$ASUSWRT_REPO_DIR/release/src/router/config < $ASUSWRT_PATCHES_DIR/config_gcc10.patch

patch -i $ASUSWRT_PATCHES_DIR/mksquashfs.c.patch $ASUSWRT_REPO_DIR/release/src-rt/linux/linux-2.6/scripts/squashfs/mksquashfs.c

## needed for autoconf2.70
patch -i $ASUSWRT_PATCHES_DIR/libxml2_configure.in.patch $ASUSWRT_REPO_DIR/release/src/router/libxml2/configure.in

#cd release/src-rt && make rt-n16     ## for rt-n16  do not start with rt-n66u from src-rt!
cd release/src-rt-6.x && make rt-ac66u       ## for rt-ac66u 
#cd release/src-rt-6.x && make rt-n66u       ## for rt-n66u 

