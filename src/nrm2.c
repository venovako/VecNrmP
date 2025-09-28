#include "pvn.h"

/* this assumes the Fortran integers are four-byte long, but only for this tester */
extern float PVN_FABI(slaran,SLARAN)(int *const iseed);
extern float PVN_FABI(slarnd,SLARND)(const int *const idist, int *const iseed);
extern double PVN_FABI(dlaran,DLARAN)(int *const iseed);
extern double PVN_FABI(dlarnd,DLARND)(const int *const idist, int *const iseed);
/* even if the Fortran integers are four-byte long, this should work on little endian machines */
extern float PVN_FABI(snrm2,SNRM2)(const size_t *const n, const float *const x, const int64_t *const incx);
extern double PVN_FABI(dnrm2,DNRM2)(const size_t *const n, const double *const x, const int64_t *const incx);

static float PVN_FABI(pvn_las_nrmf,PVN_LAS_NRMF)(const size_t *const n, const float *const x)
{
  if (!n)
    return -1.0f;
  if (!*n)
    return -0.0f;
  if (!x)
    return -2.0f;
  const int64_t incx = INT64_C(1);
  return PVN_FABI(snrm2,SNRM2)(n, x, &incx);
}

static double PVN_FABI(pvn_lad_nrmf,PVN_LAD_NRMF)(const size_t *const n, const double *const x)
{
  if (!n)
    return -1.0;
  if (!*n)
    return -0.0;
  if (!x)
    return -2.0;
  const int64_t incx = INT64_C(1);
  return PVN_FABI(dnrm2,DNRM2)(n, x, &incx);
}

static float PVN_FABI(pvn_crs_nrmf,PVN_CRS_NRMF)(const size_t *const n, const float *const x)
{
#ifdef _OPENMP
#pragma omp declare reduction(hcf:float:omp_out=hypotf(omp_out,omp_in)) initializer(omp_priv=0.0f)
#endif /* _OPENMP */
  if (!n)
    return -1.0f;
  if (!*n)
    return -0.0f;
  if (!x)
    return -2.0f;
  if (*n == (size_t)1u)
    return __builtin_fabsf(*x);
  if (*n == (size_t)2u)
    return hypotf(x[0u], x[1u]);
  const size_t m = *n;
  const float tsml = scalbnf(1.0f, -63);
  const float tbig = scalbnf(1.0f,  52);
  /* the three Blue's accumulators as in SNRM2 */
  float sml = 0.0f, med = 0.0f, big = 0.0f;
#ifndef PVN_LAPACK
  /* the accumulator for subnormal inputs */
  float dnr = 0.0f;
#endif /* !PVN_LAPACK */
#ifdef _OPENMP
#ifdef PVN_LAPACK
#pragma omp parallel for default(none) shared(m,x,tsml,tbig) reduction(hcf:sml,med,big)
#else /* !PVN_LAPACK */
#pragma omp parallel for default(none) shared(m,x,tsml,tbig) reduction(hcf:dnr,sml,med,big)
#endif /* ?PVN_LAPACK */
#endif /* _OPENMP */
  for (size_t i = 0u; i < m; ++i) {
    const float y = __builtin_fabsf(x[i]);
    if (y > 0.0f) {
#ifdef PVN_LAPACK
      if (y < tsml)
#else /* !PVN_LAPACK */
      if (y < FLT_MIN)
        dnr = hypotf(dnr, scalbnf(y, 23));
      else if (y < tsml)
#endif /* PVN_LAPACK */
        sml = hypotf(sml, y);
      else if (y > tbig)
        big = hypotf(big, y);
      else /* med */
        med = hypotf(med, y);
    }
  }
#ifndef PVN_LAPACK
  if (dnr > 0.0f)
    sml = hypotf(sml, scalbnf(dnr, -23));
#endif /* !PVN_LAPACK */
  if (sml > 0.0f)
    med = hypotf(med, sml);
  if (med > 0.0f)
    big = hypotf(big, med);
  return big;
}

