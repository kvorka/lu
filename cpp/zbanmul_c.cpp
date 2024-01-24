#include <cmath>
#include <complex>

typedef std::complex<double> dcomplex;

extern "C" {
    void zbanmul_cpp( const int* n, const int* ld, const int* lu, const double *M, const dcomplex *b, dcomplex *y ) {
        
        const int ldu = *ld + 1 + *lu;

        for ( int j = 0; j < *n; j++ ) {
            y[j] = dcomplex(0., 0.);
            
            const double   *Mj = &M[j*ldu];
            const dcomplex *bj = &b[j];
                
                for ( int i = std::max(0,*ld-j); i < std::min(ldu,*ld+*n-j); i++) {
                    y[j] += Mj[i] * bj[i-*ld];
                }
        }
    }
    
}