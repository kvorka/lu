#include <cmath>

extern "C" {
    
    void dbandec_cpp( const int* n, const int* ld, const int* lu, double *U, double *L, int *I ) {
        
        const int nc   = *n;
        const int ldc  = *ld;
        const int luc  = *lu;
        const int lduc = *ld + 1 + *lu;

        {
            int k = ldc;
            
            for ( int j = 0; j < ldc; j++ ) {
                {
                    double *Uj = &U[ldc-k-j+j*lduc];
                    
                    for ( int i = 0; i < luc+1+j; i++ ) {
                        Uj[i] = Uj[i+k];
                    }
                    
                    for ( int i = luc+1+j; i < luc+1+j+k; i++) {
                        Uj[i] = 0;
                    }
                }
                
                k -= 1;
            }
        }
        
        {
            for ( int j = 0; j < nc; j++ ) {
                const int k = std::min(ldc+j+1, nc);
                
                {
                    int l = j;
                    double temp = std::abs( U[j*lduc] );
                    
                    for ( int i = j+1; i < k; i++) {
                        if ( std::abs( U[i*lduc] ) > temp ) {
                            l    = i;
                            temp = std::abs( U[i*lduc] );
                        }
                    }
                    
                    if (l != j) {
                        double *Uj1 = &U[j*lduc];
                        double *Uj2 = &U[l*lduc];
                        
                        for ( int i = 0; i < lduc; i++ ) {
                            temp   = Uj1[i];
                            Uj1[i] = Uj2[i];
                            Uj2[i] = temp;
                        }
                    }
                    
                    I[j] = l;
                }
                
                for ( int l = j+1; l < k; l++ ) {
                    double       *Uj1 = &U[  l*lduc];
                    const double *Uj2 = &U[1+j*lduc];
                    const double temp = L[l-1+j*(ldc-1)] = Uj1[0] / Uj2[-1];
                    
                    for ( int i = 0; i < lduc-1; i++ ) {
                        Uj1[i] = Uj1[i+1] - temp * Uj2[i];
                    }
                    
                    Uj1[lduc-1] = 0.;
                }
            }
        }
    }
    
}