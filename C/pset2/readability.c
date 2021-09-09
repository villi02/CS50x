#include <ctype.h>
#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

//index = 0.0588 * length - 0.296 * sentences - 15.8;

// define variables
int spaces;
int sentences;
int other;


int main(void)
{
    string text = get_string("Text: ");




// compute the information about text
    for (int i = 0, n = strlen(text); i < n; i++)
    {

// compute the spaces in text
        if (text[i] == 32)
        {
            spaces += 1;
        }
        if (text[i] == 46 || text[i] == 33 || text[i] == 63)
        {
            sentences += 1;
        }
        if (text[i] == 34 || text[i] == 39 || text[i] == 44)
        {
            other += 1;
        }
    }
// define letters and words
    float letters = strlen(text) - spaces - sentences - other;
    float words = spaces + 1;

// compute pr 100
    float s = sentences * 100 / words;
    float l = letters * 100 / words;

// compute the grade

    int grade = round(0.0588 * l - 0.296 * s - 15.8);
    if (grade < 1)
    {
        printf("Before Grade 1\n");
        return 0;
    }
    if (grade > 16)
    {
        printf("Grade 16+\n");
        return 0;
    }
    else
    {
        printf("Grade %d\n", grade);
    }

}
