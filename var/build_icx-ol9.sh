#!/bin/bash
# !!! HAS TO BE RUN FROM THIS DIRECTORY !!!
if [ "${MARCH}" != "Host" ]
then
	cd ../../libpvn/src
	scl enable gcc-toolset-14 "make COMPILER=icx NDEBUG=3 SAFE=ev2,jv2,sv2,nrm GMP=/opt/gmp MPFR=/opt/mpfr LAPACK=../../lapack MARCH=${MARCH} STATIC=-s clean all"
	mkdir -pv ../../dist
	mv -fv libpvn.* pvn*.exe ../etc/gen_cbar.exe ../../dist
	scl enable gcc-toolset-14 "make COMPILER=icx NDEBUG=3 SAFE=ev2,jv2,sv2,nrm GMP=/opt/gmp MPFR=/opt/mpfr LAPACK=../../lapack STATIC=-s clean all"
	cp -fv ../../dist/libpvn.* .
	cd ../../VecNrmP/src
	if [ -z "${GNU}" ]
	then
		scl enable gcc-toolset-14 "make MARCH=${MARCH} clean all"
	else
		scl enable gcc-toolset-14 "make MARCH=${MARCH} GNU=${GNU} clean all"
	fi
	cp -fv *.exe ../../dist
	cd ../..
	rm -fv dist.tar.xz
	tar cvf dist.tar dist
	xz -zv9e dist.tar
	cd VecNrmP/var
else
	echo "Please build the usual way."
fi
