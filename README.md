# Building Asuswrt-Merlin [John's fork] on Artix (Arch-Linux fork)

---- tested with 374.43_44EAj9527 ----


For building asuswrt-merlin on Artix, first clone asuswrt-Merlin (Johns fork) repo (https://github.com/john9527/asuswrt-merlin) into your HOME directory. 

Following steps are needed to make build process successful:

1. Install the Artix-packages as mentioned in file needed_packages_on_Artix.txt. 

2. Clone this repo into your HOME directory:

    git clone https://github.com/st-ty1/Artix_Asuswrt-Merlin_John_fork asuswrt_artix

3. About 80 files are missing within wget-folder (/release/src/router/wget) of auswrt-merlin (John fork) repo: 
    Download wget-1.19.5 (https://ftp.gnu.org/gnu/wget/wget-1.19.5.tar.gz) and extract it to a first subfolder of your local repo folder (see step 2.) 
    
4. Makefile.org is missing within openssl-1.0-folder (/release/src/router/openssl-1.0) of auswrt-merlin (John fork) repo: 
    Download openssl-1.0.2u (https://ftp.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz) and extract it to a second subfolder of your local repo folder.
    
5. Makefile is missing within pptpd/plugins-folder (/release/src/router/pptpd/plugins) of auswrt-merlin (John fork) repo: 
    Download pptpd-1.3.4 (https://sourceforge.net/projects/poptop/files/pptpd/pptpd-1.3.4/pptpd-1.3.4.tar.gz) and extract it to a third subfolder of your local repo folder.
    
6. only ARM-builds: wlconf is missing in release/src/router/wlconf_arm/prebuilt: Download wlconf from Asuswrt-merlin github repo of RMerlin (https://github.com/RMerl/asuswrt-merlin) and save it to your local repo folder (step 2). 

7. only MIPS-builds: Following line has to be inserted in release/src-rt/linux/linux-2.6/scripts/squashfs/mksquashfs.c (because of newer glib in Artix than in Debian9):
     
	             #include <sys/sysmacros.h> 

   An adaquate patch is supplied (mksquashfs.c.patch) in this repo. (see also 13.)

8. A patch is supplied (Makefile.patch) in this repo for all amendments needed in release/src/router/Makefile. The amendments
   are listed in file needed_modifations.txt for further information.

9. Source code of libgpg-error-1.10 has to be patched, as Artix uses newer awk 5.0. Source code of version 1.10 is still 
   for awk 4.x. 
   A patch is supplied (libgpg-error.patch) in this repo.
    
10. Remove Makefile.in in /release/src/router/wget, because GNU autotools of wget insist on automake 1.15, without
    Makefile.in actual automake version of OS is used.
    
11. Delete file desdata.stamp in folder /release/src/router/nettle (as it crashes building process!)

12. Due to change of gcc from version 9.4 to 10.1 on host-OS Artix/Arch linux some old source code in /release/src/router/config (arm + mips) 
    and again mksquashfs.c in /release/src-rt/linux/linux-2.6/scripts/squashfs (only mips) have to be patched (patches supplied in this repo; 
    patch of mksquashfs.c is combined with 8.). 

13. Remove Makefile in /release/src/router/curl (as it crashes building process!)

14. Source code of configure.in in /release/src/router/libxml2 has to be patched, as libxml2 is quite old and uses appropiate aged versions of
    autotools for configuring. A macro in configure.in has to be deacticated. A patch is supplied in this repo.

Enclosed you will find two shell scripts (for mips and arm) for setting path variables, resetting and cleaning your local repo, inserting the needed files (step 3.-6.) and applying needed patches of source code (step 7.-9./12./14.). 
This is the easiest way: Just start the script for MIPS- or ARM-builds (Don't forget to make it executable before!)

Applying these shell scripts is only needed, if you are working with "git clean -dxf" (e.g. 1st build after cloning repo, after updating repo, ...) for cleaning sources. 
By cleaning sources with "make clean", step 3.-10. + 12.-14. are not needed for  anymore. Step 11 has to be done, though. (I don't have tested step 12.-14. yet, if they really can be omitted when using "make clean", but I suppose so.). With using "make clean" you can either amend the scripts or you use make command in appropriate folder (if so, don#t forget to insert path to execs of the toolchain of your local asuswrt-Merlin (Johns fork) repo in your .bashrc)


BR
st-ty1/_st_ty/st_ty_
