#include <stdio.h>
#include "cdecl.h"

extern int fibo(int n);

int main()
{
    int n;
    printf("Enter a number: ");
    scanf("%d", &n);

    if (n >= 0)
    {
        fibo(n);
    }
    else
    {
        printf("Negative numbers are not allowed.\n");
    }

    return 0;
}
