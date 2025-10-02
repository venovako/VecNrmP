#!/bin/bash
# !!! has to be run from this directory on Oracle Linux 9 with the static glibc added manually !!!
if [ -z "${TGT}" ]
then
	echo "TGT=target_architecture ./build_icx-ol9.sh"
else
	if [ "${TGT}" != "Host" ]
	then
		cd ../../libpvn/src
		scl enable gcc-toolset-14 "make COMPILER=icx NDEBUG=3 SAFE=SV2,NRM GMP=/opt/gmp MPFR=/opt/mpfr MARCH=${TGT} STATIC=-s clean all"
		rm -frv ../../dist
		mkdir -pv ../../dist/libpvn
		mv -fv libpvn.* pvn*.exe ../etc/gen_cbar.exe ../../dist/libpvn
		scl enable gcc-toolset-14 "make COMPILER=icx NDEBUG=3 SAFE=SV2,NRM GMP=/opt/gmp MPFR=/opt/mpfr STATIC=-s clean all"
		cp -fv ../../dist/libpvn/libpvn.* .
		cd ../../VecNrmP/src
		scl enable gcc-toolset-14 "make LAPACK=../../lapack MARCH=${TGT} clean all"
		mkdir -pv ../../dist/VecNrmP
		cp -fv *.exe ../../dist/VecNrmP
		cd ../..
		rm -fv dist.tar*
		tar cvf dist.tar dist
		xz -zv9e dist.tar
		cd VecNrmP/var
	else
		echo "Please build the usual way."
	fi
fi
