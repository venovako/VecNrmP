#!/bin/bash
for ((I=1;I<=11;++I))
do
	read S
	./nrm2.exe -1073741824 -$S > sn$I.out 2> sn$I.err &
done
wait
for ((I=12;I<=21;++I))
do
	read S
	./nrm2.exe -1073741824 -$S > sn$I.out 2> sn$I.err &
done
wait
for ((I=22;I<=31;++I))
do
	read S
	./nrm2.exe -1073741824 -$S > sn$I.out 2> sn$I.err &
done
wait
unset S I
