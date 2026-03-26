// Study ID: 02
// Category: basic
// Test Name: heap_oob
// Bug Type: heap-buffer-overflow

#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int* arr = (int*)malloc(4 * sizeof(int));

    if (arr == NULL)
    {
        printf("malloc failed\n");
        return 1;
    }

    for (int i = 0; i < 4; i++)
    {
        arr[i] = i;
    }

    printf("before bug: %d\n", arr[0]);

    arr[4] = 100;

    printf("after bug: %d\n", arr[4]);

    free(arr);
    return 0;
}