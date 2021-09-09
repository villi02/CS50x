#include <cs50.h>
#include <stdio.h>
#include <math.h> 


int main(void)
{
    int height;
    int aatte;
    do 
/// to ask for height
    {
        height = get_int("height: \n");
        aatte = height;
    }
    while (height <= 0 || 8 < aatte);
    
    /// printing the height
    int spaces;
    for (int i = 0; i < height; i++)
    {
        /// the amount of spaces left side
        for (spaces = 1; spaces < height - i; spaces++)
        {
            printf(" ");
        }
        /// # left side
        for (int j = -1; j < i; j++)
        {
            printf("#");
        }
        /// space in middle
        for (int k = 0; k < 2; k++)
        {
            printf(" ");
        }
        /// # on right side
        for (int p = -1; p < i; p++) 
        {
            printf("#");
        }
        printf("\n");
    }
}
 