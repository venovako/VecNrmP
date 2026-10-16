#!/bin/bash
for ((I=1;I<=31;++I))
do
	read S
	./nrm2.exe -536870912 -$S > ns$I.out 2> ns$I.err
done
unset S I
