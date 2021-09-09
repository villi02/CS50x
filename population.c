#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // TODO: Prompt for start size
    int spop;
    do
    {
        spop = get_int("start population: ");
    }
    while (spop < 9);
    // TODO: Prompt for end size
    int epop;
    do
    {
        epop = get_int("End population: ");
    }
    while (epop < spop);
    
    // TODO: Calculate number of years until we reach threshold
    int death;
    int born;
    int n = 0;
    
    while (spop < epop)
    {
        born = (spop / 3);
        death = (spop / 4);
        spop = (spop + born - death);
        
        n++;
    }
    // TODO: Print number of years
    printf("Years: %i\n", n);

}