

int main(void)
{
    for (node *tmp = list; tmp != NULL; tmp = tmp->next)
    {

    }
}

bool unload(void)
{
    // TODO
    node *tmp = NULL;

    for (int i = 0; i < N; i++)
    {
        for (node *cursor = table[i]; cursor != NULL; cursor = cursor->next)
        {
            free(tmp);
            tmp = cursor;
        }
    }

    if (tmp == NULL)
    {
        return true;
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // TODO
    int factor = 100;
    int hasher = 0;

    for (int i = 0; i < 3; i++)
    {
        int kuk = 0;
        int bull = word[i];
        if (islower(word[i]))
        {
            kuk += bull - 96;
        }

        else
        {
            kuk += bull - 64;
        }

        hasher = hasher + kuk * factor;
        factor = factor / 10;
    }

	return hasher;
}