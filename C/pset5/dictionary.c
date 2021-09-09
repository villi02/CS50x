// Implements a dictionary's functionality

#include <stdbool.h>

#include "dictionary.h"
#include <ctype.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

//declare global counter for the size function
int counter = 0;

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// Number of buckets in hash table
const unsigned int N = 15000;

// Hash table
node *table[N];

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    // TODO
    node *tmp = NULL;
    int indx = hash(word);
    for (node *cursor = table[indx]; cursor != NULL; cursor = cursor->next)
    {
        if (strcasecmp(cursor->word, word) == 0)
        {
            return true;
        }

    }

    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // TODO
    long sum = 0;
    for (int i = 0; i < strlen(word); i++)
    {
        sum += tolower(word[i]);
    }
    return sum % N;

}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    // TODO

    //Open dictionary file
    FILE *input = fopen(dictionary, "r");
    if (input == NULL)
    {
        printf("Could not open file. \n");
        return false;
    }

    //Read strings from file one at a time
    char WORD[LENGTH + 1];

    while (fscanf(input, "%s", WORD) != EOF)
    {
        //Create a new node for each word
        node *n = malloc(sizeof(node));
        if (n == NULL)
        {
            return false;
        }

        strcpy(n->word, WORD);

        //Hash word to obtain a hash value
        int indx = hash(n->word);

        //insert node into hash table at that location
        n->next = table[indx];
        table[indx] = n;
        counter++;
    }

    //close file
    fclose(input);
    
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    // TODO
    return counter;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // TODO
    

    for (int i = 0; i < N; i++)
    {
        node *cursor = table[i];
        while (cursor != NULL)
        {
            node *tmp = cursor;
            cursor = cursor->next;
            free(tmp);
            
            
        }
    
        if (cursor == NULL && i == N - 1)
        {
            return true;
        }
    }    

   

    return false;
}
