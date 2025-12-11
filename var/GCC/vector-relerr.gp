set term cairolatex pdf standalone header "\\usepackage{amsmath,amsfonts}" color font ", 10" size 10cm,6cm
set output "vector-relerr.tex"

set key bottom center horizontal box spacing 1.75

set xrange [0:32]
set xlabel "run of a recursive algorithm"
set xtics ("1" 1, "16" 16, "31" 31)
set ylabel "relative error in multiples of $\\varepsilon_{\\mathtt{x}}$"

set datafile columnheaders
plot "us.csv" using 1:25 with points title "$X_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 1 linetype 7, \
     "us.csv" using 1:28 with points title "$Y_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 2 linetype 1, \
     "us.csv" using 1:31 with points title "$Z_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 12 linetype 1, \
     "ns.csv" using 1:25 with points title "$X_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 6 linetype 7, \
     "ns.csv" using 1:28 with points title "$Y_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 4 linetype 1, \
     "ns.csv" using 1:31 with points title "$Z_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 14 linetype 1, \
     "ud.csv" using 1:25 with points title "$X_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 11 linetype 2, \
     "ud.csv" using 1:28 with points title "$Y_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 9 linetype 3, \
     "ud.csv" using 1:31 with points title "$Z_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 3 linetype 3, \
     "nd.csv" using 1:25 with points title "$X_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 10 linetype 0, \
     "nd.csv" using 1:28 with points title "$Y_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 8 linetype 0, \
     "nd.csv" using 1:31 with points title "$Z_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 5 linetype 0
