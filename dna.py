# run a DNA test

import cs50
import sys
import csv
counts = {}


def main():
    counter = 0
    STRcount = 0
    sequence = 0

    # check if provided with two files
    if len(sys.argv) != 3:
        sys.exit("Usage: python dna.py data.csv sequence.txt")

    # initialising lists
    data = []
    STR = []

    # reading dictionary into memory and converting number values to integers
    with open(sys.argv[1]) as file1:
        reader1 = csv.DictReader(file1)
        for row in reader1:
            counter += 1
            data.append(row)
        for name in row:
            if name != 'name':
                STR.append(name)
                STRcount += 1

    # define counts dictionary
    for name in STR:
        counts[name] = 0

    # sequence is the sequence as a string written in memory
    with open(sys.argv[2]) as file2:
        sequence = file2.read()

    # check for SRT match in dna sequence
    for key in STR:
        if key in sequence:
            maxrepeats(key, sequence)

    # compare answer with dictionary
    for i in range(counter):
        issame = 0
        for key in STR:
            if int(data[i][key]) == counts[key]:
                issame = issame + 1
                if issame == STRcount:
                    print(data[i]['name'])
                    return True
    print("No match")

# define function for maximum repeats


def maxrepeats(value, DNA):
    count = 0
    temp = value
    # Realized the concept behind this while loop through looking at a discussion on cs50s discord server, cant find the comment, and dont remember who wrote it
    while temp in DNA:
        count += 1
        temp += value
    if counts[value] < count:
        counts[value] = count


if __name__ == "__main__":
    main()
