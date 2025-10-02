#!/bin/bash
# !!! has to be run from this directory !!!
if [ -z "${GNU}" ]
then
	echo "GNU=suffix ./build_gcc-mac.sh"
else
	cd ../../libpvn/src
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=SV2,NRM GMP=/opt/gmp MPFR=/opt/mpfr clean
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=SV2,NRM GMP=/opt/gmp MPFR=/opt/mpfr -j all
	cd ../../VecNrmP/src
	make LAPACK=${HOME}/lapack GNU=${GNU} clean
	make LAPACK=${HOME}/lapack GNU=${GNU} -j all
	cd ../var
fi
