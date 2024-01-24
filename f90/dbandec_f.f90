submodule(Finterface) dbandec_f
  implicit none ; contains
  
  module pure subroutine dbandec_f90_sub(n, ld, lu, upper, lower, ipiv)
    integer,      intent(in)    :: n, ld, lu
    real(real64), intent(inout) :: upper(:,:)
    real(real64), intent(out)   :: lower(:,:)
    integer,      intent(out)   :: ipiv(:)
    integer                     :: i, j, k, l, ldu
    real(real64)                :: temp
    
    ldu = ld+1+lu
    
    k = ld
      do i = 1, ld
        do concurrent ( l = ld+2-i-k:ldu-k )
          upper(l,i) = upper(l+k,i)
        end do
        
        k = k-1
          do concurrent ( l = ldu-k:ldu )
            upper(l,i) = 0._real64
          end do
      end do
    
    do j = 1, n
      k = min(ld+j,n)
      
      i = j; temp = abs( upper(1,j) )
        do l = j, k
          if ( abs( upper(1,l) ) > temp ) then
            i   = l
            temp = abs( upper(1,l) )
          end if
        end do
      
      ipiv(j) = i
        if (i /= j) then
          do concurrent ( l = 1:ldu )
            temp       = upper(l,j)
            upper(l,j) = upper(l,i)
            upper(l,i) = temp
          end do
        end if
      
      do i = j+1, k
        lower(i-j,j) = upper(1,i) / upper(1,j)
        temp         = lower(i-j,j)
        
        do l = 1, ldu-1
          upper(l,i) = upper(l+1,i) - temp * upper(l+1,j)
        end do
        
        upper(ldu,i) = 0._real64
      end do
    end do
    
  end subroutine dbandec_f90_sub
  
end submodule dbandec_f