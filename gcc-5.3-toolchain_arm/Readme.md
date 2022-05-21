New toolchain for asuswrt-arm (John's fork) with gcc-5.3.0 and binutils-2.25.1

All patches for building firmware from asuswrt-arm sources are enclosed in this repo. The patches are needed as the new toolchain is more sensitive to "inaccuracy" in source code.

First build toolchain according to Readme.txt in subfolder, or extract prebuilt toolchain archive toolchain_5.3_0.9.32_2.25.1_arm_auswrt.tar.xz into newly created folder $HOME/buildroot-2016.02_arm_asuswrt/output/host.

Then start shell script build_asuswrt-arm-2016_02.sh.
Not yet tested with Asus RT-AC56U/AC68U!!!!

This toolchain is built with uclibc 0.9.32.1, i.e. yet without NPTL, but seems no issue to replace this uclibc version also by a newer version (0.9.33).
gcc-5.3 can be build with a go-compiler (currently included only C-, C++  - and Fortran-compiler.)

BR
st-ty1/st_ty_
