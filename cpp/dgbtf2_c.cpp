#include <cmath>

extern "C" {
    void dgbtf2_cpp( const int* n, const int* kl, const int* ku, double *ab, int *ipiv ) {
        
        const int ndiag = *kl +       *ku    ;
        const int ldab  = *kl + *kl + *ku + 1;
        const int ldab1 = *kl + *kl + *ku    ;
        
        int ju = 1;
        
        for ( int j = *ku+1; j < std::min(ndiag, *n); j++ ) {
            double *abj = &ab[ndiag+j*ldab1];
                
                for ( int i = 0; i < j-*ku; i++ ) { 
                    abj[i] = 0.;
                }
        }
        
        for ( int j = 0; j < *n; j++ ) {
            if ( j+ndiag < *n ) {
                double *abj = &ab[(j+ndiag)*ldab];
                    
                    for ( int i = 0; i < *kl; i++ ) { 
                        abj[i] = 0.;
                    }
            }
            
            const int km = std::min(*kl+1, *n-j);
            int       jp = 0;
                {
                    double *abj = &ab[ndiag+j*ldab];
                    double temp = 0.;
                    
                        for ( int i = 0; i < km; i++ ) {
                            if ( std::abs(abj[i]) > temp ) { 
                                jp   = i;
                                temp = std::abs(abj[i]);
                            }
                        }
                }
            
            ipiv[j] = jp+j;
            ju      = std::max(ju, std::min(j+1+*ku+jp, *n));
            
            if ( jp != 0 ) {
                double *abj = &ab[ndiag+j*ldab];
                double temp;
                    
                    for ( int i = 0; i < ju-j; i++ ) {
                        temp            = abj[jp+i*ldab1];
                        abj[jp+i*ldab1] = abj[   i*ldab1];
                        abj[   i*ldab1] = temp;
                    }
            }
            
            {
                double *abj = &ab[ndiag+j*ldab];
                const double temp = 1. / abj[0];
                    
                    for ( int i = 1; i < km; i++ ) {
                        abj[i] *= temp;
                    }
            }
            
            for ( int k = 1; k < ju-j; k++ ) {
                double       *abj1 = &ab[(ndiag-k)+(j+k)*ldab];
                const double *abj2 = &ab[(ndiag  )+(j  )*ldab];
                const double temp  = abj1[0];
                    
                    for ( int i = 1; i < km; i++ ) {
                        abj1[i] -= temp * abj2[i];
                    }
            }
        }
    }
    
}