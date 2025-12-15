#include "pvn.h"

static void s()
{
  for (int i = -1; i < 0; --i) {
    if (powf(2.0f, scalbnf(1.0f, i)) == 1.0f) {
      (void)printf("2.0f ^ (2^%d) == 1.0f\n", i);
      break;
    }
  }
}

static void d()
{
  for (int i = -1; i < 0; --i) {
    if (pow(2.0, scalbn(1.0, i)) == 1.0) {
      (void)printf("2.0 ^ (2^%d) == 1.0\n", i);
      break;
    }
  }
}

static void x()
{
  for (int i = -1; i < 0; --i) {
    if (powl(2.0L, scalbnl(1.0L, i)) == 1.0L) {
      (void)printf("2.0L ^ (2^%d) == 1.0L\n", i);
      break;
    }
  }
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
