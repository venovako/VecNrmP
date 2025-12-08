static long double PVN_FABI(pvn_crx_nrmf,PVN_CRX_NRMF)(const size_t *const n, const long double *const x)
{
#if (defined(PVN_OPENMP) && (PVN_OPENMP > 1))
#pragma omp declare reduction(hcx:long double:omp_out=hypotl(omp_out,omp_in)) initializer(omp_priv=0.0L)
#endif /* PVN_OPENMP */
  if (!n)
    return -1.0L;
  if (!*n)
    return -0.0L;
  if (!x)
    return -2.0L;
  if (*n == (size_t)1u)
    return __builtin_fabsl(*x);
  if (*n == (size_t)2u)
    return hypotl(x[0u], x[1u]);
  const size_t m = *n;
  const long double tsml = scalbnl(1.0L, -8191);
  const long double tbig = scalbnl(1.0L,  8160);
  /* the three Blue's accumulators */
  long double sml = 0.0L, med = 0.0L, big = 0.0L;
#ifndef MIMIC_LAPACK
  /* the accumulator for subnormal inputs */
  long double dnr = 0.0L;
#endif /* !MIMIC_LAPACK */
#if (defined(PVN_OPENMP) && (PVN_OPENMP > 1))
#ifdef MIMIC_LAPACK
#pragma omp parallel for default(none) shared(m,x,tsml,tbig) reduction(hcx:sml,med,big)
#else /* !MIMIC_LAPACK */
#pragma omp parallel for default(none) shared(m,x,tsml,tbig) reduction(hcx:dnr,sml,med,big)
#endif /* ?MIMIC_LAPACK */
#endif /* PVN_OPENMP */
  for (size_t i = 0u; i < m; ++i) {
    const long double y = __builtin_fabsl(x[i]);
    if (y > 0.0L) {
#ifdef MIMIC_LAPACK
      if (y < tsml)
#else /* !MIMIC_LAPACK */
      if (y < LDBL_MIN)
        dnr = hypotl(dnr, scalbnl(y, 63));
      else if (y < tsml)
#endif /* ?MIMIC_LAPACK */
        sml = hypotl(sml, y);
      else if (y > tbig)
        big = hypotl(big, y);
      else /* med */
        med = hypotl(med, y);
    }
  }
#ifndef MIMIC_LAPACK
  if (dnr > 0.0L)
    sml = hypotl(sml, scalbnl(dnr, -63));
#endif /* !MIMIC_LAPACK */
  if (sml > 0.0L)
    med = hypotl(med, sml);
  if (med > 0.0L)
    big = hypotl(big, med);
  return big;
}

#ifdef PVN_QUADMATH
static __float128 PVN_FABI(pvn_crq_nrmf,PVN_CRQ_NRMF)(const size_t *const n, const __float128 *const x)
{
#if (defined(PVN_OPENMP) && (PVN_OPENMP > 1))
#pragma omp declare reduction(hcq:__float128:omp_out=hypotq(omp_out,omp_in)) initializer(omp_priv=0.0q)
#endif /* PVN_OPENMP */
  if (!n)
    return -1.0q;
  if (!*n)
    return -0.0q;
  if (!x)
    return -2.0q;
  if (*n == (size_t)1u)
    return fabsq(*x);
  if (*n == (size_t)2u)
    return hypotq(x[0], x[1]);
  const size_t m = *n;
  const __float128 tsml = scalbnq(1.0L, -8191);
  const __float128 tbig = scalbnq(1.0L,  8136);
  /* the three Blue's accumulators */
  __float128 sml = 0.0q, med = 0.0q, big = 0.0q;
#ifndef MIMIC_LAPACK
  /* the accumulator for subnormal inputs */
  __float128 dnr = 0.0q;
#endif /* !MIMIC_LAPACK */
#if (defined(PVN_OPENMP) && (PVN_OPENMP > 1))
#ifdef MIMIC_LAPACK
#pragma omp parallel for default(none) shared(m,x,tsml,tbig) reduction(hcq:sml,med,big)
#else /* !MIMIC_LAPACK */
#pragma omp parallel for default(none) shared(m,x,tsml,tbig) reduction(hcq:dnr,sml,med,big)
#endif /* ?MIMIC_LAPACK */
#endif /* PVN_OPENMP */
  for (size_t i = 0u; i < m; ++i) {
    const __float128 y = fabsq(x[i]);
    if (y > 0.0q) {
#ifdef MIMIC_LAPACK
      if (y < tsml)
#else /* !MIMIC_LAPACK */
      if (y < FLT128_MIN)
        dnr = hypotq(dnr, scalbnq(y, 112));
      else if (y < tsml)
#endif /* ?MIMIC_LAPACK */
        sml = hypotq(sml, y);
      else if (y > tbig)
        big = hypotq(big, y);
      else /* med */
        med = hypotq(med, y);
    }
  }
#ifndef MIMIC_LAPACK
  if (dnr > 0.0q)
    sml = hypotq(sml, scalbnq(dnr, -112));
#endif /* !MIMIC_LAPACK */
  if (sml > 0.0q)
    med = hypotq(med, sml);
  if (med > 0.0q)
    big = hypotq(big, med);
  return big;
}
#else /* !PVN_QUADMATH */
static long double PVN_FABI(pvn_crq_nrmf,PVN_CRQ_NRMF)(const size_t *const n, const long double *const x)
{
  return PVN_FABI(pvn_crx_nrmf,PVN_CRX_NRMF)(n, x);
}
#endif /* ?PVN_QUADMATH */
