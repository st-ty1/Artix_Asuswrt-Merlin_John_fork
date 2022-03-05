On Windows 10 open Command Prompt or PowerShell and type:

	$ mkdir %USERPROFILE%\wsl\artix

	$ cd %USERPROFILE%\wsl\artix

	$ curl -LJO https://github.com/hdk5/ArtixWSL/releases/download/latest/Artix-runit.zip

	$ tar -xf Artix-runit.zip

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
	
	[<username>@PC-NAME ~]$ cd Artix_asuswrt

	[<username>@PC-NAME Artix_asuswrt]$ wget -O wlconf https://github.com/RMerl/asuswrt-merlin/blob/master/release/src/router/wlconf_arm/prebuilt/wlconf?raw=true

	[<username>@PC-NAME Artix_asuswrt]$ chmod 744 *.sh

	[<username>@PC-NAME Artix_asuswrt]$ ./build_asuswrt-mips.sh (or ./build_asuswrt-mips.sh)

The building process will start.
