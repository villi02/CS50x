from cs50 import *

height = 0

while height > 8 or height < 1:
    # get height from user
    height = get_int("Height:")


else:
    for i in range(height):
        for spaces in range(1, height - i):
            print(" ", end="")
    
        # left side
        for j in range(-1, i):
            print("#", end="")
            
        for k in range(2):
            print(" ", end="")
    
        # right side
        for p in range(-1, i):
            print("#", end="")
        print("\n", end="")
    
