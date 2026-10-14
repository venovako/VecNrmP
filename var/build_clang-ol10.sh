#!/bin/bash
# !!! has to be run from this directory on Oracle Linux 10 wih OpenCilk 3.0 !!!
cd ../../libpvn/src
make COMPILER=clang COMPILER_PREFIX=/opt/opencilk-3/bin/ NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=$HOME/gnu/lib MPFR=$HOME/gnu/lib SLEEF=$HOME/gnu/lib clean
make COMPILER=clang COMPILER_PREFIX=/opt/opencilk-3/bin/ NDEBUG=3 SAFE=SV2,NRM VECLEN=64 GMP=$HOME/gnu/lib MPFR=$HOME/gnu/lib SLEEF=$HOME/gnu/lib -j
cd ../../VecNrmP/src
make LAPACK=../../lapack clean
make LAPACK=../../lapack -j
cd ../var
