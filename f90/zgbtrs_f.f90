submodule(Finterface) zgbtrs_f
  implicit none ; contains
  
  module pure subroutine zgbtrs_f90_sub(n, kl, ku, ab, ipiv, b)
    integer,         intent(in)    :: n, kl, ku
    real(real64),    intent(in)    :: ab(:,:)
    integer,         intent(in)    :: ipiv(:)
    complex(real64), intent(inout) :: b(:)
    integer                        :: i, j, k, ndiag
    complex(real64)                :: temp
    
    ndiag = kl+1+ku
    
    do j = 1, n-1
      i = ipiv(j) ; temp = b(i)
        if ( i /= j ) then
          b(i) = b(j)
          b(j) = temp
        end if
      
      do concurrent ( i = j+1:min(kl+j,n) )
        b(i) = b(i) - ab(ndiag-j+i,j) * temp
      end do
    end do
    
    do j = n, 1, -1
      b(j) = b(j) / ab(ndiag,j) ; k = ndiag-j
      
      do concurrent ( i = max(1,1-k):j-1 )
        b(i) = b(i) - b(j) * ab(k+i,j)
      end do
    end do
    
  end subroutine zgbtrs_f90_sub

end submodule zgbtrs_f