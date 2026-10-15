#!/bin/bash
# !!! has to be run from this directory on Oracle Linux 10 !!!
cd ../../libpvn/src
make NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=$HOME/gnu/lib MPFR=$HOME/gnu/lib SLEEF=$HOME/gnu/lib clean
make NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=$HOME/gnu/lib MPFR=$HOME/gnu/lib SLEEF=$HOME/gnu/lib -j
cd ../../cgic
make -f Makefile.pvn clean all
cd ../VecNrmP/src
make REPROBLAS=$HOME/gnu CGIC=../../cgic clean
make REPROBLAS=$HOME/gnu CGIC=../../cgic -j
cd ../var
