#!/bin/bash
source ./env.sh
cd ../src
export CILK_NWORKERS=$1
for ((I=1;I<=31;++I))
do
	read S
	./nrm2.exe 1073741824 $S 1.33774124342671785e+04 > cilk$I-$1.out 2> cilk$I-$1.err
done
mv -fv cilk*-*.out cilk*-*.err ../var
cd ../var
unset CILK_NWORKERS S I
