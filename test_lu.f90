program test_lu
  use omp_lib
  use Cinterface
  use Finterface
  implicit none
  
  integer, parameter :: nrhs = 600, n = 97*6+2, ld = 11, lu = 11
  
  integer                      :: iter
  integer,         allocatable :: If(:), Ic(:)
  real(real64)                 :: start, end
  real(real64),    allocatable :: Uf(:,:), Lf(:,:), Uc(:,:), Lc(:,:)
  complex(real64), allocatable :: Sf(:,:), Sc(:,:)
  
  allocate( Uf(ld+lu+1,n), Sf(n,nrhs), Lf(ld,n), If(n) )
  allocate( Uc(ld+lu+1,n), Sc(n,nrhs), Lc(ld,n), Ic(n) )
  
  call random_number(Uf); call random_number(Sf%re); call random_number(Sf%im); Uc = Uf; Sc = Sf
  
  call dbandec_f90_sub(n, ld, lu, Uf, Lf, If)
  start = omp_get_wtime()
  !$omp parallel do
  do iter = 1, nrhs
    call zbanbks_f90_sub(n, ld, lu, Uf, Lf, If, Sf(:,iter))
  end do
  !$omp end parallel do
  end = omp_get_wtime(); write(*,*) 'F90: ', end-start
  
  call dbandec_cpp_sub(n, ld, lu, Uc, Lc, Ic)
  start = omp_get_wtime()
  !$omp parallel do
  do iter = 1, nrhs
    call zbanbks_cpp_sub(n, ld, lu, Uc, Lc, Ic, Sc(:,iter))
  end do
  !$omp end parallel do
  end = omp_get_wtime(); write(*,*) 'C++: ', end-start
  
  write(*,*) maxval(abs(Sc-Sf))
  
end program test_lu