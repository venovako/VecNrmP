! Algorithm H, extended precision.
PURE RECURSIVE FUNCTION XNRMF(M, X) RESULT(F)
  IMPLICIT NONE
  INTEGER, PARAMETER :: K = 10
  REAL(KIND=K), PARAMETER :: MONE = -1.0_K, MZERO = -0.0_K
  INTEGER, INTENT(IN) :: M
  REAL(KIND=K), INTENT(IN) :: X(M)
  REAL(KIND=K) :: F, L, R
  INTEGER :: I
  IF (M .LT. 0) THEN
     F = MONE
  ELSE IF (M .EQ. 0) THEN
     F = MZERO
  ELSE IF (M .EQ. 1) THEN
     F = ABS(X(1))
  ELSE IF (M .EQ. 2) THEN
     L = X(1)
     R = X(2)
     F = HYPOT(L, R)
  ELSE ! M > 2
     I = ISHFT(M, -1) + IAND(M, 1)
     L = XNRMF(I, X)
     R = XNRMF(M-I, X(I+1))
     F = HYPOT(L, R)
  END IF
END FUNCTION XNRMF
