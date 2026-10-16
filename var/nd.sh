#!/bin/bash
for ((I=1;I<=31;++I))
do
	read S
	./nrm2.exe -536870912 $S > nd$I.out 2> nd$I.err
done
unset S I
