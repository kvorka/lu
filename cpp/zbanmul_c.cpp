#include <cmath>
#include <complex>
#include <cstring>

extern "C" {
    
    void zbanmul_cpp( const int* n, const int* ld, const int* lu, const double *M, const std::complex<double> *b, 
                      std::complex<double> *y ) {
        
        const int nc   = *n;
        const int ldc  = *ld;
        const int lduc = *ld + 1 + *lu;
        
        memset(&y[0], 0, nc * sizeof(std::complex<double>));
        
        for ( int j = 0; j < nc; j++ ) {
            for ( int i = std::max(0,ldc-j); i < std::min(lduc,ldc+nc-j); i++) {
                y[j] += M[i+j*lduc] * b[i+j-ldc];
            }
        }
        
    }
    
}