#!/bin/bash
source ./env.sh
cd ../src
for O in dnp dup
do
	echo -n "Running ${O}.sh with $1 workers ... "
	../var/${O}.sh $1
	echo "done"
	mv -fv ${O}*.out ${O}*.err ../var
done
cd ../var
unset O
