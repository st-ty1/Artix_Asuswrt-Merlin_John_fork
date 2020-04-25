# Building Asuswrt-Merlin [John's fork] on Artix (Arch-Linux fork)
---- tested with 374.43_43E6j9527 ----

For building asuswrt-merlin on Artix, first clone asuswrt-Merlin (Johns fork) repo (https://github.com/john9527/asuswrt-merlin). 

Following steps are needed to make build process successful:

1. Install the Artix-packages as mentioned in file needed_packages_on_Artix.txt. 

2. Create a new folder in your user directory and download this repo into this folder.

3. About 80 files are missing within wget-folder (/release/src/router/wget) of auswrt-merlin (John fork) repo: 
    Download wget-1.19.5 (https://ftp.gnu.org/gnu/wget/wget-1.19.5.tar.gz) and extract it to a first subfolder of your local repo folder (see step 2.) 
    
4. Makefile.org is missing within openssl-1.0-folder (/release/src/router/openssl-1.0) of auswrt-merlin (John fork) repo: 
    Download openssl-1.0.2u (https://ftp.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz) and extract it to a second subfolder of your local repo folder.
    
5. Makefile is missing within pptpd/plugins-folder (/release/src/router/pptpd/plugins) of auswrt-merlin (John fork) repo: 
    Download pptpd-1.3.4 (https://sourceforge.net/projects/poptop/files/pptpd/pptpd-1.3.4/pptpd-1.3.4.tar.gz/download) and extract it to a third subfolder of your local repo folder.
    
6. Some files are missing within nano-folder (/release/src/router/nano) of auswrt-merlin (John fork) repo: 
    Download nano-4.8 (https://ftp.gnu.org/gnu/nano/nano-4.8.tar.gz) and extract it to a forth subfolder of your local repo folder.
    
7. only ARM-builds: wlconf is missing in release/src/router/wlconf_arm/prebuilt: Download wlconf from Asuswrt-merlin github repo of RMerlin (https://github.com/RMerl/asuswrt-merlin) and save it to your local repo folder (step 2). 

8. only MIPS-builds: Following line has to be inserted in release/src-rt-6.x/linux/linux-2.6/scripts/squashfs/mksquashfs.c (because of newer glib in Artix than in Debian9):
     
	             #include <sys/sysmacros.h> 

   An adaquate patch is supplied (mksquashfs.c.patch) in this repo.

9. A patch is supplied (Makefile.patch) in this repo for all amendments needed in release/src/router/Makefile. The amendments are listed in file needed_modifations.txt for further information.

10. Source code of libgpg-error-1.10 has to be patched, as Artix uses newer awk 5.0. Source code of version 1.10 is still for awk 4.x. 
    A patch is supplied (libgpg-error.patch) in this repo.
    
11. Delete file desdata.stamp in folder /release/src/router/nettle (as it crashes building process!)


Enclosed you will find two shell scripts (for mips and arm) for setting path variables, resetting and cleaning your local repo, inserting the needed files (step 3.-7.) and applying needed patches of source code (step 8.-10.). 
This is the easiest way: Just start the script for MIPS- or ARM-builds (Don't forget to make it executable before!)

Applying these shell scripts is only needed, if you are working with "git clean -dxf" (e.g. 1st build after cloning repo, after updating repo, ...) for cleaning sources. 
By cleaning sources with "make clean", these scripts are not needed for step 3.-10. anymore. Step 11 has to be done, though.


BR
st-ty1/_st_ty/st_ty_
