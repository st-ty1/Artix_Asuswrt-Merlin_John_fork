# Building Asuswrt-Merlin [John's fork] on Artix (Arch-Linux fork)

---- tested with 374.43_52E7j9527 ----

It is recommended to use a bare version of Artix on wsl2/Windows or as a VM (for both approaches there is a manual in this repo) without(!!) any desktop environment and any package not needed for building process in order to keep the number of needed patches as low as possible. Any additional package, like graphical desktop environments, can make build process more complicate, as all execectables on Artix/Arch Linux are build with shared libs, which can mislead the building tools within the Asuswrt-Merlin [John's fork] sources, at worst.

Following steps are needed to make build process successful:

0. Install following packages which are needed for building Asuswrt-Merlin [John's fork] on Artix:
	make, gcc, which, autoconf, automake, pkgconf, patch, bison, flex, cmake, rpcsvc-proto, gperf, python, intltool and re2c

    The precompiled 32-bit host-tools of Asuswrt-Merlin [John's fork] need following packages: lib32-glibc, lib32-gcc-libs and lib32-zlib. (Therefore, don't forget to uncomment the lines of the "lib32" section in /etc/pacman.conf).
	For generating/editing Artix-specific patches you can also install the diffutils and the nano package. If you are working with Artix/Arch Linux on wsl2/Windows the use of a smart editor on Windows (like Notepad++) is very helpful.

1. Clone asuswrt-Merlin (Johns fork) repo (https://github.com/john9527/asuswrt-merlin) into your HOME directory. 

2. Clone this repo into your HOME directory:
    
    $ cd $HOME
 
    $ git clone https://github.com/st-ty1/Artix_Asuswrt-Merlin_John_fork Artix_asuswrt
       
3. Remove Makefile.in in /release/src/router/wget, because GNU autotools of wget insist on automake 1.15. Without Makefile.in the actual automake version of host-OS can be used.

4. only MIPS-builds: Following line has to be inserted in release/src-rt/linux/linux-2.6/scripts/squashfs/mksquashfs.c (because of newer glib version in Artix than in Debian9):
     
	             #include <sys/sysmacros.h> 

   An adaquate patch (mksquashfs.c.patch) is supplied in this repo.

5. /release/src/router/Makefile has to be patched (Makefile.patch; supplied in this repo). For further information, all amendments are listed in file needed_modifations.txt.

6. Source code of libgpg-error-1.10 has to be patched, as Artix uses newer awk 5.0. Source code of version 1.10 is still for awk 4.x. (-> libgpg-error.patch; supplied in this repo).
    
7. Due to change of gcc to versions >= 10 on host-OS Artix/Arch linux some old source code in /release/src/router/config has to be patched (-> config_gcc10.patch; supplied in this repo). 

8. Host-OS has updated to autoconf version 2.70 and above. Source code of configure.in in /release/src/router/libxml2 has to be patched, as libxml2 is quite old and its input files for
    autotools are too old, so a macro in configure.in has to be deactivated (-> libxml2_configure.in.patch; supplied in this repo).

Enclosed you will find two shell scripts (for mips and arm) for setting path variables, resetting and cleaning your local asuswrt-Merlin (Johns fork) repo and removing the troublesome files (step 3.) and applying the needed patches (step 4.-8.) to your local asuswrt-Merlin (Johns fork) repo. 
So, the easiest way is to just do step 0.-2. and then start the shell script for MIPS- or ARM-builds (Don't forget to make the script executable before!)

Applying one of these shell scripts is only needed, if you are working with "git clean -dxf" (e.g. 1st build after cloning repo, after updating repo, ...) for cleaning sources. 
By cleaning sources with "make clean", you can either amend the shell scripts (by commenting all the cp-, rm-, and patch-commands) or you can use make command in appropriate folder (if so, don't forget to insert path to the execs of the toolchain of your local asuswrt-Merlin (Johns fork) repo in your .bashrc or .profile).


BR
st-ty1/\_st_ty/st_ty\_
