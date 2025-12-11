set term cairolatex pdf standalone header "\\usepackage{amsmath,amsfonts}" color font ", 10" size 10cm,6cm
set output "reltim-ABHX_D.tex"

set key top center horizontal box spacing 1.45

set xrange [0:32]
set xlabel "run of a recursive algorithm"
set xtics ("1" 1, "16" 16, "31" 31)
set yrange [0:8]
set ylabel "slowdown versus $L_{\\mathtt{\\mathtt{D}}}$"

set datafile columnheaders
plot "ud.csv" using 1:($17/$8) with points title "$A_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 5 linetype 2, \
     "nd.csv" using 1:($17/$8) with points title "$A_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 7 linetype 3, \
     "ud.csv" using 1:($20/$8) with points title "$B_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 12 linetype 0, \
     "nd.csv" using 1:($20/$8) with points title "$B_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 14 linetype 0, \
     "ud.csv" using 1:($23/$8) with points title "$H_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 4 linetype 0, \
     "nd.csv" using 1:($23/$8) with points title "$H_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 6 linetype 0, \
     "ud.csv" using 1:($26/$8) with points title "$X_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 1 linetype 0, \
     "nd.csv" using 1:($26/$8) with points title "$X_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 2 linetype 0
