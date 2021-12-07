# Building Asuswrt-Merlin [John's fork] on Artix (Arch-Linux fork)

---- tested with 374.43_52E3j9527 ----
Following packages are needed for building  Asuswrt-Merlin [John's fork] on Artix: make, gcc, which, autoconf, automake, pkgconf, patch, bison, flex, cmake, rpcsvc-proto, gperf, python, intltool, re2c and gtk-doc

The precompiled 32-bit host-tools of Asuswrt-Merlin [John's fork] need also following packages: lib32-glibc, lib32-gcc-libs and lib32-zlib (Therefore, don't forget to uncomment the lines of the "Multilib" and the "lib32" section in /etc/pacman.conf).

For generating/editing Artix-specific patches installing of package diffutils should be helpful. If you are working with Artix or Arch Linux on wsl2/Windows then you should also install the nano package or you can use a smart editor on Windows (like Notepad++).

It is recommended to use Artix on wsl2/Windows or as a VM (for both approaches there is a manual in this repo) without (!) any desktop environment or unneeded packages, to keep the needed patches as low as possible. Any additional package, like graphical environments, can make build process more complicate, as execectables on Artix/Arch Linux are build with shared libs, which can mislead the building tools within the Asuswrt-Merlin [John's fork] sources, at worst.

For building asuswrt-merlin on Artix, first clone asuswrt-Merlin (Johns fork) repo (https://github.com/john9527/asuswrt-merlin) into your HOME directory. 

Following steps are needed to make build process successful:

1. Install the Artix-packages as mentioned in file needed_packages_on_Artix.txt. 

2. Clone this repo into your HOME directory:
    
    $ cd $HOME
 
     $ git clone https://github.com/st-ty1/Artix_Asuswrt-Merlin_John_fork Artix_asuswrt
    
      (From now, /$HOME/Artix_asuswrt will be your local repo folder.)

3. About 80 files are missing within wget-folder (/release/src/router/wget) of auswrt-merlin (John fork) repo: 
    Download wget-1.19.5 (https://ftp.gnu.org/gnu/wget/wget-1.19.5.tar.gz) and extract it to a first subfolder of your local repo folder (see step 2.) 
    
4. Makefile.org is missing within openssl-1.0-folder (/release/src/router/openssl-1.0) of auswrt-merlin (John fork) repo: 
    Download openssl-1.0.2u (https://ftp.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz) and extract it to a second subfolder of your local repo folder.
    
5. Makefile is missing within pptpd/plugins-folder (/release/src/router/pptpd/plugins) of auswrt-merlin (John fork) repo: 
    Download pptpd-1.3.4 (https://sourceforge.net/projects/poptop/files/pptpd/pptpd-1.3.4/pptpd-1.3.4.tar.gz) and extract it to a third subfolder of your local repo folder.
    
6. options.h is missing within curl/include/curl folder ((/release/src/router/curl/include/curl) of auswrt-merlin (John fork) repo:
    Download curl 7.76.1 (https://curl.se/download/curl-7.76.1.tar.gz) and extract it to a fourth subfolder of your local repo folder.
    
7. only ARM-builds: wlconf is missing in release/src/router/wlconf_arm/prebuilt: Download wlconf from Asuswrt-merlin github repo of RMerlin (https://github.com/RMerl/asuswrt-merlin) and save it to your local repo folder (see step 2). 

8. only MIPS-builds: Following line has to be inserted in release/src-rt/linux/linux-2.6/scripts/squashfs/mksquashfs.c (because of newer glib in Artix than in Debian9):
     
	             #include <sys/sysmacros.h> 

   An adaquate patch is supplied (mksquashfs.c.patch) in this repo. (see also 13.)

9. A patch is supplied (Makefile.patch) in this repo for all amendments needed in /release/src/router/Makefile. The amendments
   are listed in file needed_modifations.txt for further information.

10. Source code of libgpg-error-1.10 has to be patched, as Artix uses newer awk 5.0. Source code of version 1.10 is still 
   for awk 4.x. A patch is supplied (libgpg-error.patch) in this repo.
    
11. Remove Makefile.in in /release/src/router/wget, because GNU autotools of wget insist on automake 1.15. Without Makefile.in the actual automake version of host-OS is used.

12. Due to change of gcc from version 9.4 to 10.1 on host-OS Artix/Arch linux some old source code in /release/src/router/config (-> config_gcc10.patch) 
    and mksquashfs.c in /release/src-rt/linux/linux-2.6/scripts/squashfs (only mips) have to be patched (-> mksquashfs.c.patch; both patches supplied in this repo). 

13. Host-OS has updated to autoconf-2.70. Source code of configure.in in /release/src/router/libxml2 has to be patched, as libxml2 is quite old and its input files for
    autotools too old, a macro in configure.in has to be deactivated. A patch is supplied in this repo (-> libxml2_configure.in.patch).

Enclosed you will find two shell scripts (for mips and arm) for setting path variables, resetting and cleaning your local repo, inserting the needed files ( after steps 3.-7.), removing the troublesome files (step 11.) and applying the needed patches (step 8.-10./12.-13.) to source code of your local repo. 
So, the easiest way is to just do step 1. to 7. and then start the shell script for MIPS- or ARM-builds (Don't forget to make the script executable before!)

Applying one of these shell scripts is only needed, if you are working with "git clean -dxf" (e.g. 1st build after cloning repo, after updating repo, ...) for cleaning sources. 
By cleaning sources with "make clean", you can either amend the shell scripts (by commenting all the cp-, rm-, and patch-commands) or you can use make command in appropriate folder (if so, don't forget to insert path to the execs of the toolchain of your local asuswrt-Merlin (Johns fork) repo in your .bashrc or .profile)


BR
st-ty1/_st_ty/st_ty_
