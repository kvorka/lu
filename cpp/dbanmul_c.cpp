#include <cmath>

extern "C" {
    void dbanmul_cpp( const int* n, const int* ld, const int* lu, const double *M, const double *b, double *y ) {
        
        const int ldu = *ld + 1 + *lu;

        for ( int j = 0; j < *n; j++ ) {
            y[j] = 0.;
            
            const double *Mj = &M[j*ldu];
            const double *bj = &b[j];
                
                for ( int i = std::max(0,*ld-j); i < std::min(ldu,*ld+*n-j); i++) {
                    y[j] += Mj[i] * bj[i-*ld];
                }
        }
    }
    
}