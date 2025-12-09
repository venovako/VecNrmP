#!/bin/bash
# !!! has to be run from this directory on Oracle Linux 9 with the static glibc added manually !!!
if [ -z "${TGT}" ]
then
	echo "TGT=target_architecture ./build_gcc-ol9.sh"
else
	if [ "${TGT}" != "Host" ]
	then
		cd ../../libpvn/src
		scl enable gcc-toolset-14 "make COMPILER=gcc NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=/opt/gmp MPFR=/opt/mpfr MARCH=${TGT} STATIC=-s clean all"
		cd ../../VecNrmP/src
		scl enable gcc-toolset-14 "make MARCH=${TGT} REPROBLAS=/opt/ReproBLAS clean all"
		rm -frv ../../dist
		mkdir -pv ../../dist/VecNrmP
		cp -fv *.exe ../../dist/VecNrmP
		cd ../..
		rm -fv dist.tar*
		tar cvf dist.tar dist
		zstd --single-thread --rm --ultra -22 dist.tar
		cd VecNrmP/var
	else
		echo "Please build the usual way."
	fi
fi
