#!/bin/bash
# !!! has to be run from this directory !!!
if [ -z "${GNU}" ]
then
	echo "GNU=suffix ./build_gcc-mac.sh"
else
	cd ../../libpvn/src
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=ev2,jv2,sv2,nrm GMP=/opt/gmp MPFR=/opt/mpfr LAPACK=${HOME}/lapack clean
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=ev2,jv2,sv2,nrm GMP=/opt/gmp MPFR=/opt/mpfr LAPACK=${HOME}/lapack -j all
	cd ../../VecNrmP/src
	make GNU=${GNU} clean
	make GNU=${GNU} -j all
	cd ../var
fi
