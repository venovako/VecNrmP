#include "pvn.h"

static void s()
{
  for (int i = -1; ; --i) {
    if (powf(2.0f, scalbnf(2.0f, i)) == 1.0f) {
      (void)printf("%d\n", i);
      break;
    }
  }
}

static void d()
{
  for (int i = -1; ; --i) {
    if (pow(2.0, scalbn(2.0, i)) == 1.0) {
      (void)printf("%d\n", i);
      break;
    }
  }
}

static void x()
{
  for (int i = -1; ; --i) {
    if (powl(2.0L, scalbnl(2.0L, i)) == 1.0L) {
      (void)printf("%d\n", i);
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
