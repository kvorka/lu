#include <cmath>

extern "C" {
    void dgbtrs_cpp( const int* n, const int* kl, const int* ku, const double* ab, const int *ipiv, double *b ) {
            
            const int ndiag = *kl +       *ku    ;
            const int ldab  = *kl + *kl + *ku + 1;
            
            for ( int j = 0; j < *n-1; j++ ) {
                const int    i    = ipiv[j];
                const double temp = b[i];
                
                    if ( i != j ) {
                        b[i] = b[j];
                        b[j] = temp;
                    }
                
                const double *abj = &ab[ndiag+j*ldab];
                double       *bj  = &b[j];
                    
                    for ( int k = 1; k < std::min(*kl+1,*n-j); k++ ) {
                        bj[k] -= temp * abj[k];
                    }
            }
            
            for ( int j = *n-1; j >= 0; j-- ) {
                b[j] /= ab[ndiag+j*ldab];
                
                const double temp = b[j];
                const int    k    = ndiag-j;
                const double *abj = &ab[k+j*ldab];
                    
                    for ( int i = std::max(0,-k); i < j; i++) {
                          b[i] -= temp * abj[i];
                    }
            }
        }
        
}