set term cairolatex pdf standalone header "\\usepackage{amsmath,amsfonts}" color font ", 10" size 10cm,6cm
set output "fig2.tex"

set key top center horizontal box spacing 1.45 width -1.35

set xrange [0:32]
set xlabel "run of a scalar recursive algorithm"
set xtics ("1" 1, "16" 16, "31" 31)
set yrange [2:16]
set ylabel "slowdown versus $\\mathtt{xNRMF}$"

set datafile columnheaders
plot "ud.csv" using 1:($17/$32) with points title "$A_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 5 linetype 2, \
     "nd.csv" using 1:($17/$32) with points title "$A_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 7 linetype 3, \
     "ud.csv" using 1:($23/$32) with points title "$H_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 13 linetype 1, \
     "nd.csv" using 1:($23/$32) with points title "$H_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 15 linetype 6, \
     "us.csv" using 1:($17/$32) with points title "$A_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 4 linetype 0, \
     "ns.csv" using 1:($17/$32) with points title "$A_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 6 linetype 0, \
     "us.csv" using 1:($23/$32) with points title "$H_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 12 linetype 0, \
     "ns.csv" using 1:($23/$32) with points title "$H_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 14 linetype 0, \
     "ud.csv" using 1:($20/$32) with points title "$B_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 1 linetype 0, \
     "us.csv" using 1:($20/$32) with points title "$B_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 2 linetype 0
