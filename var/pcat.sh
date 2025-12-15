#!/bin/bash
# Usage: ./pcat.sh NRUN PREFIX
rm -fv $2.out
for ((I=1;I<=$1;++I))
do
	echo "RUN $I" >> $2.out
	cat $2$1.out >> $2.out
done
unset I
