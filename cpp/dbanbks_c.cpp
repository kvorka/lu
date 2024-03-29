#include <cmath>

extern "C" {
    void dbanbks_cpp( const int* n, const int* ld, const int* lu, const double *U, const double *L, const int *I, double *b ) {
        
        const int ldu = *ld + 1 + *lu;

        for ( int j = 0; j < *n; j++ ) {
            const int    i   = I[j];
            const double dum = b[i];
                
                if (i != j) {
                    b[i] = b[j];
                    b[j] = dum;
                }
                
                const double *Lj = &L[j * *ld];
                double       *bj = &b[j+1];
                    
                    for ( int k = 0; k < std::min(*n-j-1, *ld); k++ ) {
                        bj[k] -= Lj[k] * dum;
                    }
        }
        
        for ( int i = *n-1; i >= 0; i-- ) {
            const int      k = std::min(ldu,*n-i);
            const double *Uj = &U[1+i*ldu];
            const double *bl = &b[1+i];
                
                for ( int l = 0; l < k-1; l++ ) {
                    b[i] -= Uj[l] * bl[l];
                }
                
                b[i] /= U[i*ldu];
        }
    }
    
}