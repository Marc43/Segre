int __attribute__((naked)) main(void) {

    #define N 8

    int *a = (int*) 0xA100;
    int *b = (int*) 0xA200;
    int *c = (int*) 0xA300;

    for (int i=0; i<N; i++) {
        for (int j=0; j<N; j++) {
            a[i+j] = 4;
            b[i+j] = 4;
        }
    }

    for (int i=0; i<N; i++) {
         for(int j=0; j<N; j++) {
              c[i+j] = 0;
              for(int k = 0; k <N; k++ ) {
                    c[i+j] = c[i+j] + a[i+k] * b[k+j];
//                __asm__("nop \n");
              }
         }
    }

    __asm__("csrw 0xfff, x0 \n");
}

