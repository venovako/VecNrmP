#!/bin/bash
# Usage: ./pproc.sh RUNs Ps PREFIX
echo '"P", "MREA", "AVGTA", "MREX", "AVGTX", "SPDUX", "MREY", "AVGTY", "SPDUY", "MREZ", "AVGTZ", "SPDUZ"' > ${3}_64.csv
for ((I=1;I<=$2;++I))
do
	echo -n "$I" >> ${3}_64.csv
	../src/mreatp.exe $1 < ${3}_$I-64.csv >> ${3}_64.csv
done
unset I
