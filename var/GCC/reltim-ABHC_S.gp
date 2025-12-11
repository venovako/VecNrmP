set term cairolatex pdf standalone header "\\usepackage{amsmath,amsfonts}" color font ", 10" size 10cm,6cm
set output "reltim-ABHC_S.tex"

set key top center horizontal box spacing 1.45

set xrange [0:32]
set xlabel "run of a scalar algorithm"
set xtics ("1" 1, "16" 16, "31" 31)
set yrange [0:8]
set ylabel "slowdown versus $L_{\\mathtt{\\mathtt{S}}}$"

set datafile columnheaders
plot "us.csv" using 1:($11/$8) with points title "$A_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 5 linetype 2, \
     "ns.csv" using 1:($11/$8) with points title "$A_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 7 linetype 3, \
     "us.csv" using 1:($14/$8) with points title "$B_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 12 linetype 0, \
     "ns.csv" using 1:($14/$8) with points title "$B_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 14 linetype 0, \
     "us.csv" using 1:($17/$8) with points title "$H_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 4 linetype 0, \
     "ns.csv" using 1:($17/$8) with points title "$H_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 6 linetype 0, \
     "us.csv" using 1:($29/$8) with points title "$C_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 1 linetype 0, \
     "ns.csv" using 1:($29/$8) with points title "$C_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 2 linetype 0
