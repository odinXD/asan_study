// Study ID: 04
// Category: basic
// Test Name: stack_oob
// Bug Type: stack-buffer-overflow

#include <stdio.h>

int main(void)
{
    int arr[4] = { 0, 1, 2, 3 };

    printf("before overflow: %d\n", arr[0]);

    arr[4] = 100;

    printf("after overflow: %d\n", arr[4]);

    return 0;
}