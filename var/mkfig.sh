#!/bin/bash
gnuplot $1.gp && pdflatex $1.tex && rm -fv $1.aux $1.log $1.tex $1-inc.pdf
