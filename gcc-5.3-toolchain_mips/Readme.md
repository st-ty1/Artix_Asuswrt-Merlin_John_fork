New toolchain for asuswrt-mips (John's fork) with gcc-5.3.0 and binutils-2.25.1

All patches for asuswrt-mips sources are enclosed in this repo. The patches are needed as the new toolchain is more sensitive to "inaccuracy" in source code.
Start with shell script build_asuswrt-mips-2016_02_RT-AC.sh (for RT-N66U and RT-AC66U) or build_asuswrt-mips-2016_02_RT-N.sh (for RT-N16U).
Not yet tested with any of thes ASUS mips routers !!! 

This toolchain is built with uclibc 0.9.32.1, i.e. yet without NPTL, but seems no issue to replace this uclibc version also by a newer version (0.9.33).
gcc-5.3 can be build with a go-compiler (currently included only C-, C++  - and Fortran-compiler.)

BR
st-ty1/st_ty_
