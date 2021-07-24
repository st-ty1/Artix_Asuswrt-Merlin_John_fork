On Windows 10 open Command Prompt or PowerShell and type:

	$ mkdir %USERPROFILE%\wsl\artix

	$ cd %USERPROFILE%\wsl\artix

	$ curl -LJO https://github.com/hdk5/ArtixWSL/releases/download/20210114175009-0a7d8e5/Artix.zip

	$ tar -xf Artix.zip

	$ wsl --import artix artix-rootfs.tar.gz

	$ ./artix

(rem.: Of course, the creation of artix-rootfs.tar.gz by using rootfs.img of official Artix-iso is also possible. 

But even using smallest iso (base-iso without any desktop environment) results in bigger roots.tar.gz than that of https://github.com/hdk5/ArtixWSL)

An automatic switch to Linux OS follows. 
 
 Go on typing: 
   
	[PC-NAME Artix]# pacman-key --init

	[PC-NAME Artix]# pacman-key --populate archlinux artix

	[PC-NAME Artix]# pacman -Syu

	[PC-NAME Artix]# pacman -S sudo nano make gcc which autoconf automake pkgconf patch bison flex cmake rpcsvc-proto gperf python intltool re2c diffutils

	[PC-NAME Artix]# nano /etc/pacman.conf  

Enable multilib repository by uncomment these two lines of [multilib] section of pacman.conf:
	
			 [multilib]
	
			 Include = /etc/pacman.d/mirrorlist
Save file and exit nano.

Go on typing: 
					 
	[PC-NAME Artix]# pacman -Syy

	[PC-NAME Artix]# pacman -S sudo lib32-glibc lib32-gcc-libs lib32-zlib lib32-libelf git wget

	[PC-NAME Artix]# nano /etc/wsl.conf  

Append following two lines at end of wsl.conf:
					
			 [interop]
					 
			 appendWindowsPath=false
					 
Save file and exit nano.

Go on typing: 

	[PC-NAME Artix]# echo "%wheel ALL=(ALL)  ALL" > /etc/sudoers.d/01wheel

	[PC-NAME Artix]# useradd -m -G wheel \<username>

	[PC-NAME Artix]# passwd \<username>

	[PC-NAME Artix]# ln -s /usr/lib/libmpc.so /usr/lib/libmpc.so.2

	[PC-NAME Artix]# ln -s /usr/lib/libmpfr.so /usr/lib/libmpfr.so.4

	[PC-NAME Artix]# exit

Rem.: An automatic switch to Windows 10 OS follows.

Go on typing:
   
	$ artix config --default-user \<username>

	$ ./artix

 Rem.: An automatic switch to Linux OS follows.
 
 Go on typing:
  
	[<username>@PC-NAME ~]$ git clone https://github.com/john9527/asuswrt-merlin

	[<username>@PC-NAME ~]$ git clone https://github.com/st-ty1/Artix_Asuswrt-Merlin_John_fork Artix_asuswrt

	[<username>@PC-NAME ~]$ wget -O wget.tar.gz https://ftp.gnu.org/gnu/wget/wget-1.19.5.tar.gz

	[<username>@PC-NAME ~]$ tar -C Artix_asuswrtx -zxvf wget.tar.gz

	[<username>@PC-NAME ~]$ wget -O openssl-1.0.tar.gz https://ftp.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz 

	[<username>@PC-NAME ~]$ tar -C Artix_asuswrt -zxvf openssl-1.0.tar.gz

	[<username>@PC-NAME ~]$ wget -O pptpd.tar.gz https://sourceforge.net/projects/poptop/files/pptpd/pptpd-1.3.4/pptpd-1.3.4.tar.gz

	[<username>@PC-NAME ~]$ tar -C Artix_asuswrt -zxvf pptpd.tar.gz
	
	[<username>@PC-NAME ~]$ wget -O curl-7.76.1.tar.gz https://curl.se/download/curl-7.76.1.tar.gz
	
	[<username>@PC-NAME ~]$ tar -C Artix_asuswrt -zxvf curl-7.76.1.tar.gz
	
	[<username>@PC-NAME ~]$ cd Artix_asuswrt

	[<username>@PC-NAME Artix_asuswrt]$ wget -O wlconf https://github.com/RMerl/asuswrt-merlin/blob/master/release/src/router/wlconf_arm/prebuilt/wlconf?raw=true

	[<username>@PC-NAME Artix_asuswrt]$ chmod 744 *.sh

	[<username>@PC-NAME Artix_asuswrt]$ ./build_asuswrt-mips.sh (or ./build_asuswrt-mips.sh)

The building process will start.
