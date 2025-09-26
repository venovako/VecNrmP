set term cairolatex pdf standalone header "\\usepackage{amsmath,amsfonts}" color font ", 10" size 10cm,6cm
set output "reltim-XYZ_S.tex"

set key bottom center horizontal box spacing 1.5

set xrange [0:32]
set xlabel "run of a recursive vectorized algorithm"
set xtics ("1" 1, "16" 16, "31" 31)
set yrange [0.175:2.3]
set ylabel "speedup versus $L_{\\mathtt{S}}$"
set ytics ("0.3" 0.3, "0.5" 0.5, "0.7" 0.7, "0.9" 0.9, "1.1" 1.1, "1.3" 1.3, "1.5" 1.5, "1.7" 1.7, "1.9" 1.9, "2.1" 2.1, "2.3" 2.3)

set datafile columnheaders
plot "us.csv" using 1:($8/$26) with points title "$Z_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 5 linetype 2, \
     "ns.csv" using 1:($8/$26) with points title "$Z_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 7 linetype 3, \
     "us.csv" using 1:($8/$23) with points title "$Y_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 12 linetype 0, \
     "ns.csv" using 1:($8/$23) with points title "$Y_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 14 linetype 0, \
     "us.csv" using 1:($8/$20) with points title "$X_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 1 linetype 0, \
     "ns.csv" using 1:($8/$20) with points title "$X_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 2 linetype 0
