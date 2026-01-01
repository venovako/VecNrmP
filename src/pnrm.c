#include "pvn.h"
#include "cgic.h"

int cgiMain()
{
  void *x = NULL;
  int ret = EXIT_FAILURE;

  unsigned m = 0u;
  if (cgiFormSuccess != cgiFormIntegerBounded("m", (int*)&m, 1, 327680, 0))
    goto err;
  if (!m || (m > 327680u))
    goto err;

  double p = 0.0;
  if (cgiFormSuccess != cgiFormDoubleBounded("p", &p, FLT_MIN, INFINITY, 0.0))
    goto err;
  if (!(p > 0.0))
    goto err;

  char *prec[2] = { "float", "double" };
  unsigned r = 0u;
  if (cgiFormSuccess != cgiFormRadio("prec", prec, 2, (int*)&r, 1))
    goto err;
  if (r >= 2u)
    goto err;

  char *algo[4] = { "A", "X", "Y", "Z" };
  unsigned a = 0u;
  if (cgiFormSuccess != cgiFormRadio("algo", algo, 4, (int*)&a, 0))
    goto err;
  if (a >= 4u)
    goto err;

  size_t n = m * (r ? sizeof(double) : sizeof(float));
  if (!(x = malloc(n)))
    goto err;
  int fd = -1;
  if (cgiFormSuccess != cgiFormFileOpenDesc("inp", &fd))
    goto err;
  off_t off = 0;
  if (PVN_FABI(pvn_bread,PVN_BREAD)(&fd, x, &n, &off) != (ssize_t)n)
    off = -1;
  if (close(fd) || off)
    goto err;

  r |= (a << 1u);
  char s[26] = { '\0' };
  const float pf = (float)p;
  n = m;
  switch (r) {
  case 0u:
    (void)pvn_stoa(s, PVN_FABI(pvn_res_nrmp,PVN_RES_NRMP)(&pf, &n, (const float*)x));
    break;
  case 1u:
    (void)pvn_dtoa(s, PVN_FABI(pvn_red_nrmp,PVN_RED_NRMP)(&p, &n, (const double*)x));
    break;
  case 2u:
    (void)pvn_stoa(s, PVN_FABI(pvn_rxs_nrmp,PVN_RXS_NRMP)(&pf, &n, (const float*)x));
    break;
  case 3u:
    (void)pvn_dtoa(s, PVN_FABI(pvn_rxd_nrmp,PVN_RXD_NRMP)(&p, &n, (const double*)x));
    break;
  case 4u:
    (void)pvn_stoa(s, PVN_FABI(pvn_rys_nrmp,PVN_RYS_NRMP)(&pf, &n, (const float*)x));
    break;
  case 5u:
    (void)pvn_dtoa(s, PVN_FABI(pvn_ryd_nrmp,PVN_RYD_NRMP)(&p, &n, (const double*)x));
    break;
#ifdef __AVX512F__
  case 6u:
    (void)pvn_stoa(s, PVN_FABI(pvn_rzs_nrmp,PVN_RZS_NRMP)(&pf, &n, (const float*)x));
    break;
  case 7u:
    (void)pvn_dtoa(s, PVN_FABI(pvn_rzd_nrmp,PVN_RZD_NRMP)(&p, &n, (const double*)x));
    break;
#endif /* __AVX512F__ */
  default:
    goto err;
  }
  cgiHeaderContentType("text/html");
  (void)fprintf(cgiOut, "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n<meta charset=\"UTF-8\">\n<title>||x||_p</title>\n</head>\n<body>\n<tt>m = %u</tt><br>\n<tt>p = %#.17E</tt><br>\n<tt>a = %s</tt><br>\n<tt>||x||_p =%s</tt>\n</body>\n</html>\n", m, p, algo[a], s);
  ret = EXIT_SUCCESS;
  goto end;

 err:
  cgiHeaderStatus(400, "Bad Request");
 end:
  free(x);
  return ret;
}

int main(int argc, char *argv[])
{
  return (cgicMain(argc, argv) ? EXIT_FAILURE : cgiMain());
}
