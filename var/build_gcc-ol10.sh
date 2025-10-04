#!/bin/bash
# !!! has to be run from this directory on Oracle Linux 10 !!!
cd ../../libpvn/src
make COMPILER=gcc NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=/opt/gmp MPFR=/opt/mpfr clean
make COMPILER=gcc NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=/opt/gmp MPFR=/opt/mpfr -j all
cd ../../VecNrmP/src
make LAPACK=../../lapack clean
make LAPACK=../../lapack -j all
cd ../var
