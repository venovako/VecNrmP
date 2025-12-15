#!/bin/bash
# Usage: ./pcat.sh RUNs Ps PREFIX
rm -fv $3.out
for ((I=1;I<=$1;++I))
do
	echo "RUN $I" >> $3.out
	cat $3$1.out >> $3.out
done
../src/parse_p.exe $1 $2 $3
unset I
