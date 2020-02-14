**13/02/2020: repo of john9527/asuswrt-merlin has been updated from 374.43_39E3j9527 to 374.43_41E8j9527!**

This repo here is still based on version 374.43_39E3j9527.
 An updated version of this repo accoring to 374.43_41E8j9527 version of john9527/asuswrt-merlin repo will follow soon.
 
 Preview:
 
  3.) is still needed
 
  4.) no longer needed
 
  2.), 6.) and 7.) has to checked, if they are still needed or have to be modified

st-ty1/_st_ty/st_ty_


# Building Asuswrt-Merlin [John's fork] with Artix (Arch-Linux fork)
For building asuswrt-merlin under Artix, first clone asuswrt-Merlin (Johns fork) repo (https://github.com/john9527/asuswrt-merlin)

Following steps are needed to make build process successful:

0.) Install the Artix-packages as mentioned in file needed_packages_on_Artix.txt. 

1.) Download this repo to a first folder of your user directory.

2.) About 80 files are missing within wget-folder (/release/src/router/wget) of auswrt-merlin (John fork) repo: 
    Download wget-1.19.5 (https://ftp.gnu.org/gnu/wget) and extract it to a second folder in your user directory. 
    
3.) only ARM-builds: wlconf is missing in release/src/router/wlconf_arm/prebuilt: Download wlconf from Asuswrt-merlin github repo of RMerlin (https://github.com/RMerl/asuswrt-merlin) and save it to the first folder (step 1). 

~~4.) The Makefile of openssl in release/src/router/openssl has to be removed.~~

5.) only MIPS-builds: Following line has to be inserted in release/src-rt-6.x/linux/linux-2.6/scripts/squashfs/mksquashfs.c (because of newer glib 
     in Artix than in Debian9):
     
	             #include <sys/sysmacros.h> 

   An adaquate patch is supplied (mksquashfs.c.patch) in this repo.

6.) A patch is supplied (Makefile.patch) in this repo for all amendments needed in release/src/router/Makefile. The amendments are listed in file needed_modifations.txt for further information.

7.) Source code of libgpg-error-1.10 has to be patched, as Artix uses newer awk 5.0. Source code of version 1.10 is still for awk 4.x. 
    A patch is supplied (libgpg-error.patch) in this repo.
    

Enclosed you will find two shell scripts (for mips and arm) for setting path variables, resetting and cleaning your local repo, inserting the needed files (2.,3.), removing unwanted files (4.) and applying needed mods of source code (5.-7.). 
This is the easiest way: Just start the script for MIPS- or ARM-builds (Don't forget to make it executable before!)

If you dont want to use these shell scripts, please remember to clean sources only with "git clean -dxf". Cleaning with "make clean" leads most likely to an error at Makefile-target openssl.


BR
st-ty1/_st_ty/st_ty_
