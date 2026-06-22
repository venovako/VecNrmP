#!/bin/bash
# !!! has to be run from this directory on Oracle Linux 10 !!!
cd ../../libpvn/src
make COMPILER=gcc NDEBUG=3 SAFE=DET,SV2,NRM VECLEN=64 GMP=/opt/gmp MPFR=/opt/mpfr SLEEF=/opt/sleef clean
make COMPILER=gcc NDEBUG=3 SAFE=DET,SV2,NRM VECLEN=64 GMP=/opt/gmp MPFR=/opt/mpfr SLEEF=/opt/sleef -j
cd ../../VecNrmP/src
make clean
make -j
cd ../var
