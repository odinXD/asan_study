// Study ID: 03
// Category: basic
// Test Name: heap_underflow
// Bug Type: heap-buffer-underflow

#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int *buffer = (int *)malloc(4 * sizeof(int));
    if (buffer == NULL)
    {
        perror("malloc failed");
        return 1;
    }

    for (int index = 0; index < 4; index++)
    {
        buffer[index] = index + 1;
    }

    printf("buffer address: %p\n", (void *)buffer);
    printf("buffer[0] before invalid write: %d\n", buffer[0]);

    buffer[-1] = 999;   // heap underflow 발생 지점

    printf("this line may not be reached: %d\n", buffer[0]);

    free(buffer);
    return 0;
}