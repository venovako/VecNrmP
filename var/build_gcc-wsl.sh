#!/bin/bash
# !!! has to be run from this directory !!!
if [ -z "${GNU}" ]
then
	echo "GNU=suffix ./build_gcc-wsl.sh"
else
	cd ../../libpvn/src
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=$HOME MPFR=$HOME SLEEF=$HOME clean all
	cd ../../VecNrmP/src
	make LAPACK=../../lapack GNU=${GNU} clean all
	cd ../var
fi
