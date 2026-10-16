#!/bin/bash
source ./env.sh
cd ../src
if [ "$1" = "half" ]
then
	for T in d s
	do
		echo -n "Running n${T}.sh ... "
		../var/n${T}.sh < ../var/nseed.txt
		echo "done"
		mv -fv n${T}*.out n${T}*.err ../var
		echo -n "Running u${T}.sh ... "
		../var/u${T}.sh < ../var/useed.txt
		echo "done"
		mv -fv u${T}*.out u${T}*.err ../var
	done
else
	for T in d s
	do
		echo -n "Running ${T}n.sh ... "
		../var/${T}n.sh < ../var/nseed.txt
		echo "done"
		mv -fv ${T}n*.out ${T}n*.err ../var
		echo -n "Running ${T}u.sh ... "
		../var/${T}u.sh < ../var/useed.txt
		echo "done"
		mv -fv ${T}u*.out ${T}u*.err ../var
	done
fi
cd ../var
unset T
