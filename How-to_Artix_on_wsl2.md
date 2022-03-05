On Windows 10 open Command Prompt or PowerShell and type:

	$ mkdir %USERPROFILE%\wsl\artix

	$ cd %USERPROFILE%\wsl\artix

	$ curl -LJO https://github.com/hdk5/ArtixWSL/releases/download/latest/Artix-runit.zip

	$ tar -xf Artix-runit.zip

	$ wsl --import artix artix-rootfs.tar.gz

	$ ./artix

(rem.: Of course, the creation of artix-rootfs.tar.gz by using rootfs.img of official Artix-iso is also possible. See at end of file.

But even using smallest iso (base-iso without any desktop environment) results in bigger roots.tar.gz than that of https://github.com/hdk5/ArtixWSL)

An automatic switch to Linux OS follows. 
 
 Go on typing: 
   
	[<PC_NAME> Artix]# pacman-key --init

	[<PC_NAME> Artix]# pacman-key --populate archlinux artix

	[<PC_NAME> Artix]# pacman -Syu

	[<PC_NAME> Artix]# pacman -S sudo nano make gcc which autoconf automake pkgconf patch bison flex cmake rpcsvc-proto gperf python intltool re2c diffutils

	[<PC_NAME> Artix]# nano /etc/pacman.conf  

Enable multilib repository by uncomment these two lines of [multilib] section of pacman.conf:
	
			 [multilib]
	
			 Include = /etc/pacman.d/mirrorlist
Save file and exit nano.

Go on typing: 
					 
	[<PC_NAME> Artix]# pacman -Syy

	[<PC_NAME> Artix]# pacman -S sudo lib32-glibc lib32-gcc-libs lib32-zlib lib32-libelf git wget

	[<PC_NAME> Artix]# nano /etc/wsl.conf  

Append following two lines at end of wsl.conf:
					
			 [interop]
					 
			 appendWindowsPath=false
					 
Save file and exit nano.

Go on typing: 

	[<PC_NAME> Artix]# echo "%wheel ALL=(ALL)  ALL" > /etc/sudoers.d/01wheel

	[<PC_NAME> Artix]# useradd -m -G wheel \<username>

	[<PC_NAME> Artix]# passwd \<username>

	[<PC_NAME> Artix]# ln -s /usr/lib/libmpc.so /usr/lib/libmpc.so.2

	[<PC_NAME> Artix]# ln -s /usr/lib/libmpfr.so /usr/lib/libmpfr.so.4

	[<PC_NAME> Artix]# exit

Rem.: An automatic switch to Windows 10 OS follows.

Go on typing:
   
	$ artix config --default-user \<username>

	$ ./artix

 Rem.: An automatic switch to Linux OS follows.
 
 Go on typing:
  
	[<username>@<PC_NAME> ~]$ git clone https://github.com/john9527/asuswrt-merlin

	[<username>@<PC_NAME> ~]$ git clone https://github.com/st-ty1/Artix_Asuswrt-Merlin_John_fork Artix_asuswrt
	
	[<username>@<PC_NAME> ~]$ cd Artix_asuswrt

	[<username>@<PC_NAME> Artix_asuswrt]$ chmod 744 *.sh

	[<username>@<PC_NAME> Artix_asuswrt]$ ./build_asuswrt-mips.sh (or ./build_asuswrt-mips.sh)

The building process will start.

---------------------------------

Rem.:

If you want to create rootfs.tar.gz by your own using rootfs.img of official Artix-iso, than go on in Windows 10 as follows:
 - Download squashfs-tools-ng-1.0.3-mingw64.zip at https://infraroot.at/pub/squashfs/windows. Extract archive into a squashfs-tools-ng-1.0.3-mingw64 folder.
 - Download artix-base-openrc-YYYYMMDD-x86_64.iso at https://iso.artixlinux.org/weekly-isos.php .
 - Mount the iso-file within Windows Explorer.
 - Copy /LiveOS/rootfs.img of mounted iso-file into the /bin-subfolder of squashfs-tools-ng-1.0.3-mingw64 directory.
 - Open Windows Command Prompt and change to bin-subfolder in the extracted squashfs-tools-ng-1.0.3-mingw64 directory. 
 - Run in Windows Command Prompt: sqfs2tar rootfs.img artix-rootfs.tar
 - Compress artix-rootfs.tar to artix-rootfs.tar.gz by 7-zip.  
 - Copy generated rootfs.tar.gz to your start directory (%USERPROFILE%\wsl\artix). 
 - Continue at line "$ wsl --import artix artix-rootfs.tar.gz" as described above.
