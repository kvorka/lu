#include <cmath>
#include <complex>

extern "C" {
    
    void zbanbks_cpp( const int* n, const int* ld, const int* lu, const double *U, const double *L, const int *I, 
                      std::complex<double> *b ) {
        
        const int nc   = *n;
        const int ldc  = *ld;
        const int luc  = *lu;
        const int lduc = *ld + 1 + *lu;

        for ( int j = 0; j < nc; j++ ) {
            
            const int i = I[j];
            const std::complex<double> temp = b[i];
                
            if (i != j) {
                b[i] = b[j];
                b[j] = temp;
            }
                
            for ( int k = 0; k < std::min(nc-j-1,ldc); k++ ) {
                b[k+j+1] -= L[k+j*ldc] * temp;
            }
            
        }
        
        for ( int i = nc-1; i >= 0; i-- ) {
            
            for ( int l = 1; l < std::min(lduc,nc-i); l++ ) {
                b[i] -= U[l+i*lduc] * b[l+i];
            }
            
            b[i] /= U[i*lduc];
            
        }
        
    }
    
}