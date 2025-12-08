#include "pvn.h"

#if !(defined(PVN_LAPACK) && defined(PVN_MPFR) && defined(__AVX__) && defined(__FMA__))
#error PVN_LAPACK and PVN_MPFR and __AVX__ and __FMA__ have to be defined
#endif /* !PVN_LAPACK || !PVN_MPFR || !__AVX__ || !__FMA__ */
#ifndef EXTERNAL_REFERENCE
/* this assumes the Fortran integers are four-byte long */
extern float PVN_FABI(slrran,SLRRAN)(int *const iseed);
extern float PVN_FABI(slrrnd,SLRRND)(const int *const idist, int *const iseed);
extern double PVN_FABI(dlrran,DLRRAN)(int *const iseed);
extern double PVN_FABI(dlrrnd,DLRRND)(const int *const idist, int *const iseed);
#else /* EXTERNAL_REFERENCE */
/* this assumes the Fortran integers are four-byte long */
extern float PVN_FABI(slaran,SLARAN)(int *const iseed);
extern float PVN_FABI(slarnd,SLARND)(const int *const idist, int *const iseed);
extern double PVN_FABI(dlaran,DLARAN)(int *const iseed);
extern double PVN_FABI(dlarnd,DLARND)(const int *const idist, int *const iseed);

