#!/bin/bash
source ./env.sh
cd ../src
if [ "$2" = "half" ]
then
	O1=ndp
	O2=udp
else
	O1=dnp
	O2=dup
fi
for O in ${O1} ${O2}
do
	echo -n "Running ${O}.sh with $1 workers ... "
	../var/${O}.sh $1
	echo "done"
	mv -fv ${O}*.out ${O}*.err ../var
done
cd ../var
unset O2 O1 O
