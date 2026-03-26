// Study ID: 06
// Category: basic
// Test Name: use_after_free
// Bug Type: heap-use-after-free

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

    buffer[0] = 10;
    buffer[1] = 20;
    buffer[2] = 30;
    buffer[3] = 40;

    free(buffer);

    buffer[1] = 999;

    return 0;
}