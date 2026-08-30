#!/bin/bash
# !!! has to be run from this directory on Oracle Linux 10 wih OpenCilk 3.0 !!!
cd ../../libpvn/src
make COMPILER=clang COMPILER_PREFIX=/opt/opencilk-3/bin/ NDEBUG=3 SAFE=SV2,NRM OPENMP=cilk VECLEN=64 GMP=$HOME/gnu MPFR=$HOME/gnu SLEEF=$HOME/gnu clean
make COMPILER=clang COMPILER_PREFIX=/opt/opencilk-3/bin/ NDEBUG=3 SAFE=SV2,NRM OPENMP=cilk VECLEN=64 GMP=$HOME/gnu MPFR=$HOME/gnu SLEEF=$HOME/gnu -j
cd ../../VecNrmP/src
make LAPACK=../../lapack clean
make LAPACK=../../lapack -j
cd ../var
