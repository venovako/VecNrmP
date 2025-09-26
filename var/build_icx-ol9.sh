#!/bin/bash
# !!! has to be run from this directory on Oracle Linux 9 with the static glibc added manually !!!
if [ -z "${TGT}" ]
then
	echo "TGT=target_architecture ./build_icx-ol9.sh"
else
	if [ "${TGT}" != "Host" ]
	then
		cd ../../libpvn/src
		scl enable gcc-toolset-14 "make COMPILER=icx NDEBUG=3 SAFE=ev2,jv2,sv2,nrm GMP=/opt/gmp MPFR=/opt/mpfr LAPACK=../../lapack MARCH=${TGT} STATIC=-s clean all"
		mkdir -pv ../../dist
		mv -fv libpvn.* pvn*.exe ../etc/gen_cbar.exe ../../dist
		scl enable gcc-toolset-14 "make COMPILER=icx NDEBUG=3 SAFE=ev2,jv2,sv2,nrm GMP=/opt/gmp MPFR=/opt/mpfr LAPACK=../../lapack STATIC=-s clean all"
		cp -fv ../../dist/libpvn.* .
		cd ../../VecNrmP/src
		scl enable gcc-toolset-14 "make MARCH=${TGT} clean all"
		cp -fv *.exe ../../dist
		cd ../..
		rm -fv dist.tar.xz
		tar cvf dist.tar dist
		xz -zv9e dist.tar
		cd VecNrmP/var
	else
		echo "Please build the usual way."
	fi
fi
