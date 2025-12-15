#include "pvn.h"

int main(int argc, char* argv[])
{
  if (argc != 4) {
  err:
    (void)fprintf(stderr, "%s RUNs Ps PREFIX\n", *argv);
    return EXIT_FAILURE;
  }
  const int r = atoi(argv[1]);
  if ((r <= 0) || (r > 99))
    goto err;
  const int p = atoi(argv[2]);
  if ((p <= 0) || (p > 9))
    goto err;
  size_t m = strlen(argv[3]);
  char *l = strcpy((char*)malloc(m + 10u), argv[3]);
  if (!l)
    return 2;
  (void)strcpy((l+m), "_0-64.csv");
  ++m;
  FILE* f[p];
  for (int j = 0; j < p; ++j) {
    l[m] = (char)('1' + j);
    if (!(f[j] = fopen(l, "w")))
      return 3;
    (void)fprintf(f[j], "\"p");
    switch (j) {
    case 0: (void)fprintf(f[j], "=1/2"); break;
    case 1: (void)fprintf(f[j], "≈2/3"); break;
    case 2: (void)fprintf(f[j], "=1"); break;
    case 3: (void)fprintf(f[j], "≈√2"); break;
    case 4: (void)fprintf(f[j], "≈e"); break;
    case 5: (void)fprintf(f[j], "≈π"); break;
    case 6: (void)fprintf(f[j], "=∞"); break;
    default: (void)fprintf(f[j], "…%d", j); break;
    }
    (void)fprintf(f[j], "\", \"MPV\", \"MPT\", \"REV\", \"REE\", \"RET\", \"RXV\", \"RXE\", \"RXT\", \"RYV\", \"RYE\", \"RYT\", \"RZV\", \"RZE\", \"RZT\"\n");
  }
  m += 9u;
  ssize_t n = (ssize_t)0;
  for (int i = 0; i < r; ++i) {
    /* RUN */
    if ((n = getline(&l, &m, stdin)) <= (ssize_t)0)
      return 4;
    const int i_ = i + 1;
    for (int j = 0; j < p; ++j) {
      /* p */
      if ((n = getline(&l, &m, stdin)) <= (ssize_t)0)
        return 5;
      (void)fprintf(f[j], "%2d,", i_);
      for (int k = 0, o = 75; k < 7; ++k) {
        if ((n = getline(&l, &m, stdin)) <= (ssize_t)0)
          return 6;
        l[97] = l[72] = l[37] = '\0';
        (void)fprintf(f[j], "%s,", (l+13));
        if (k)
          (void)fprintf(f[j], "%s,", (l+48));
        else
          while (isspace(l[o]))
            ++o;
        (void)fprintf(f[j], " %s", (l+o));
        (void)fputc(((k < 4) ? ',' : '\n'), f[j]);
      }
    }
  }
  for (int j = (p-1); j >= 0; --j)
    if (f[j] && fclose(f[j]))
      return 7;
  if (l)
    free(l);
  return EXIT_SUCCESS;
}
