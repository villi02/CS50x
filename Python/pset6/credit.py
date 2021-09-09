from cs50 import *


def main():
    # get height from user
    intnumber = get_int("Number:")
    strnumber = str(intnumber)
    digits = len(strnumber)
   
    # find first two digits
    fd = intnumber
    while fd >= 100:
        fd = int(fd / 10 ** (digits - 2))
        
    firstsum = 0
    for i in range(0, digits, 2):
        gg = int(strnumber[i]) * 2
        if gg > 9:
            firstsum += int(gg / 10) + (gg % 10)
        else:
            firstsum += gg
        
    # test checksum
    checksum = firstsum
    othersum = 0
    for other in range(1, digits, 2):
        othersum = int(strnumber[other])
        checksum = checksum + othersum
    
    if checksum % 10 > 0:
        print("INVALID")
    
    # check type of card
    
    # check if american express
    if (fd == 34 or fd == 37) and digits == 15:
        print("AMEX")
    
    # check if mastercard
    elif fd in range(50, 56) and digits == 16:
        print("MASTERCARD")
    
    # check if visa
    elif fd in range(39, 50) and (digits == 16 or digits == 13):
        print("VISA")
    else:
        print("INVALID")

        
if __name__ == "__main__":
    main()