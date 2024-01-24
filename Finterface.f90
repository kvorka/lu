module Finterface
  use iso_fortran_env, only: real64
  implicit none
  
  interface
    module pure subroutine dgbtf2_f90_sub(n, kl, ku, ab, ipiv)
      use iso_fortran_env, only: real64
      
      integer,      intent(in)    :: n, kl, ku
      real(real64), intent(inout) :: ab(:,:)
      integer,      intent(out)   :: ipiv(:)
      
    end subroutine dgbtf2_f90_sub
    
    module pure subroutine dgbtrs_f90_sub(n, kl, ku, ab, ipiv, b)
      use iso_fortran_env, only: real64
      
      integer,      intent(in)    :: n, kl, ku
      real(real64), intent(in)    :: ab(:,:)
      integer,      intent(in)    :: ipiv(:)
      real(real64), intent(inout) :: b(:)
      
    end subroutine dgbtrs_f90_sub
    
    module pure subroutine zgbtrs_f90_sub(n, kl, ku, ab, ipiv, b)
      use iso_fortran_env, only: real64
      
      integer,         intent(in)    :: n, kl, ku
      real(real64),    intent(in)    :: ab(:,:)
      integer,         intent(in)    :: ipiv(:)
      complex(real64), intent(inout) :: b(:)
      
    end subroutine zgbtrs_f90_sub
    
    module pure subroutine dgbmv_f90_sub(n, kl, ku, ab, x, y)
      use iso_fortran_env, only: real64
      
      integer,      intent(in)  :: n, kl, ku
      real(real64), intent(in)  :: ab(:,:), x(:)
      real(real64), intent(out) :: y(:)
      
    end subroutine dgbmv_f90_sub
    
    module pure subroutine zgbmv_f90_sub(n, kl, ku, ab, x, y)
      use iso_fortran_env, only: real64
      
      integer,         intent(in)  :: n, kl, ku
      real(real64),    intent(in)  :: ab(:,:)
      complex(real64), intent(in)  :: x(:)
      complex(real64), intent(out) :: y(:)
      
    end subroutine zgbmv_f90_sub
    
    module pure subroutine dbandec_f90_sub(n, ld, lu, upper, lower, ipiv)
      integer,      intent(in)    :: n, ld, lu
      real(real64), intent(inout) :: upper(:,:)
      real(real64), intent(out)   :: lower(:,:)
      integer,      intent(out)   :: ipiv(:)
    end subroutine dbandec_f90_sub
    
    module pure subroutine dbanbks_f90_sub(n, ld, lu, upper, lower, ipiv, b)
      integer,      intent(in)    :: n, ld, lu, ipiv(:)
      real(real64), intent(in)    :: upper(:,:), lower(:,:)
      real(real64), intent(inout) :: b(:)
    end subroutine dbanbks_f90_sub
    
    module pure subroutine dbanmul_f90_sub(n, ld, lu, matrix, b, y)
      integer,      intent(in)  :: n, ld, lu
      real(real64), intent(in)  :: matrix(:,:), b(:)
      real(real64), intent(out) :: y(:)
    end subroutine dbanmul_f90_sub
    
    module pure subroutine zbanbks_f90_sub(n, ld, lu, upper, lower, ipiv, b)
      integer,         intent(in)    :: n, ld, lu, ipiv(:)
      real(real64),    intent(in)    :: upper(:,:), lower(:,:)
      complex(real64), intent(inout) :: b(:)
    end subroutine zbanbks_f90_sub
    
    module pure subroutine zbanmul_f90_sub(n, ld, lu, matrix, b, y)
      integer,         intent(in)  :: n, ld, lu
      real(real64),    intent(in)  :: matrix(:,:)
      complex(real64), intent(in)  :: b(:)
      complex(real64), intent(out) :: y(:)
    end subroutine zbanmul_f90_sub
  end interface
  
end module Finterface