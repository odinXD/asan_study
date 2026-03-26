// Study ID: 05
// Category: basic
// Test Name: global_oob
// Bug Type: global-buffer-overflow

#include <stdio.h>

int global_buffer[4] = { 10, 20, 30, 40 };

int main(void)
{
    printf("global_buffer[0] = %d\n", global_buffer[0]);
    printf("global_buffer[1] = %d\n", global_buffer[1]);
    printf("global_buffer[2] = %d\n", global_buffer[2]);
    printf("global_buffer[3] = %d\n", global_buffer[3]);

    global_buffer[4] = 999;

    printf("This line should not be reached: %d\n", global_buffer[4]);

    return 0;
}