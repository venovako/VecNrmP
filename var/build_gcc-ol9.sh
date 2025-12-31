#!/bin/bash
# !!! has to be run from this directory on Oracle Linux 9 with the static glibc added manually !!!
if [ -z "${TGT}" ]
then
	echo "TGT=target_architecture ./build_gcc-ol9.sh"
else
	if [ "${TGT}" != "Host" ]
	then
		cd ../../libpvn/src
		scl enable gcc-toolset-14 "make COMPILER=gcc NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=/opt/gmp MPFR=/opt/mpfr SLEEF=/opt/sleef MARCH=${TGT} STATIC=-s clean all"
		cd ../../cgic
		scl enable gcc-toolset-14 "make -f Makefile.pvn clean all"
		cd ../VecNrmP/src
		scl enable gcc-toolset-14 "make MARCH=${TGT} REPROBLAS=/opt/ReproBLAS CGIC=../../cgic clean all"
		rm -frv ../../dist/VecNrmP
		mkdir -pv ../../dist/VecNrmP
		cp -fv *.exe *.cgi ../../dist/VecNrmP
		cd ../..
		rm -fv VecNrmP.tar*
		cd dist
		tar cvf ../VecNrmP.tar VecNrmP
		cd ..
		zstd --single-thread --rm --ultra -22 VecNrmP.tar
		cd VecNrmP/var
	else
		echo "Please build the usual way."
	fi
fi
