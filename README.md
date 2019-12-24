# Artix_Asuswrt-[John's fork]
For building asuswrt-merlin under Artix, first clone asuswrt-Merlin (Johns fork) repo.
Then follow these steps:
1.) Install the Artix-packages as mentioned in needed_packages_on_Artix.txt
2.) About 80 files are missing within wget-folder of auswrt-merlin (John fork) repo: 
    Download wget-1.19.5 (https://ftp.gnu.org/gnu/wget) and replace complete wget-folder in your local repo (/release/src/router/wget)
3.) only ARM-builds: wlconf is missing in release/src/router/wlconf_arm/prebuilt: Download wlconf from Asuswrt-merlin github repo of RMerlin (https://github.com/RMerl/asuswrt-merlin) and save it to a separate subfolder of your home-directory (e.g. documents/asuswrt). 
4.) The Makefile of openssl in release/src/router/openssl has to be removed.
5.) only MIPS-builds: Following line has to be inserted in release/src-rt-6.x/linux/linux-2.6/scripts/squashfs/mksquashfs.c (because of newer glib 
     in Artix than in Debian9):
	             #include <sys/sysmacros.h> 
    A adaquate patch is supplied (mksquashfs.c.patch)
6.) A patch is supplied (Makefile.patch) for the amendments needed in release/src/router/Makefile. These amendments are listed in file needed_modifations.txt
7.) Source code of libgpg-error-1.10 has to be patched, as Artix uses newer awk 5.0. Source code of version 1.10 is still for awk 4.x. 
    A patch is supplied (libgpg-error.patch) 

Enclosed you will find two shell scripts (for mips and arm) for setting path variables, resetting and cleaning your local repo, inserting the needed mods of source code (2.-6.)
If you will use them, don't forget to make them executable.
If you dont want to use these shell scripts, please remember to clean sources only with "git clean -dxf". Cleaning with "make clean" leads to error at target openssl.  

BR
st-ty1/_st_ty/st_ty_
