#!/bin/bash
source ./env.sh
cd ../src
if [ "$2" = "half" ]
then
	for O in ndp udp
	do
		echo -n "Running ${O}.sh with $1 workers ... "
		../var/${O}.sh $1
		echo "done"
		mv -fv ${O}*.out ${O}*.err ../var
	done
else
	for O in dnp dup
	do
		echo -n "Running ${O}.sh with $1 workers ... "
		../var/${O}.sh $1
		echo "done"
		mv -fv ${O}*.out ${O}*.err ../var
	done
fi
cd ../var
unset O
