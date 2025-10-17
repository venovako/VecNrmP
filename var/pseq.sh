#!/bin/bash
source ./env.sh
cd ../src
for O in dnp dup
do
	echo -n "Running ${O}.sh ... "
	../var/${O}.sh
	echo "done"
	mv -fv ${O}*.out ${O}*.err ../var
done
cd ../var
unset O
