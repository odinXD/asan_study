// Study ID: 07
// Category: basic
// Test Name: leak
// Bug Type: memory-leak

#include <stdlib.h>

static void make_leak(void)
{
    void *p = malloc(64);
    (void)p;
}

int main(void)
{
    make_leak();
    return 0;
}