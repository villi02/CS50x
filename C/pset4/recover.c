#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(int argc, char *argv[])
{
    typedef uint8_t BYTE;

    //const int fread(argv[1], 512, 1, );

    //check for invalid usage
    if (argc < 2)
    {
        printf("Usage: ./recover image");
        return 1;
    }

    // Open file and check if it opens
    FILE *input = fopen(argv[1], "r");
    if (input == NULL)
    {
        printf("Could not open file.\n");
        return 1;
    }
    BYTE buffer[512];
    char *jpg = malloc(8);
    int counter = 0;
    FILE *img;
    while (fread(&buffer, sizeof(BYTE), 512, input) == 512)
    {
        //looking for the first pixels
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
        {
            // if identified pixels then create file to write data into
            sprintf(jpg, "%03i.jpg", counter);
            img = fopen(jpg, "w");
            fwrite(buffer, sizeof(BYTE), 512, img);
            counter++;
        }
        // if not first pixels continue to write data
        else if (!(buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0) && counter != 0)    
        {
            fwrite(buffer, sizeof(BYTE), 512, img);
            
        }
        
    }

    fclose(img);
    fclose(input);
    free(jpg);
}