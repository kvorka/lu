module Cinterface
  implicit none
  
  interface
    subroutine dgbtf2_cpp_sub(n, kl, ku, ab, ipiv) bind(C, name='dgbtf2_cpp')
      use, intrinsic :: iso_c_binding
      
      integer(c_int), intent(in)    :: n, kl, ku
      real(c_double), intent(inout) :: ab(*)
      integer(c_int), intent(out)   :: ipiv(*)
      
    end subroutine dgbtf2_cpp_sub
    
    subroutine dgbtrs_cpp_sub(n, kl, ku, ab, ipiv, b) bind(C, name='dgbtrs_cpp')
      use, intrinsic :: iso_c_binding
      
      integer(c_int), intent(in)    :: n, kl, ku
      real(c_double), intent(in)    :: ab(*)
      integer(c_int), intent(in)    :: ipiv(*)
      real(c_double), intent(inout) :: b(*)
      
    end subroutine dgbtrs_cpp_sub
    
    subroutine zgbtrs_cpp_sub(n, kl, ku, ab, ipiv, b) bind(C, name='zgbtrs_cpp')
      use, intrinsic :: iso_c_binding
      
      integer(c_int),            intent(in)    :: n, kl, ku
      real(c_double),            intent(in)    :: ab(*)
      integer(c_int),            intent(in)    :: ipiv(*)
      complex(c_double_complex), intent(inout) :: b(*)
      
    end subroutine zgbtrs_cpp_sub
    
    subroutine dgbmv_cpp_sub(n, kl, ku, ab, x, y) bind(C, name='dgbmv_cpp')
      use, intrinsic :: iso_c_binding
      
      integer(c_int), intent(in)    :: n, kl, ku
      real(c_double), intent(in)    :: ab(*), x(*)
      real(c_double), intent(inout) :: y(*)
      
    end subroutine dgbmv_cpp_sub
    
    subroutine zgbmv_cpp_sub(n, kl, ku, ab, x, y) bind(C, name='zgbmv_cpp')
      use, intrinsic :: iso_c_binding
      
      integer(c_int),            intent(in)  :: n, kl, ku
      real(c_double),            intent(in)  :: ab(*)
      complex(c_double_complex), intent(in)  :: x(*)
      complex(c_double_complex), intent(out) :: y(*)
      
    end subroutine zgbmv_cpp_sub
    
    subroutine dbandec_cpp_sub(n, ld, lu, U, L, I) bind(C, name='dbandec_cpp')
      use, intrinsic :: iso_c_binding
      
      integer(c_int), intent(in)    :: n, ld, lu
      real(c_double), intent(inout) :: U(*)
      real(c_double), intent(out)   :: L(*)
      integer(c_int), intent(out)   :: I(*)
      
    end subroutine dbandec_cpp_sub
    
    subroutine dbanbks_cpp_sub(n, ld, lu, U, L, I, b) bind(C, name='dbanbks_cpp')
      use, intrinsic :: iso_c_binding
      
      integer(c_int), intent(in)    :: n, ld, lu
      real(c_double), intent(in)    :: U(*), L(*)
      integer(c_int), intent(in)    :: I(*)
      real(c_double), intent(inout) :: b(*)
      
    end subroutine dbanbks_cpp_sub
    
    subroutine zbanbks_cpp_sub(n, ld, lu, U, L, I, b) bind(C, name='zbanbks_cpp')
      use, intrinsic :: iso_c_binding
      
      integer(c_int),            intent(in)    :: n, ld, lu
      real(c_double),            intent(in)    :: U(*), L(*)
      integer(c_int),            intent(in)    :: I(*)
      complex(c_double_complex), intent(inout) :: b(*)
      
    end subroutine zbanbks_cpp_sub
    
    subroutine dbanmul_cpp_sub(n, ld, lu, M, b, y) bind(C, name='dbanmul_cpp')
      use, intrinsic :: iso_c_binding
      
      integer(c_int), intent(in)  :: n, ld, lu
      real(c_double), intent(in)  :: M(*), b(*)
      real(c_double), intent(out) :: y(*)
      
    end subroutine dbanmul_cpp_sub
    
    subroutine zbanmul_cpp_sub(n, ld, lu, M, b, y) bind(C, name='zbanmul_cpp')
      use, intrinsic :: iso_c_binding
      
      integer(c_int),            intent(in)  :: n, ld, lu
      real(c_double),            intent(in)  :: M(*)
      complex(c_double_complex), intent(in)  :: b(*)
      complex(c_double_complex), intent(out) :: y(*)
      
    end subroutine zbanmul_cpp_sub
  end interface
  
end module Cinterface