#!/bin/bash
source ./env.sh
cd ../../libpvn/src
for O in nd ns ud us
do
	echo -n "Running $O.sh ... "
	./$O.sh
	echo "done"
	mv -fv $O.out $O.err ../../VecNrmP/var
done
unset O
