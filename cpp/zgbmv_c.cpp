#include <cmath>
#include <complex>

/*************************************************************************************************
*  Routine for banded square matrix multiplication with a vector, y = A * x ,where y is not pre- *
*  served. A is required in a column major format A[0:kl+ku,0:n-1], see the code segment below.  *
*  {                                                                                             *
*      for ( int j = 0; j < n; j++ ) {                                                           *
*          const int k = ku + 1 - j;                                                             *
*                                                                                                *
*              for ( int i = std::max(0,j-ku), std::min(n,j+kl)                                  *
*                  A(k+i+j*(kl+ku+1)) = matrix(i+j*n);                                           *
*              }                                                                                 *
*      }                                                                                         *
*  }                                                                                             *
*************************************************************************************************/
typedef std::complex<double> dcomplex;

extern "C" {
    void zgbmv_cpp( const int* n, const int* kl, const int* ku, const double *ab, const dcomplex *x, dcomplex *y ) {
        
        const int ndiag = *kl + *ku;
        
        for ( int j = 0; j < *n; j++ ) {
            y[j] = dcomplex(0., 0.);
        }
        
        for ( int j = 0; j < *n; j++ ) {
            const dcomplex temp  = x[j];
            const double    *abj = &ab[*ku+j*ndiag];
                
                for ( int i = std::max(0,j-*ku); i < std::min(*n,j+1+*kl); i++ ) {
                    y[i] += temp * abj[i];
                }
        }
    }

}