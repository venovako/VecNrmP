#!/bin/bash
# !!! has to be run from this directory !!!
if [ -z "${GNU}" ]
then
	echo "GNU=suffix ./build_gcc-host.sh"
else
	cd ../../libpvn/src
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=$HOME/gnu MPFR=$HOME/gnu SLEEF=$HOME/gnu clean all
	cd ../../VecNrmP/src
	make clean all
	cd ../var
fi
