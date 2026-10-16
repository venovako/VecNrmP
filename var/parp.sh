#!/bin/bash
source ./env.sh
cd ../src
if [ -z "$1" ]
then
	W=1
else
	W=$1
fi
if [ "$2" = "half" ]
then
	echo -n "Running ndp.sh with $W workers ... "
	../var/ndp.sh $W < ../var/nseed.txt
	echo "done"
	mv -fv ndp*.out ndp*.err ../var
	echo -n "Running udp.sh with $W workers ... "
	../var/udp.sh $W < ../var/useed.txt
	echo "done"
	mv -fv udp*.out udp*.err ../var
else
	echo -n "Running dnp.sh with $W workers ... "
	../var/dnp.sh $W < ../var/nseed.txt
	echo "done"
	mv -fv dnp*.out dnp*.err ../var
	echo -n "Running dup.sh with $W workers ... "
	../var/dup.sh $W < ../var/useed.txt
	echo "done"
	mv -fv dup*.out dup*.err ../var
fi
cd ../var
unset W
