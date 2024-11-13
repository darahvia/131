#include "cdecl.h"

int PRE_CDECL asm_main( void ) POST_CDECL;

int PRE_CDECL sum_in_c(int n) POST_CDECL;

int PRE_CDECL sum_in_c2(int n, int *sum) POST_CDECL;


int main()
{
    int ret_status;
    ret_status = asm_main();
    return ret_status;
}

int sum_in_c(int n){
    int sum = 0;

    for(int i = 1; i <= n; i++){
        sum += i;
    }

    return sum;
}

/*
 * This function returns -1 if the number entered is negative
 * Else, 0 is returned
 * The return value for this function serves as an error indicator
 */
int sum_in_c2(int n, int *sum){

    if( n < 0){
        return -1;
    }

    for(int i = 1; i <= n; i++){
        *sum += i;
    }

    return 0;
}

