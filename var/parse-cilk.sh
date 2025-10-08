#!/bin/bash
echo '"RUN", "T1", "T2", "T4", "T8", "T16", "T32", "T64"' > cilk.csv
for ((I=1;I<=31;++I))
do
	printf "%2d" $I >> cilk.csv
	for ((W=1;W<=64;W*=2))
	do
		L=`grep rz cilk$I-$W.out | tr -s ' '`
		T=`echo "$L" | cut -d' ' -f6`
		echo -n ", $T" >> cilk.csv
	done
	echo >> cilk.csv
done
unset T L W I
