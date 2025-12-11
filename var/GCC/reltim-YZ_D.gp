set term cairolatex pdf standalone header "\\usepackage{amsmath,amsfonts}" color font ", 10" size 10cm,6cm
set output "reltim-YZ_D.tex"

set key bottom center horizontal box spacing 1.75

set xrange [0:32]
set xlabel "run of a recursive vectorized algorithm"
set xtics ("1" 1, "16" 16, "31" 31)
set yrange [0.6:2.8]
set ylabel "speedup versus $L_{\\mathtt{D}}$"
set ytics ("0.6" 0.6, "0.8" 0.8, "1.0" 1.0, "1.2" 1.2, "1.4" 1.4, "1.6" 1.6, "1.8" 1.8, "2.0" 2.0, "2.2" 2.2, "2.4" 2.4, "2.6" 2.6, "2.8" 2.8)

set datafile columnheaders
plot "ud.csv" using 1:($8/$32) with points title "$Z_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 5 linetype 2, \
     "nd.csv" using 1:($8/$32) with points title "$Z_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 7 linetype 3, \
     "ud.csv" using 1:($8/$29) with points title "$Y_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 12 linetype 0, \
     "nd.csv" using 1:($8/$29) with points title "$Y_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 14 linetype 0
