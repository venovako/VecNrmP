# Testing environment

## Software

The testing code is contained in the following two repositories, with their usable versions denoted:
- [libpvn](https://github.com/venovako/libpvn "libpvn"): 8e89c56c011f4ade8dd318abdc1492ba09fd0660
- [VecNrmP](https://github.com/venovako/VecNrmP "VecNrmP"): 43a0c08eaa9c9bf989a79a69eaaf898ac5f98cdc

The key routines of the algorithms `A`, `B`, `H`, `X`, `Y`, and `Z` are implemented in libpvn, in ``src/pvn_vec.h`` and ``src/pvn_nrm.c``.
Here, in VecNrmP, are mostly the test drivers, the estimators of the relative error bounds, an implementation of the algorithm `C`, an example of `B` in Fortran, and the testing results.

The external software versions with which the testing code should be able to be built:
- [GMP](https://gmplib.org/repo/gmp "GMP"): 18489:b54d1f94b4ee
- [MPFR](https://gitlab.inria.fr/mpfr/mpfr "MPFR"): 8288743fb20db6102f42f4fd81e7c88b0fecde9a
- [SLEEF](https://github.com/shibatch/sleef "SLEEF"): 75f80b3637cbe571730706eae30853b92ab329f5
- [OpenCilk](https://github.com/OpenCilk/opencilk-project "OpenCilk"): 3.0
- [GCC](https://gcc.gnu.org "GCC"): 14.2.1
- [CORE-MATH](https://gitlab.inria.fr/core-math/core-math "CORE-MATH"): 78e96cfa6e47b9291597758c6f454f7365799b1b
- Reference [LAPACK](https://github.com/Reference-LAPACK/lapack "Reference BLAS"): 67f9279da4d004b3e998d6fb63ef75c4fbbf7355
- [ReproBLAS](https://github.com/willow-ahrens/ReproBLAS "ReproBLAS"): dfb815058dd34b88caba2513cce63bc2e89f951f
- Intel oneAPI [MKL](https://www.intel.com/content/www/us/en/developer/tools/oneapi/onemkl.html "Intel MKL"): 2025.3.0

The relevant CORE-MATH parts have been integrated in libpvn, so there is no need to build them separately.
Also, with GCC, the Reference LAPACK does not have to be built, since the relevant routines have been copied to VecNrmP and renamed, to avoid clashing with the corresponding MKL ones.
SLEEF has to be built with `SLEEF_BUILD_INLINE_HEADERS` CMake variable set to `ON`.
With OpenCilk, the MKL and ReproBLAS testing is meant to be skipped, and the Reference LAPACK is expected to have been built.

Static Linux executables for the Intel Cascadelake CPUs have been built on Oracle Linux 9.7 and can be downloaded as [VecNrmP.tar.zst](https://venovako.eu/x86_64/VecNrmP.tar.zst "Cascadelake").
HACK: the static `glibc` library (2.41.9000-16.fc43) has been taken from a Fedora RPM.
Usually, dynamic executables are built.

A subset of the GCC's options used on Cascadelake:
- `gcc`: ``-O3 -fno-math-errno -std=gnu2x -fPIC -ffp-contract=fast -fvect-cost-model=unlimited -pthread -fopenmp-simd -march=cascadelake``
- `gfortran`: ``-cpp -ffree-line-length-none -O3 -fno-math-errno -fPIC -ffp-contract=fast -fprotect-parens -frecursive -fstack-arrays -fvect-cost-model=unlimited -pthread -fopenmp-simd -march=cascadelake``

With OpenCilk on Intel Xeon Phi 7210, some of the used options are:
- `clang`: ``-O3 -fno-math-errno -std=gnu2y -fPIC -ffp-contract=fast -pthread -fopencilk -fopenmp-simd -march=native``

Some examples of building libpvn and VecNrmP on various systems are available as the ``build_*.sh`` scripts in the ``var`` subdirectory here.
They should be tailored to each particular system.

## Hardware

Two Intel Xeon Phi 7210 processors, with 64 cores and 96 GiB of RAM each, had Hyper Threading disabled and the MCDRAM used as the last-level cache.

A system with one Intel Cascadelake processor had 16 GiB RAM available.
