#!/bin/bash
# !!! has to be run from this directory !!!
if [ -z "${GNU}" ]
then
	echo "GNU=suffix ./build_gcc-mac.sh"
else
	cd ../../libpvn/src
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=SV2,NRM VECLEN=32 GMP=/opt/gmp MPFR=/opt/mpfr SLEEF=/opt/sleef clean
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=SV2,NRM VECLEN=32 GMP=/opt/gmp MPFR=/opt/mpfr SLEEF=/opt/sleef -j all
	cd ../../cgic
	make -f Makefile.pvn clean
	make -f Makefile.pvn -j all
	cd ../VecNrmP/src
	make REPROBLAS=/usr/local CGIC=../../cgic clean
	make REPROBLAS=/usr/local CGIC=../../cgic -j all
	cd ../var
fi
