submodule(Finterface) zbanbks_f
  implicit none ; contains
  
  module pure subroutine zbanbks_f90_sub(n, ld, lu, upper, lower, ipiv, b)
    integer,         intent(in)    :: n, ld, lu, ipiv(:)
    real(real64),    intent(in)    :: upper(:,:), lower(:,:)
    complex(real64), intent(inout) :: b(:)
    integer                        :: i, j, k, ldu
    complex(real64)                :: temp
    
    ldu = ld + 1 + lu
    
    do j = 1, n
      i = ipiv(j) ; temp = b(i)
        if (i /= j) then
          b(i) = b(j)
          b(j) = temp
        end if
      
      do concurrent ( i = j+1:min(n,ld+j) )
        b(i) = b(i) - lower(i-j,j) * temp
      end do
    end do
    
    do i = n, 1, -1
      k = min(ldu,n-i+1)
        b(i) = ( b(i) - sum( upper(2:k,i) * b(i+1:i+k-1) ) ) / upper(1,i)
    end do
    
  end subroutine zbanbks_f90_sub
  
end submodule zbanbks_f