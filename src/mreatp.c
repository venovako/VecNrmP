#include "pvn.h"

int main(int argc, char* argv[])
{
  if (argc != 2) {
    (void)fprintf(stderr, "%s RUNs\n", *argv);
    return EXIT_FAILURE;
  }
  const int r = atoi(argv[1]);
  if ((r < 0) || (r > 99))
    return 2;
  char *l = (char*)NULL;
  size_t m = (size_t)0u;
  ssize_t n = (ssize_t)0;
  if ((n = getline(&l, &m, stdin)) <= (ssize_t)0)
    return 3;
  double d[4] = { 0.0, 0.0, 0.0, 0.0 };
  unsigned long t[4] = { 0ul, 0ul, 0ul, 0ul };
  double M[4] = { 0.0, 0.0, 0.0, 0.0 };
  unsigned long T[4] = { 0ul, 0ul, 0ul, 0ul };
  for (int i = 0; i < r; ++i) {
    if ((n = getline(&l, &m, stdin)) <= (ssize_t)0)
      return 4;
    l[n-1] = ' ';
    if (sscanf(l, " %*u, %*e, %*u, %*e, %le, %lu, %*e, %le, %lu, %*e, %le, %lu, %*e, %le, %lu", d, t, (d+1), (t+1), (d+2), (t+2), (d+3), (t+3)) <= 0)
      return 5;
    for (int j = 0; j < 4; ++j) {
      if (d[j] > M[j])
        M[j] = d[j];
      T[j] += t[j];
    }
  }
  for (int j = 0; j < 4; ++j) {
    T[j] = (T[j] + (r - 1)) / r;
    (void)fprintf(stdout, ", %#.17e, %lu", M[j], T[j]);
    if (j)
      (void)fprintf(stdout, ", %#.6Lf", ((long double)*T / (long double)(T[j])));
  }
  (void)fprintf(stdout, "\n");
  return EXIT_SUCCESS;
}
