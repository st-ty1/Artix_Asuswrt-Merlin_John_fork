Accelerate build process of asuswrt by ccache
==

1. Start shell and install ccache:
 
		sudo pacman -S ccache

2. Install links

		cd /usr/lib/ccache/bin
	for mips:
	
		sudo ln -s /usr/bin/ccache mipsel-linux-gcc
		sudo ln -s /usr/bin/ccache mipsel-linux-uclibc-gcc
		sudo ln -s /usr/bin/ccache mipsel-linux-uclibc-g++
		sudo ln -s /usr/bin/ccache mipsel-linux-uclibc-c++
		sudo ln -s /usr/bin/ccache mipsel-linux-uclibc-gcc-4.2.4
		
	for arm:
	
		sudo ln -s /usr/bin/ccache arm-brcm-linux-uclibcgnueabi-cc
		sudo ln -s /usr/bin/ccache arm-brcm-linux-uclibcgnueabi-gcc
		sudo ln -s /usr/bin/ccache arm-brcm-linux-uclibcgnueabi-g++
		sudo ln -s /usr/bin/ccache arm-brcm-linux-uclibcgnueabi-c++
		sudo ln -s /usr/bin/ccache arm-brcm-linux-uclibcgnueabi-gcc-4.5.3


3. Start build process of asuswrt with script build_asuswrt-arm.sh or build_asuswrt-mips.sh of this folder.

4. You can start a second shell to check with "ccache -s", if ccache is working.

BR

st-ty1
