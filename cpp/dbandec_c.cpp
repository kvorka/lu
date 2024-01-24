#include <cmath>

extern "C" {
    void dbandec_cpp( const int* n, const int* ld, const int* lu, double *U, double *L, int *I ) {
        
        const int ldu = *ld + 1 + *lu;

        {
            int k = *ld;
                
                for ( int j = 0; j < *ld; j++ ) {
                    double *Uj = &U[*ld-k+j*(ldu-1)];
                    
                        for ( int i = 0; i < *lu+1+j; i++ ) {
                            Uj[i] = Uj[i+k];
                        }
                    
                    k -= 1;
                        
                        Uj = &U[ldu-1-k+j*ldu];
                        
                            for ( int i = 0; i < k+1; i++ ) {
                                Uj[i] = 0;
                            }
                }
        }
        
        for ( int j = 0; j < *n; j++ ) {
            const int k = std::min(*ld+j+1, *n);
            
            {
                int    l    = j;
                double temp = std::abs( U[j*ldu] );
                        
                    for ( int i = j+1; i < k; i++) {
                        if ( std::abs( U[i*ldu] ) > temp ) {
                            l    = i;
                            temp = std::abs( U[i*ldu] );
                        }
                    }
                
                if (l != j) {
                    double *Uj1 = &U[j*ldu];
                    double *Uj2 = &U[l*ldu];
                        
                        for ( int i = 0; i < ldu; i++ ) {
                            temp   = Uj1[i];
                            Uj1[i] = Uj2[i];
                            Uj2[i] = temp;
                        }
                }
                
                I[j] = l;
            }
            
            for ( int l = j+1; l < k; l++ ) {
                double       *Uj1 = &U[  l*ldu];
                const double *Uj2 = &U[1+j*ldu];
                
                    const double temp = L[l-1+j*(*ld-1)] = Uj1[0] / Uj2[-1];
                        
                        for ( int i = 0; i < ldu-1; i++ ) {
                            Uj1[i] = Uj1[i+1] - temp * Uj2[i];
                        }
                        
                        Uj1[ldu-1] = 0.;
            }
        }
    }
    
}