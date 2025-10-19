#include "pvn.h"

static void s()
{
  const float one_ = nextafterf(1.0f, 2.0f);
  float _p = 0.5f;
  float p_ = 1.0f;
  while (nextafterf(_p, 1.0f) != p_) {
    const float m = (_p + p_) * 0.5f;
    float y = powf(one_, m);
    if (y == one_)
      p_ = m;
    else /* y == 1.0f */
      _p = m;
    if (_p >= p_) {
      if (_p > p_) {
        y = _p;
        _p = p_;
        p_ = y;
      }
      break;
    }
  }
  (void)printf("%#.9e ^ %#.9e = %#.9e\n", (double)one_, (double)_p, (double)powf(one_, _p));
  (void)printf("%#.9e ^ %#.9e = %#.9e\n", (double)one_, (double)p_, (double)powf(one_, p_));
}

static void d()
{
  const double one_ = nextafter(1.0, 2.0);
  double _p = 0.5;
  double p_ = 1.0;
  while (nextafter(_p, 1.0) != p_) {
    const double m = (_p + p_) * 0.5;
    double y = pow(one_, m);
    if (y == one_)
      p_ = m;
    else /* y == 1.0 */
      _p = m;
    if (_p >= p_) {
      if (_p > p_) {
        y = _p;
        _p = p_;
        p_ = y;
      }
      break;
    }
  }
  (void)printf("%#.17e ^ %#.17e = %#.17e\n", one_, _p, pow(one_, _p));
  (void)printf("%#.17e ^ %#.17e = %#.17e\n", one_, p_, pow(one_, p_));
}

static void x()
{
  const long double one_ = nextafterl(1.0L, 2.0L);
  long double _p = 0.5L;
  long double p_ = 1.0L;
  while (nextafterl(_p, 1.0L) != p_) {
    const long double m = (_p + p_) * 0.5L;
    long double y = powl(one_, m);
    if (y == one_)
      p_ = m;
    else /* y == 1.0 */
      _p = m;
    if (_p >= p_) {
      if (_p > p_) {
        y = _p;
        _p = p_;
        p_ = y;
      }
      break;
    }
  }
#ifdef __x86_64__
  (void)printf("%#.21Le ^ %#.21Le = %#.21Le\n", one_, _p, powl(one_, _p));
  (void)printf("%#.21Le ^ %#.21Le = %#.21Le\n", one_, p_, powl(one_, p_));
#else /* !__x86_64__ */
  (void)printf("%#.36Le ^ %#.36Le = %#.36Le\n", one_, _p, powl(one_, _p));
  (void)printf("%#.36Le ^ %#.36Le = %#.36Le\n", one_, p_, powl(one_, p_));
#endif /* ?__x86_64__ */
}

int main(int argc, char *argv[])
{
  if (argc != 2) {
  err:
    (void)fprintf(stderr, "%s S|D|X\n", *argv);
    return EXIT_FAILURE;
  }
  switch ((char)toupper(argv[1][0])) {
  case 'D':
    d();
    break;
  case 'S':
    s();
    break;
  case 'X':
    x();
    break;
  default:
    goto err;
  }
  return EXIT_SUCCESS;
}