static double PVN_FABI(pvn_crd_nrmf,PVN_CRD_NRMF)(const size_t *const n, const double *const x)
{
#ifdef _OPENMP
#pragma omp declare reduction(hcd:double:omp_out=hypot(omp_out,omp_in)) initializer(omp_priv=0.0)
#endif /* _OPENMP */
  if (!n)
    return -1.0;
  if (!*n)
    return -0.0;
  if (!x)
    return -2.0;
  if (*n == (size_t)1u)
    return __builtin_fabs(*x);
  if (*n == (size_t)2u)
    return hypot(x[0u], x[1u]);
  const size_t m = *n;
  const double tsml = scalbn(1.0, -511);
  const double tbig = scalbn(1.0,  486);
  /* the three Blue's accumulators as in DNRM2 */
  double sml = 0.0, med = 0.0, big = 0.0;
#ifndef PVN_LAPACK
  /* the accumulator for subnormal inputs */
  double dnr = 0.0;
#endif /* !PVN_LAPACK */
#ifdef _OPENMP
#ifdef PVN_LAPACK
#pragma omp parallel for default(none) shared(m,x,tsml,tbig) reduction(hcd:sml,med,big)
#else /* !PVN_LAPACK */
#pragma omp parallel for default(none) shared(m,x,tsml,tbig) reduction(hcd:dnr,sml,med,big)
#endif /* ?PVN_LAPACK */
#endif /* _OPENMP */
  for (size_t i = 0u; i < m; ++i) {
    const double y = __builtin_fabs(x[i]);
    if (y > 0.0) {
#ifdef PVN_LAPACK
      if (y < tsml)
#else /* !PVN_LAPACK */
      if (y < DBL_MIN)
        dnr = hypot(dnr, scalbn(y, 52));
      else if (y < tsml)
#endif /* ?PVN_LAPACK */
        sml = hypot(sml, y);
      else if (y > tbig)
        big = hypot(big, y);
      else /* med */
        med = hypot(med, y);
    }
  }
#ifndef PVN_LAPACK
  if (dnr > 0.0)
    sml = hypot(sml, scalbn(dnr, -52));
#endif /* !PVN_LAPACK */
  if (sml > 0.0)
    med = hypot(med, sml);
  if (med > 0.0)
    big = hypot(big, med);
  return big;
}

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
  if ((argc < 2) || (argc > 4)) {
    (void)fprintf(stderr, "%s n [seed [exact]]\n", *argv);
    return 1;
  }
  const long long n_ = atoll(argv[1u]);
  if (!n_)
    return 2;
  union {
    unsigned long long l;
    unsigned short s[4u];
  } ls;
  int idist = ((n_ < 0ll) ? 3 : 1);
  if (argc > 2) {
    const long long s_ = atoll(argv[2u]);
    if (s_ < 0ll) {
      ls.l = (unsigned long long)-s_;
      idist = -idist;
    }
    else
      ls.l = (unsigned long long)s_;
    if (!(ls.s[2u] & UINT16_C(16)))
        return 3;
    if (ls.s[3u]) /* longer than 48 bits */
      return 4;
  }
  else {
    const int u = PVN_FABI(pvn_ran_open,PVN_RAN_OPEN)();
    if (u < 0)
      return 5;
    while (!PVN_FABI(pvn_ran_16,PVN_RAN_16)(&u, ls.s)) /* loop */;
    while (!PVN_FABI(pvn_ran_16,PVN_RAN_16)(&u, ls.s + 1)) /* loop */;
    while (!PVN_FABI(pvn_ran_16,PVN_RAN_16)(&u, ls.s + 2) || !(ls.s[2u] & UINT16_C(16))) /* loop */;
    ls.s[3u] = UINT16_C(0);
    if (PVN_FABI(pvn_ran_close,PVN_RAN_CLOSE)(&u))
      return 6;
    (void)fprintf(stderr, "SEED = %15llu\n", ls.l);
  }
  const size_t n = (size_t)((n_ < 0ll) ? -n_ : n_);
  void *const x = aligned_alloc((size_t)64u, (n * ((idist < 0) ? sizeof(float) : sizeof(double))));
  if (!x)
    return 7;
  int iseed[4u] = { (int)(ls.l & 0xFFFull), (int)((ls.l >> 12u) & 0xFFFull), (int)((ls.l >> 24u) & 0xFFFull), (int)((ls.l >> 36u) & 0xFFFull) };
  const int adist = abs(idist);
  if (idist == -3) {
    for (size_t i = (size_t)0u; i < n; ++i)
      ((float*)x)[i] = PVN_FABI(slarnd,SLARND)(&adist, iseed);
  }
  else if (idist == -1) {
    for (size_t i = (size_t)0u; i < n; ++i)
      ((float*)x)[i] = PVN_FABI(slaran,SLARAN)(iseed);
  }
  else if (idist == 1) {
    for (size_t i = (size_t)0u; i < n; ++i)
      ((double*)x)[i] = PVN_FABI(dlaran,DLARAN)(iseed);
  }
  else if (idist == 3) {
    for (size_t i = (size_t)0u; i < n; ++i)
      ((double*)x)[i] = PVN_FABI(dlarnd,DLARND)(&adist, iseed);
  }
  else
    return 8;
  long long t = 0ll;
  double e = ((argc > 3) ? atof(argv[3u]) : 0.0), f = 0.0;
  double p = 0.0;
  if (idist < 0)
    *(float*)&p = 2.0f;
  else /* double */
    p = 2.0;
