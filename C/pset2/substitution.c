// include every liberary needed (and not needed)
#include <ctype.h>
#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

int main(int argc, string argv[])
{

    // check if the key is valid
    if (argc == 2)
    {
        // if key is valid
        if (strlen(argv[1]) == 26)
        {
            int g = 0;
        }

        else
        {
            printf("Key must contain 26 characters.\n");
            return 1;
        }
    }
    
    // if the key is not valid
    else
    {
        printf("Usage: ./substitution key\n");
        return 1;
    }
    
    // check if key has anything other than letters
    for (int i = 0; strlen(argv[1]) > i; i++)
    {
        if (argv[1][i] < 65)
        {
            printf("Usage: ./substitution key\n");
            return 1;
        }
        else if (argv[1][i] < 97 && argv[1][i] > 90)
        {
            printf("Usage: ./substitution key\n");
            return 1;
        }
    }
    
    // check if key has duplicate characters
    for (int i = 0; strlen(argv[1]) > i; i++)
    {
        for (int n = 1 + i; strlen(argv[1]) > n; n++)
        {
            if (argv[1][i] == argv[1][n])
            {
                printf("Usage: ./substitution key\n");
                return 1;
            }
        }
    }

    // get plain text
    string plaintext = get_string("plaintext: ");

    // compute the ciphertext letter value
    int ciplet[strlen(plaintext)];
    for (int i = 0, n = strlen(plaintext); n > i; i++)
    {
        if (isupper(plaintext[i]))
        {
            ciplet[i] = argv[1][plaintext[i] - 'A'];
            ciplet[i] = toupper(ciplet[i]);
        }
        else if (islower(plaintext[i]))
        {
            ciplet[i] = argv[1][plaintext[i] - 'a'];
            ciplet[i] = tolower(ciplet[i]);
        }
        else
        {
            ciplet[i] = plaintext[i];
        }
    }
    
    // print the ciphertext
    printf("ciphertext: ");

    for (int i = 0; i < strlen(plaintext); i++)
    {
        printf("%c", ciplet[i]);
    }
    // print the new line after cipthertext and return sucessfull function
    printf("\n");
    return 0;

}

