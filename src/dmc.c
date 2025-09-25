#include "pvn.h"

int main(int argc, char* argv[])
{
  int i = ((argc <= 1) ? 0 : 1);
  while (i < argc) {
    if (!i || !strcmp(argv[i], "M_E"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_E       ="), M_E);
    if (!i || !strcmp(argv[i], "M_LOG2E"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_LOG2E   ="), M_LOG2E);
    if (!i || !strcmp(argv[i], "M_LOG10E"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_LOG10E  ="), M_LOG10E);
    if (!i || !strcmp(argv[i], "M_LN2"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_LN2     ="), M_LN2);
    if (!i || !strcmp(argv[i], "M_LN10"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_LN10    ="), M_LN10);
    if (!i || !strcmp(argv[i], "M_PI"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_PI      ="), M_PI);
    if (!i || !strcmp(argv[i], "M_PI_2"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_PI_2    ="), M_PI_2);
    if (!i || !strcmp(argv[i], "M_PI_4"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_PI_4    ="), M_PI_4);
    if (!i || !strcmp(argv[i], "M_1_PI"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_1_PI    ="), M_1_PI);
    if (!i || !strcmp(argv[i], "M_2_PI"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_2_PI    ="), M_2_PI);
    if (!i || !strcmp(argv[i], "M_2_SQRTPI"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_2_SQRTPI="), M_2_SQRTPI);
    if (!i || !strcmp(argv[i], "M_SQRT2"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_SQRT2   ="), M_SQRT2);
    if (!i || !strcmp(argv[i], "M_SQRT1_2"))
      (void)printf("%s%#.17E\n", (i ? "" : "M_SQRT1_2 ="), M_SQRT1_2);
    ++i;
  }
  return EXIT_SUCCESS;
}
