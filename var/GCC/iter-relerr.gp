set term cairolatex pdf standalone header "\\usepackage{amsmath,amsfonts}" color font ", 10" size 10cm,6cm
set output "iter-relerr.tex"

set key at graph 0.9375, 0.825 horizontal box spacing 1.75
set logscale y 10

set xrange [0:32]
set xlabel "run of a scalar iterative algorithm"
set xtics ("1" 1, "16" 16, "31" 31)
set ylabel "relative error in multiples of $\\varepsilon_{\\mathtt{x}}$"
set yrange [1e0:1e8]
set ytics ("$10^0$" 1e0, "$10^1$" 1e1, "$10^2$" 1e2, "$10^3$" 1e3, "$10^4$" 1e4, "$10^5$" 1e5, "$10^6$" 1e6, "$10^7$" 1e7, "$10^8$" 1e8)

set datafile columnheaders
plot "us.csv" using 1:7 with points title "$L_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 1 linetype 7, \
     "us.csv" using 1:34 with points title "$C_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 2 linetype 1, \
     "ns.csv" using 1:7 with points title "$L_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 6 linetype 7, \
     "ns.csv" using 1:34 with points title "$C_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 4 linetype 1, \
     "ud.csv" using 1:7 with points title "$L_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 11 linetype 2, \
     "ud.csv" using 1:34 with points title "$C_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 9 linetype 3, \
     "nd.csv" using 1:7 with points title "$L_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 14 linetype 0, \
     "nd.csv" using 1:34 with points title "$C_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 12 linetype 0
