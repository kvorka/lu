submodule(Finterface) dbanmul_f
  implicit none ; contains
  
  module pure subroutine dbanmul_f90_sub(n, ld, lu, matrix, b, y)
    integer,      intent(in)  :: n, ld, lu
    real(real64), intent(in)  :: matrix(:,:), b(:)
    real(real64), intent(out) :: y(:)
    integer                   :: i, j, k, ldu
    
    ldu = ld + 1 + lu
    
    do i = 1, n
      y(i) = 0._real64
      
      k = i-ld-1
        do concurrent ( j = max(1,1-k):min(ldu,n-k) )
          y(i) = y(i) + matrix(j,i) * b(j+k)
        end do
    end do
    
  end subroutine dbanmul_f90_sub
  
end submodule dbanmul_f