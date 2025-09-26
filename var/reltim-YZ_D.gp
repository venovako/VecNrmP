set term cairolatex pdf standalone header "\\usepackage{amsmath,amsfonts}" color font ", 10" size 10cm,6cm
set output "reltim-YZ_D.tex"

set key bottom center horizontal box spacing 1.75

set xrange [0:32]
set xlabel "run of a recursive vectorized algorithm"
set xtics ("1" 1, "16" 16, "31" 31)
set yrange [0.345:1.35]
set ylabel "speedup versus $L_{\\mathtt{D}}$"
set ytics ("0.4" 0.4, "0.5" 0.5, "0.6" 0.6, "0.7" 0.7, "0.8" 0.8, "0.9" 0.9, "1.0" 1.0, "1.1" 1.1, "1.2" 1.2, "1.3" 1.3)

set datafile columnheaders
plot "ud.csv" using 1:($8/$26) with points title "$Z_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 5 linetype 2, \
     "nd.csv" using 1:($8/$26) with points title "$Z_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 7 linetype 3, \
     "ud.csv" using 1:($8/$23) with points title "$Y_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 12 linetype 0, \
     "nd.csv" using 1:($8/$23) with points title "$Y_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 14 linetype 0
