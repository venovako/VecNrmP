#!/bin/bash
# !!! has to be run from this directory !!!
if [ -z "${GNU}" ]
then
	echo "GNU=suffix ./build_gcc-host.sh"
else
	cd ../../libpvn/src
	make COMPILER=gcc COMPILER_SUFFIX=${GNU} NDEBUG=3 SAFE=ev2,jv2,sv2,nrm GMP=$HOME/gnu MPFR=$HOME/gnu LAPACK=${HOME}/lapack clean all
	cd ../../VecNrmP/src
	make GNU=${GNU} clean all
	cd ../var
fi
