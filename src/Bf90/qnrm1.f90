! Algorithm B1, quadruple precision.
PURE RECURSIVE FUNCTION QNRM1(M, X) RESULT(F)
  USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: REAL128
  IMPLICIT NONE
  INTEGER, PARAMETER :: K = REAL128
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
     L = ABS(X(1))
     R = ABS(X(2))
     F = L + R
  ELSE ! M > 2
     I = ISHFT(M, -1) + IAND(M, 1)
     L = QNRM1(I, X)
     R = QNRM1(M-I, X(I+1))
     F = L + R
  END IF
END FUNCTION QNRM1
