#!/bin/bash
# !!! has to be run from this directory !!!
if [ -z "${GNU}" ]
then
	echo "GNU=suffix ./build_gcc-mac.sh"
else
	cd ../../libpvn/src
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=SV2,NRM VECLEN=32 GMP=/opt/gmp MPFR=/opt/mpfr SLEEF=/opt/sleef clean
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=SV2,NRM VECLEN=32 GMP=/opt/gmp MPFR=/opt/mpfr SLEEF=/opt/sleef -j all
	cd ../../VecNrmP/src
	make LAPACK=${HOME}/lapack clean
	make LAPACK=${HOME}/lapack -j all
	cd ../var
fi
