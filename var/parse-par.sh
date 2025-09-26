#!/bin/bash
echo '"RUN", "T1", "T2", "T4", "T8", "T16", "T32", "T64"' > par.csv
for ((I=1;I<=31;++I))
do
	echo -n "$I" >> par.csv
	for ((W=1;W<=64;W*=2))
	do
		L=`grep rz par$I-$W.out | tr -s ' '`
		T=`echo "$L" | cut -d' ' -f6`
		echo -n ", $T" >> par.csv
	done
	echo >> par.csv
done
unset T L W I
