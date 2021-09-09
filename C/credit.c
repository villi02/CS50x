#include <cs50.h>
#include <stdio.h>
#include <math.h> 

int main(void)
{
    
    // get Number
    long number;
    
    do 
    {
        number = get_long("Number:");
    }
    while (number < 1);
    
    // find amount of digits
    long ggdigit = number;
    int digits;
    for (digits = 0; ggdigit > 0; ggdigit /= 10)
    {
        digits++;
    }
    
    // find first two digits
    int fd = 0;
    long numberlist = number;
    while (numberlist >= 99)
    {
        numberlist /= 10;
        fd = numberlist;
    }
    
    //get checksum
    int sum = 0;
    long check;
    
    for (check = number / 10; check > 0; check /= 100)
    {
        int gg = (check % 10) * 2;
        if (gg > 9)
        {
            sum += (gg % 10) + ((gg / 10) % 10);  
        }
        else 
        {
            sum += gg;
        }
     
    }
    
    // test checksum
    long other;
    int othersum = 0;
    for (other = number; other > 0; other /= 100)
    {
        othersum += other % 10;
    }
    
    int checksum = sum + othersum;
    
    
    // print invalid or move on
    if (checksum % 10 > 0)
    {
        printf("INVALID\n");
        return 0;
    }
    
   
    
    // check type of card
    
    // check if american express
    if ((fd == 34 || fd == 37) && digits == 15)
    {
        printf("AMEX\n");
        return 0;
    }
   
    // check if mastercard
    if ((fd >= 51 && fd <= 55) && digits == 16)
    {
        printf("MASTERCARD\n");
        return 0;
    }
    
    // check if visa
    if ((fd >= 40 && fd <= 49) && (digits == 16 || digits == 13))
    {
        printf("VISA\n");
        return 0;
    }
    
    else
    {
        printf("INVALID\n");
    }
    

}
