On Windows 10 open Command Prompt or PowerShell and type:

$ mkdir %USERPROFILE%\wsl\artix

$ cd %USERPROFILE%\wsl\artix

$ curl -O https://github.com/hdk5/ArtixWSL/releases/download/20200502153634-60934cb/Artix.zip

$ tar -xf Artix.zip

$ wsl --import artix artix-rootfs.tar.gz

$ ./artix

   ------  automatic switch to Linux OS follows -------
   
[PC-NAME Artix]# pacman-key --init

[PC-NAME Artix]# pacman-key --populate archlinux artix

[PC-NAME Artix]# pacman -Syu

[PC-NAME Artix]# pacman -S sudo nano make gcc which autoconf automake pkgconf patch bison flex cmake rpcsvc-proto gperf python intltool re2c diffutils

[PC-NAME Artix]# nano /etc/pacman.conf  # -> enable multilib repository by uncomment these two lines of [multilib] section of pacman.conf
				
				 [multilib]
				 
				 Include = /etc/pacman.d/mirrorlist
				 
					 
[PC-NAME Artix]# pacman -Syy

[PC-NAME Artix]# pacman -S sudo lib32-glibc lib32-gcc-libs lib32-zlib git wget

[PC-NAME Artix]# nano /etc/wsl.conf  # -> append following two lines at end of wsl.conf:
					
					 [interop]
					 
					 appendWindowsPath=false
					 
					 
[PC-NAME Artix]# echo "%wheel ALL=(ALL)  ALL" > /etc/sudoers.d/01wheel

[PC-NAME Artix]# useradd -m -G wheel \<username>

[PC-NAME Artix]# passwd \<username>

[PC-NAME Artix]# ln -s /usr/lib/libmpc.so /usr/lib/libmpc.so.2

[PC-NAME Artix]# ln -s /usr/lib/libmpfr.so /usr/lib/libmpfr.so.4

[PC-NAME Artix]# exit

   ----- automatic switch to Windows 10 OS follows -------
   
$ artix config --default-user \<username>

$ ./artix

   ------ automatic switch to Linux OS follows -------
   
[<username>@PC-NAME ~]$ git clone https://github.com/john9527/asuswrt-merlin

[<username>@PC-NAME ~]$ git clone https://github.com/st-ty1/Artix_Asuswrt-Merlin_John_fork asuswrt_artix

[<username>@PC-NAME ~]$ wget -O wget.tar.gz https://ftp.gnu.org/gnu/wget/wget-1.19.5.tar.gz

[<username>@PC-NAME ~]$ tar -C asuswrt_artix -zxvf wget.tar.gz

[<username>@PC-NAME ~]$ wget -O openssl-1.0.tar.gz https://ftp.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz 

[<username>@PC-NAME ~]$ tar -C asuswrt_artix -zxvf openssl-1.0.tar.gz

[<username>@PC-NAME ~]$ wget -O pptpd.tar.gz https://sourceforge.net/projects/poptop/files/pptpd/pptpd-1.3.4/pptpd-1.3.4.tar.gz

[<username>@PC-NAME ~]$ tar -C asuswrt_artix -zxvf pptpd.tar.gz

[<username>@PC-NAME ~]$ cd asuswrt_artix

[<username>@PC-NAME asuswrt_artix]$ wget -O wlconf https://github.com/RMerl/asuswrt-merlin/blob/master/release/src/router/wlconf_arm/prebuilt/wlconf

[<username>@PC-NAME asuswrt_artix]$ chmod 744 *.sh

[<username>@PC-NAME asuswrt_artix]$ ./build_asuswrt-mips.sh (or ./build_asuswrt-mips.sh)

  
(Of course creation of rootfs.tar.gz by using rootfs.img of official Artix-iso is possible. 
 But even if using smallest iso (base-iso without any desktop environment) results in bigger roots.tar.gz than that of https://github.com/hdk5/ArtixWSL)
