set term cairolatex pdf standalone header "\\usepackage{amsmath,amsfonts}" color font ", 10" size 10cm,6cm
set output "fig5.tex"

set key top center horizontal box spacing 1.45

set xrange [0:32]
set xlabel "run of a vectorized recursive algorithm"
set xtics ("1" 1, "16" 16, "31" 31)
set yrange [0.5:4.5]
set ytics ("0.5" 0.5, "1.0" 1.0, "1.5" 1.5, "2.0" 2.0, "2.5" 2.5, "3.0" 3.0, "3.5" 3.5, "4.0" 4.0, "4.5" 4.5)
set ylabel "speedup versus $L$"

set datafile columnheaders
plot "ud.csv" using 1:($8/$32) with points title "$Z_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 5 linetype 2, \
     "nd.csv" using 1:($8/$32) with points title "$Z_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 7 linetype 3, \
     "ud.csv" using 1:($8/$29) with points title "$Y_{\\mathtt{D}}^{\\mathcal{U}}$" pointtype 13 linetype 1, \
     "nd.csv" using 1:($8/$29) with points title "$Y_{\\mathtt{D}}^{\\mathcal{N}}$" pointtype 15 linetype 6, \
     "us.csv" using 1:($8/$32) with points title "$Z_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 4 linetype 0, \
     "ns.csv" using 1:($8/$32) with points title "$Z_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 6 linetype 0, \
     "us.csv" using 1:($8/$29) with points title "$Y_{\\mathtt{S}}^{\\mathcal{U}}$" pointtype 12 linetype 0, \
     "ns.csv" using 1:($8/$29) with points title "$Y_{\\mathtt{S}}^{\\mathcal{N}}$" pointtype 14 linetype 0
