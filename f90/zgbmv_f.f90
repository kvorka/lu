submodule(Finterface) zgbmv_f
  implicit none ; contains
  
  module pure subroutine zgbmv_f90_sub(n, kl, ku, ab, x, y)
    integer,         intent(in)  :: n, kl, ku
    real(real64),    intent(in)  :: ab(:,:)
    complex(real64), intent(in)  :: x(:)
    complex(real64), intent(out) :: y(:)
    integer                      :: i, j
    
    do concurrent ( j = 1:n )
      y(j) = cmplx(0._real64, 0._real64, kind=real64)
    end do
    
    do j = 1, n
      do concurrent ( i = max(1,j-ku):min(n,j+kl) )
        y(i) = y(i) + x(j) * ab(ku+1+i-j,j)
      end do
    end do
    
  end subroutine zgbmv_f90_sub
  
end submodule zgbmv_f