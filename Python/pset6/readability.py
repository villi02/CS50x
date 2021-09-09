from cs50 import get_string


def main():
    
    # get text from user
    text = get_string("Text:")

    # initialise variables
    spaces = 0
    sentences = 0
    other = 0

    # calculate the different values
    for i in range(0, len(text)):
        if ord(text[i]) == 32:
            spaces += 1
        elif ord(text[i]) == 46 or ord(text[i]) == 33 or ord(text[i]) == 63:
            sentences += 1
        elif ord(text[i]) == 34 or ord(text[i]) == 39 or ord(text[i]) == 44:
            other += 1

    # define letters and words
    words = spaces + 1
    letters = len(text) - spaces - sentences - other

    # compute pr 100
    s = sentences * 100 / words
    l = letters * 100 / words

    # comute the grade
    grade = round(0.0588 * l - 0.296 * s - 15.8)

    if grade < 1:
        print("Before Grade 1")

    elif grade > 16:
        print("Grade 16+")

    else:
        print("Grade", grade)


if __name__ == "__main__":
    main()