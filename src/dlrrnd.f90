!> \brief \b DLRRND
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       DOUBLE PRECISION FUNCTION DLRRND( IDIST, ISEED )
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
!> DLRRND returns a random real number from a uniform or normal
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
!> \ingroup double_matgen
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>  This routine calls the auxiliary routine DLRRAN to generate a random
!>  real number from a uniform (0,1) distribution. The Box-Muller method
!>  is used to transform numbers from a uniform to a normal distribution.
!> \endverbatim
!>
!  =====================================================================
DOUBLE PRECISION FUNCTION DLRRND( IDIST, ISEED )
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
  DOUBLE PRECISION, PARAMETER :: ZERO = 0.0D+0, ONE = 1.0D+0, TWO = 2.0D+0, TWOPI = 6.28318530717958647692528676655900576839D+0
!     ..
!     .. Local Scalars ..
  DOUBLE PRECISION :: T1, T2
!     ..
!     .. External Functions ..
  DOUBLE PRECISION, EXTERNAL :: DLRRAN
!     ..
!     .. Intrinsic Functions ..
  ! INTRINSIC :: COS, LOG, SQRT
!     ..
!     .. Executable Statements ..
!
!     Generate a real random number from a uniform (0,1) distribution
!
  T1 = DLRRAN( ISEED )
!
  IF (IDIST .EQ. 1) THEN
!
!        uniform (0,1)
!
     DLRRND = T1
  ELSE IF (IDIST .EQ. 2) THEN
!
!        uniform (-1,1)
!
     DLRRND = TWO*T1 - ONE
  ELSE IF (IDIST .EQ. 3) THEN
!
!        normal (0,1)
!
     T2 = DLRRAN( ISEED )
     DLRRND = SQRT( -TWO*LOG( T1 ) )*COS( TWOPI*T2 )
  ELSE
     DLRRND = ZERO
  END IF
END FUNCTION DLRRND
