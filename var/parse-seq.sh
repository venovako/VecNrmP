#!/bin/bash
for O in dn du sn su nd ns ud us
do
	echo -n "Creating $O.csv ... "
	echo '"RUN", "SEED", "MPV", "MPE", "MPT", "LAV", "LAE", "LAT", "M2V", "M2E", "M2T", "RFV", "RFE", "RFT", "RHV", "RHE", "RHT", "RXV", "RXE", "RXT", "RYV", "RYE", "RYT", "RZV", "RZE", "RZT", "CRV", "CRE", "CRT"' > $O.csv
	for ((I=1;I<=31;++I))
	do
		echo -n "$I, " >> $O.csv
		S=`grep SEED $O$I.err | cut -d'=' -f2 | tr -d ' '`
		echo -n "$S" >> $O.csv
		for F in mp la m2 rf rh rx ry rz cr
		do
			L=`grep $F $O$I.out | tr -s ' '`
			V=`echo "$L" | cut -d' ' -f2`
			E=`echo "$L" | cut -d' ' -f4`
			T=`echo "$L" | cut -d' ' -f6`
			echo -n ", $V, $E, $T" >> $O.csv
		done
		echo >> $O.csv
	done
	echo "done"
done
unset T E V L F S I O
