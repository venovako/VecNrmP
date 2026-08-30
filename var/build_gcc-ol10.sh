#!/bin/bash
# !!! has to be run from this directory on Oracle Linux 10 !!!
cd ../../libpvn/src
make NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=$HOME/gnu MPFR=$HOME/gnu SLEEF=$HOME/gnu clean
make NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=$HOME/gnu MPFR=$HOME/gnu SLEEF=$HOME/gnu -j
cd ../../VecNrmP/src
make clean
make -j
cd ../var
