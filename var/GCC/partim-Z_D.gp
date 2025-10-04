set term cairolatex pdf standalone header "\\usepackage{amsmath,amsfonts}" color font ", 10" size 10cm,6cm
set output "partim-Z_D.tex"

set key bottom center horizontal spacing 1.5
set logscale y 2
set xrange [0:32]
set xlabel "run of a recursive vectorized algorithm"
set xtics ("1" 1, "16" 16, "31" 31)
set yrange [1:65]
set ylabel "speedup versus the sequential $Z_{\\mathtt{D}}$"
set ytics ("2" 2, "4" 4, "8" 8, "16" 16, "32" 32, "64" 64)

set datafile columnheaders
plot "par.csv" using 1:($2/$8) with points title "64" pointtype 5 linetype 2, \
     "par.csv" using 1:($2/$7) with points title "32" pointtype 7 linetype 3, \
     "par.csv" using 1:($2/$6) with points title "16" pointtype 12 linetype 0, \
     "par.csv" using 1:($2/$5) with points title "8" pointtype 14 linetype 0, \
     "par.csv" using 1:($2/$4) with points title "4" pointtype 1 linetype 0, \
     "par.csv" using 1:($2/$3) with points title "2" pointtype 2 linetype 0
