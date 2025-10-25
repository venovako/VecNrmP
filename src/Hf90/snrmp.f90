! Algorithm Hp, single precision.
PURE RECURSIVE FUNCTION SNRMP(P, M, X) RESULT(F)
  USE, INTRINSIC :: IEEE_ARITHMETIC, ONLY: IEEE_FMA
  USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: REAL32
  IMPLICIT NONE
  INTERFACE
     PURE RECURSIVE REAL FUNCTION SNRM1(M, X)
       IMPLICIT NONE
       INTEGER, INTENT(IN) :: M
       REAL, INTENT(IN) :: X(M)
     END FUNCTION SNRM1
  END INTERFACE
  INTERFACE
     PURE RECURSIVE REAL FUNCTION SNRMF(M, X)
       IMPLICIT NONE
       INTEGER, INTENT(IN) :: M
       REAL, INTENT(IN) :: X(M)
     END FUNCTION SNRMF
  END INTERFACE
  INTERFACE
     PURE RECURSIVE REAL FUNCTION SNRMI(M, X)
       IMPLICIT NONE
       INTEGER, INTENT(IN) :: M
       REAL, INTENT(IN) :: X(M)
     END FUNCTION SNRMI
  END INTERFACE
  INTEGER, PARAMETER :: K = REAL32
  REAL(KIND=K), PARAMETER :: ZERO = 0.0_K, HALF = 0.5_K, ONE = 1.0_K, TWO = 2.0_K, MZERO = -0.0_K, MONE = -1.0_K, MTWO = -2.0_K
  REAL(KIND=K), PARAMETER :: CUTOFF = SCALE(ONE, 25) ! see two_p.c
  INTEGER, INTENT(IN) :: M
  REAL(KIND=K), INTENT(IN) :: P, X(M)
  REAL(KIND=K) :: F, L, R
  INTEGER :: I
  IF (.NOT. (P .GT. ZERO)) THEN
     I = -1
     F = MONE
  ELSE IF (M .LT. 0) THEN
     I = -2
     F = MTWO
  ELSE IF (M .EQ. 0) THEN
     I = 0
     F = MZERO
  ELSE IF (M .EQ. 1) THEN
     I = 0
     F = ABS(X(1))
  ELSE IF (P .EQ. ONE) THEN
     I = 0
     F = SNRM1(M, X)
  ELSE IF (P .EQ. TWO) THEN
     I = 0
     F = SNRMF(M, X)
  ELSE IF (P .GE. CUTOFF) THEN
     I = 0
     F = SNRMI(M, X)
  ELSE IF (M .EQ. 2) THEN
     I = 1
     L = ABS(X(1))
     R = ABS(X(2))
  ELSE ! M > 2
     I = ISHFT(M, -1) + IAND(M, 1)
     L = SNRMP(P, I, X)
     R = SNRMP(P, M-I, X(I+1))
  END IF
  IF (I .GT. 0) THEN
     F = MAX(L, R)
     L = MIN(L, R)
     IF (F .GT. ZERO) THEN
        R = L / F
        L = P * HALF
        R = R ** L
        L = ONE / P
        R = IEEE_FMA(R, R, ONE)
        R = R ** L
        F = F * R
     END IF
  END IF
END FUNCTION SNRMP