#ifndef PVN_CILK
#ifdef PVN_MPFR
  if (argc <= 3) {
    mpfr_rnd_t rnd = MPFR_RNDN;
    mpfr_prec_t prec = 2048l;
    mpfr_exp_t emin = __MPFR_EXP_INVALID, emax = __MPFR_EXP_INVALID;
    if (PVN_FABI(pvn_mpfr_start,PVN_MPFR_START)(&rnd, &prec, &emin, &emax))
      return 9;
    (void)printf((idist < 0) ? "pvn_mps_nrmf=" : "pvn_mpd_nrmf=");
    (void)fflush(stdout);
    t = pvn_time_mono_ns();
    e = ((idist < 0) ? PVN_FABI(pvn_mps_nrmp,PVN_MPS_NRMP)((const float*)&p, &n, (const float*)x) : PVN_FABI(pvn_mpd_nrmp,PVN_MPD_NRMP)(&p, &n, (const double*)x));
    t = pvn_time_mono_ns() - t;
    (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", e, 0.0, t);
  }
#endif /* PVN_MPFR */
  (void)printf((idist < 0) ? "pvn_las_nrmf=" : "pvn_lad_nrmf=");
  (void)fflush(stdout);
  t = pvn_time_mono_ns();
  f = ((idist < 0) ? PVN_FABI(pvn_las_nrmf,PVN_LAS_NRMF)(&n, (const float*)x) : PVN_FABI(pvn_lad_nrmf,PVN_LAD_NRMF)(&n, (const double*)x));
  t = pvn_time_mono_ns() - t;
  (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
  (void)printf((idist < 0) ? "pvn_snrm2[s]=" : "pvn_dnrm2[s]=");
#else /* PVN_CILK */
  (void)printf((idist < 0) ? "pvn_snrm2[p]=" : "pvn_dnrm2[p]=");
#endif /* ?PVN_CILK */
  (void)fflush(stdout);
  t = pvn_time_mono_ns();
  f = ((idist < 0) ? PVN_FABI(pvn_snrm2,PVN_SNRM2)(&n, (const float*)x) : PVN_FABI(pvn_dnrm2,PVN_DNRM2)(&n, (const double*)x));
  t = pvn_time_mono_ns() - t;
  (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
#ifdef PVN_NRM_SAFE
  (void)printf((idist < 0) ? "pvn_rfs_nrmf=" : "pvn_rfd_nrmf=");
#else /* !PVN_NRM_SAFE */
  (void)printf((idist < 0) ? "pvn_res_nrmf=" : "pvn_red_nrmf=");
#endif /* ?PVN_NRM_SAFE */
  (void)fflush(stdout);
  t = pvn_time_mono_ns();
#ifdef PVN_NRM_SAFE
  f = ((idist < 0) ? PVN_FABI(pvn_rfs_nrmf,PVN_RFS_NRMF)(&n, (const float*)x) : PVN_FABI(pvn_rfd_nrmf,PVN_RFD_NRMF)(&n, (const double*)x));
#else /* !PVN_NRM_SAFE */
  f = ((idist < 0) ? PVN_FABI(pvn_res_nrmf,PVN_RES_NRMF)(&n, (const float*)x) : PVN_FABI(pvn_red_nrmf,PVN_RED_NRMF)(&n, (const double*)x));
#endif /* ?PVN_NRM_SAFE */
  t = pvn_time_mono_ns() - t;
  (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
  (void)printf((idist < 0) ? "pvn_rhs_nrmf=" : "pvn_rhd_nrmf=");
  (void)fflush(stdout);
  t = pvn_time_mono_ns();
  f = ((idist < 0) ? PVN_FABI(pvn_rhs_nrmf,PVN_RHS_NRMF)(&n, (const float*)x) : PVN_FABI(pvn_rhd_nrmf,PVN_RHD_NRMF)(&n, (const double*)x));
  t = pvn_time_mono_ns() - t;
  (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
  (void)printf((idist < 0) ? "pvn_rxs_nrmf=" : "pvn_rxd_nrmf=");
  (void)fflush(stdout);
  t = pvn_time_mono_ns();
  f = ((idist < 0) ? PVN_FABI(pvn_rxs_nrmf,PVN_RXS_NRMF)(&n, (const float*)x) : PVN_FABI(pvn_rxd_nrmf,PVN_RXD_NRMF)(&n, (const double*)x));
  t = pvn_time_mono_ns() - t;
  (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
  (void)printf((idist < 0) ? "pvn_rys_nrmf=" : "pvn_ryd_nrmf=");
  (void)fflush(stdout);
  t = pvn_time_mono_ns();
  f = ((idist < 0) ? PVN_FABI(pvn_rys_nrmf,PVN_RYS_NRMF)(&n, (const float*)x) : PVN_FABI(pvn_ryd_nrmf,PVN_RYD_NRMF)(&n, (const double*)x));
  t = pvn_time_mono_ns() - t;
  (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
#ifdef __AVX512F__
  (void)printf((idist < 0) ? "pvn_rzs_nrmf=" : "pvn_rzd_nrmf=");
  (void)fflush(stdout);
  t = pvn_time_mono_ns();
  f = ((idist < 0) ? PVN_FABI(pvn_rzs_nrmf,PVN_RZS_NRMF)(&n, (const float*)x) : PVN_FABI(pvn_rzd_nrmf,PVN_RZD_NRMF)(&n, (const double*)x));
  t = pvn_time_mono_ns() - t;
  (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
#endif /* __AVX512F__ */
#ifndef PVN_CILK
  (void)printf((idist < 0) ? "pvn_crs_nrmf=" : "pvn_crd_nrmf=");
  (void)fflush(stdout);
  t = pvn_time_mono_ns();
  f = ((idist < 0) ? PVN_FABI(pvn_crs_nrmf,PVN_CRS_NRMF)(&n, (const float*)x) : PVN_FABI(pvn_crd_nrmf,PVN_CRD_NRMF)(&n, (const double*)x));
  t = pvn_time_mono_ns() - t;
  (void)printf("%# .17e relerr/ε %# .17e in %21lld ns\n", f, ((idist < 0) ? frelerr(e, f) : erelerr(e, f)), t);
#ifdef PVN_MPFR
  if (argc <= 3)
    (void)PVN_FABI(pvn_mpfr_stop,PVN_MPFR_STOP)();
#endif /* PVN_MPFR */
#endif /* !PVN_CILK */
  free(x);
  return 0;
}
