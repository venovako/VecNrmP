!> \brief \b SLRRND
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       REAL             FUNCTION SLRRND( IDIST, ISEED )
!
!       .. Scalar Arguments ..
!       INTEGER            IDIST
!       ..
!       .. Array Arguments ..
!       INTEGER            ISEED( 4 )
!       ..
!
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> SLRRND returns a random real number from a uniform or normal
!> distribution.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] IDIST
!> \verbatim
!>          IDIST is INTEGER
!>          Specifies the distribution of the random numbers:
!>          = 1:  uniform (0,1)
!>          = 2:  uniform (-1,1)
!>          = 3:  normal (0,1)
!> \endverbatim
!>
!> \param[in,out] ISEED
!> \verbatim
!>          ISEED is INTEGER array, dimension (4)
!>          On entry, the seed of the random number generator; the array
!>          elements must be between 0 and 4095, and ISEED(4) must be
!>          odd.
!>          On exit, the seed is updated.
!> \endverbatim
!
!  Authors:
!  ========
!
!> \author Univ. of Tennessee
!> \author Univ. of California Berkeley
!> \author Univ. of Colorado Denver
!> \author NAG Ltd.
!
!> \ingroup real_matgen
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>  This routine calls the auxiliary routine SLRRAN to generate a random
!>  real number from a uniform (0,1) distribution. The Box-Muller method
!>  is used to transform numbers from a uniform to a normal distribution.
!> \endverbatim
!>
!  =====================================================================
REAL FUNCTION SLRRND( IDIST, ISEED )
  IMPLICIT NONE
!
!  -- LAPACK auxiliary routine --
!  -- LAPACK is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!
!     .. Scalar Arguments ..
  INTEGER, INTENT(IN) :: IDIST
!     ..
!     .. Array Arguments ..
  INTEGER, INTENT(INOUT) :: ISEED( 4 )
!     ..
!
!  =====================================================================
!
!     .. Parameters ..
  REAL, PARAMETER :: ZERO = 0.0E+0, ONE = 1.0E+0, TWO = 2.0E+0, TWOPI = 6.28318530717958647692528676655900576839E+0
!     ..
!     .. Local Scalars ..
  REAL :: T1, T2
!     ..
!     .. External Functions ..
  REAL, EXTERNAL :: SLRRAN
!     ..
!     .. Intrinsic Functions ..
  ! INTRINSIC :: COS, LOG, SQRT
!     ..
!     .. Executable Statements ..
!
!     Generate a real random number from a uniform (0,1) distribution
!
  T1 = SLRRAN( ISEED )
!
  IF (IDIST .EQ. 1) THEN
!
!        uniform (0,1)
!
     SLRRND = T1
  ELSE IF (IDIST .EQ. 2) THEN
!
!        uniform (-1,1)
!
     SLRRND = TWO*T1 - ONE
  ELSE IF (IDIST .EQ. 3) THEN
!
!        normal (0,1)
!
     T2 = SLRRAN( ISEED )
     SLRRND = SQRT( -TWO*LOG( T1 ) )*COS( TWOPI*T2 )
  ELSE
     SLRRND = ZERO
  END IF
END FUNCTION SLRRND
