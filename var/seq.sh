#!/bin/bash
source ./env.sh
cd ../src
if [ "$1" = "half" ]
then
	O1=nd
	O2=ud
	O3=ns
	O4=us
else
	O1=dn
	O2=du
	O3=sn
	O4=su
fi
for O in ${O1} ${O2} ${O3} ${O4}
do
	echo -n "Running ${O}.sh ... "
	../var/${O}.sh
	echo "done"
	mv -fv ${O}*.out ${O}*.err ../var
done
cd ../var
unset O4 O3 O2 O1 O
