set term cairolatex pdf standalone header "\\usepackage{amsmath,amsfonts}" color font ", 10" size 10cm,6cm
set output "fig3.tex"

set key top center horizontal box spacing 1.45

set xrange [0:32]
set xlabel "run of a vectorized recursive algorithm"
set xtics ("1" 1, "16" 16, "31" 31)
set yrange [0.75:3]
set ytics ("0.75" 0.75, "1.00" 1.00, "1.25" 1.25, "1.50" 1.50, "1.75" 1.75, "2.00" 2.00, "2.25" 2.25, "2.50" 2.50, "2.75" 2.75, "3.00" 3.00)
set ylabel "slowdown versus $\\mathtt{xNRMF}$"

set datafile columnheaders
plot "ud.csv" using 1:($29/$32) with points title "$Y_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 5 linetype 2, \
     "nd.csv" using 1:($29/$32) with points title "$Y_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 7 linetype 3, \
     "ud.csv" using 1:($26/$32) with points title "$X_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 13 linetype 1, \
     "nd.csv" using 1:($26/$32) with points title "$X_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 15 linetype 6, \
     "us.csv" using 1:($29/$32) with points title "$Y_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 4 linetype 0, \
     "ns.csv" using 1:($29/$32) with points title "$Y_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 6 linetype 0, \
     "us.csv" using 1:($26/$32) with points title "$X_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 12 linetype 0, \
     "ns.csv" using 1:($26/$32) with points title "$X_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 14 linetype 0
