#!/bin/bash
source ./env.sh
cd ../src
if [ "$1" = "half" ]
then
	for O in nd ns ud us
	do
		echo -n "Running ${O}.sh ... "
		../var/${O}.sh
		echo "done"
		mv -fv ${O}*.out ${O}*.err ../var
	done
else
	for O in dn du sn su
	do
		echo -n "Running ${O}.sh ... "
		../var/${O}.sh
		echo "done"
		mv -fv ${O}*.out ${O}*.err ../var
	done
fi
cd ../var
unset O