static inline float PVN_FABI(slrran,SLRRAN)(int *const iseed) { return PVN_FABI(slaran,SLARAN)(iseed); }
static inline float PVN_FABI(slrrnd,SLRRND)(const int *const idist, int *const iseed) { return PVN_FABI(slarnd,SLARND)(idist, iseed); }
static inline double PVN_FABI(dlrran,DLRRAN)(int *const iseed) { return PVN_FABI(dlaran,DLARAN)(iseed); }
static inline double PVN_FABI(dlrrnd,DLRRND)(const int *const idist, int *const iseed) { return PVN_FABI(dlarnd,DLARND)(idist, iseed); }
#endif /* ?EXTERNAL_REFERENCE */
static double frelerr(const double e, const double f)
{
  return ((e == 0.0) ? -0.0 : (__builtin_fabs(e - f) / scalbn(__builtin_fabs(e), -24)));
}
static double erelerr(const double e, const double f)
{
  return ((e == 0.0) ? -0.0 : (double)(__builtin_fabsl((long double)e - (long double)f) / scalbnl(__builtin_fabsl((long double)e), -53)));
}
int main(int argc, char *argv[])
{
  if (argc < 4) {
    (void)fprintf(stderr, "%s n m p_1 p_2 ... p_m [seed]\n", *argv);
    return 1;
  }
  const long long n_ = atoll(argv[1u]);
  const int m = atoi(argv[2u]);
  if ((m <= 0) || (argc < (m + 3)) || (argc > (m + 4)))
    return 2;
  if (!n_)
    return 3;
  union {
    unsigned long long l;
    unsigned short s[4u];
  } ls;
  int idist = ((n_ < 0ll) ? 3 : 1);
  if (argc > (m + 3)) {
    const long long s_ = atoll(argv[argc - 1]);
    if (s_ < 0ll) {
      ls.l = (unsigned long long)-s_;
      idist = -idist;
    }
    else
      ls.l = (unsigned long long)s_;
    if (!(ls.s[2u] & UINT16_C(16)))
        return 4;
    if (ls.s[3u]) /* longer than 48 bits */
      return 5;
  }
  else {
    const int u = PVN_FABI(pvn_ran_open,PVN_RAN_OPEN)();
    if (u < 0)
      return 6;
    while (!PVN_FABI(pvn_ran_16,PVN_RAN_16)(&u, ls.s)) /* loop */;
    while (!PVN_FABI(pvn_ran_16,PVN_RAN_16)(&u, ls.s + 1)) /* loop */;
    while (!PVN_FABI(pvn_ran_16,PVN_RAN_16)(&u, ls.s + 2) || !(ls.s[2u] & UINT16_C(16))) /* loop */;
    ls.s[3u] = UINT16_C(0);
    if (PVN_FABI(pvn_ran_close,PVN_RAN_CLOSE)(&u))
      return 7;
    (void)fprintf(stderr, "SEED = %15llu\n", ls.l);
  }
  const size_t n = (size_t)((n_ < 0ll) ? -n_ : n_);
  void *const x = aligned_alloc((size_t)64u, (n * ((idist < 0) ? sizeof(float) : sizeof(double))));
  if (!x)
    return 8;
  int iseed[4u] = { (int)(ls.l & 0xFFFull), (int)((ls.l >> 12u) & 0xFFFull), (int)((ls.l >> 24u) & 0xFFFull), (int)((ls.l >> 36u) & 0xFFFull) };
  const int adist = abs(idist);
  if (idist == -3) {
    for (size_t i = (size_t)0u; i < n; ++i)
      ((float*)x)[i] = PVN_FABI(slrrnd,SLRRND)(&adist, iseed);
  }
  else if (idist == -1) {
    for (size_t i = (size_t)0u; i < n; ++i)
      ((float*)x)[i] = PVN_FABI(slrran,SLRRAN)(iseed);
  }
  else if (idist == 1) {
    for (size_t i = (size_t)0u; i < n; ++i)
      ((double*)x)[i] = PVN_FABI(dlrran,DLRRAN)(iseed);
  }
  else if (idist == 3) {
    for (size_t i = (size_t)0u; i < n; ++i)
      ((double*)x)[i] = PVN_FABI(dlrrnd,DLRRND)(&adist, iseed);
  }
  else
    return 9;
  long long t = 0ll;
  mpfr_rnd_t rnd = MPFR_RNDN;
  mpfr_prec_t prec = 2048l;
  mpfr_exp_t emin = __MPFR_EXP_INVALID, emax = __MPFR_EXP_INVALID;
  if (PVN_FABI(pvn_mpfr_start,PVN_MPFR_START)(&rnd, &prec, &emin, &emax))
    return 10;
  for (int a = 0; a < m; ++a) {
    const double p = atof(argv[a + 3]);
    if (!(p > 0.0))
      return 11;
    (void)printf("p%d=%# .17e\n", (a + 1), p);
    (void)printf((idist < 0) ? "pvn_mps_nrmp=" : "pvn_mpd_nrmp=");
    (void)fflush(stdout);
    const float pf = (float)p;
    t = pvn_time_mono_ns();
    const double e = ((idist < 0) ? PVN_FABI(pvn_mps_nrmp,PVN_MPS_NRMP)(&pf, &n, (const float*)x) : PVN_FABI(pvn_mpd_nrmp,PVN_MPD_NRMP)(&p, &n, (const double*)x));
    t = pvn_time_mono_ns() - t;
    (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", e, 0.0, t);
#ifdef PVN_CILK
    (void)printf((idist < 0) ? "pvn_snrmp[C]=" : "pvn_dnrmp[C]=");
#else /* !PVN_CILK */
#if (defined(PVN_OPENMP) && (PVN_OPENMP > 1))
    (void)printf((idist < 0) ? "pvn_snrmp[P]=" : "pvn_dnrmp[P]=");
#else /* !PVN_OPENMP */
    (void)printf((idist < 0) ? "pvn_snrmp[S]=" : "pvn_dnrmp[S]=");
#endif /* ?PVN_OPENMP */
#endif /* ?PVN_CILK */
    (void)fflush(stdout);
    t = pvn_time_mono_ns();
    double f = ((idist < 0) ? PVN_FABI(pvn_snrmp,PVN_SNRMP)(&pf, &n, (const float*)x) : PVN_FABI(pvn_dnrmp,PVN_DNRMP)(&p, &n, (const double*)x));
    t = pvn_time_mono_ns() - t;
    (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
#if (defined(PVN_SLEEF) || (defined(PVN_USE_INTEL) && (defined(__INTEL_CLANG_COMPILER) || defined(__INTEL_LLVM_COMPILER) || defined(__INTEL_COMPILER))))
    (void)printf((idist < 0) ? "pvn_rxs_nrmp=" : "pvn_rxd_nrmp=");
    (void)fflush(stdout);
    t = pvn_time_mono_ns();
    f = ((idist < 0) ? PVN_FABI(pvn_rxs_nrmp,PVN_RXS_NRMP)(&pf, &n, (const float*)x) : PVN_FABI(pvn_rxd_nrmp,PVN_RXD_NRMP)(&p, &n, (const double*)x));
    t = pvn_time_mono_ns() - t;
    (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
    (void)printf((idist < 0) ? "pvn_rys_nrmp=" : "pvn_ryd_nrmp=");
    (void)fflush(stdout);
    t = pvn_time_mono_ns();
    f = ((idist < 0) ? PVN_FABI(pvn_rys_nrmp,PVN_RYS_NRMP)(&pf, &n, (const float*)x) : PVN_FABI(pvn_ryd_nrmp,PVN_RYD_NRMP)(&p, &n, (const double*)x));
    t = pvn_time_mono_ns() - t;
    (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
#ifdef __AVX512F__
    (void)printf((idist < 0) ? "pvn_rzs_nrmp=" : "pvn_rzd_nrmp=");
    (void)fflush(stdout);
    t = pvn_time_mono_ns();
    f = ((idist < 0) ? PVN_FABI(pvn_rzs_nrmp,PVN_RZS_NRMP)(&pf, &n, (const float*)x) : PVN_FABI(pvn_rzd_nrmp,PVN_RZD_NRMP)(&p, &n, (const double*)x));
    t = pvn_time_mono_ns() - t;
    (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
    (void)fflush(stdout);
#endif /* __AVX512F__ */
#endif /* Sleef || Intel */
  }
  (void)PVN_FABI(pvn_mpfr_stop,PVN_MPFR_STOP)();
  free(x);
  return 0;
}
