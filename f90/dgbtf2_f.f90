submodule(Finterface) dgbtf2_f
  implicit none ; contains
  
  module pure subroutine dgbtf2_f90_sub(n, kl, ku, ab, ipiv)
    integer,      intent(in)    :: n, kl, ku
    real(real64), intent(inout) :: ab(:,:)
    integer,      intent(out)   :: ipiv(:)
    integer                     :: ndiag, i, j, k, jp, ju, km
    real(real64)                :: temp
    
    ndiag = kl+1+ku ; ju = 1
    
    do j = ku+2, min(ndiag-1,n)
      do concurrent ( i = ndiag-j+1:kl )
        ab(i,j) = 0._real64
      end do
    end do
    
    do j = 1, n
      if ( j+ndiag-1 <= n ) then
        do concurrent ( i = 1:kl )
          ab(i,j-1+ndiag) = 0._real64
        end do
      end if
      
      jp = 0; temp = abs( ab(ndiag,j) )
        do i = 1, min( kl, n-j )
          if ( abs( ab(ndiag+i,j) ) > temp ) then
            jp   = i
            temp = abs( ab(ndiag+i,j) )
          end if
        end do
      
      km = min( kl, n-j )
      ju = max( ju, min( j+ku+jp, n ) )
      
      ipiv(j) = jp + j
        if ( jp /= 0 ) then
          do concurrent ( i = 0:ju-j )
            temp               = ab(ndiag+jp-i,j+i)
            ab(ndiag+jp-i,j+i) = ab(ndiag   -i,j+i)
            ab(ndiag   -i,j+i) = temp
          end do
        end if
      
      temp = 1 / ab(ndiag,j)
        do concurrent ( i = ndiag+1:ndiag+km )
          ab(i,j) = ab(i,j) * temp
        end do
      
      do k = 1, ju-j
        temp = ab(ndiag-k,j+k)
        
        do concurrent ( i = ndiag+1:ndiag+km )
          ab(i-k,j+k) = ab(i-k,j+k) - temp * ab(i,j)
        end do
      end do
    end do
    
  end subroutine dgbtf2_f90_sub
  
end submodule dgbtf2_f