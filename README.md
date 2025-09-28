# VecNrmP
recursive computation of the vector p-norm

(... work in progress ...)

This software is a supplementary material for the papers:
- doi:[10.48550/arXiv.2509.06220](https://doi.org/10.48550/arXiv.2509.06220 "Recursive vectorized computation of the Frobenius norm").

For building [libpvn](https://github.com/venovako/libpvn) and this repository please invoke `make help` from the `src` subdirectory and see the examples in `var/build_*.sh` scripts.
They probably have to be tailored to each particular system.
The `LAPACK` variable should specify a directory containing the fully built Reference [LAPACK](https://github.com/Reference-LAPACK/lapack) library.

There are several testers available:
- `src/laf_relerr.exe` computes relative error bounds for the Algorithm L,
- `src/crd_relerr.exe` computes relative error bounds for the Algorithm C,
- `src/reh_relerr.exe` computes relative error bounds for the Algorithm A,
- `src/rhh_relerr.exe`, combined with the script `var/rh_relerr.sh`, computes relative error bounds for the Algorithm H,
- `src/nrm2.exe`, combined with the scripts `var/seq.sh` and `var/par.sh`, runs the sequential and OpenCilk-parallel 2-norm tests, respectively,
- `src/nrmp.exe`, combined with the script `var/seqp.sh`, runs the p-norm tests.

This work has been supported in part by Croatian Science Foundation under the project IP-2014-09-3670 ([MFBDA](https://web.math.pmf.unizg.hr/mfbda/)).
