#include "helpers.h"
#include "math.h"

//void swap(RGBTRIPLE image[x][y], RGBTRIPLE image[a][b]);

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            float avg = (image[i][j].rgbtRed + image[i][j].rgbtGreen + image[i][j].rgbtBlue);
            // find the avrage value for the pixel
            int average = round(avg / 3);
            image[i][j].rgbtRed = average;
            image[i][j].rgbtGreen = average;
            image[i][j].rgbtBlue = average;
        }
    }

    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width / 2; j++)
        {
            // make a copy of the values
            int red = image[i][j].rgbtRed;
            int green = image[i][j].rgbtGreen;
            int blue = image[i][j].rgbtBlue;

            image[i][j].rgbtRed = image[i][width - j - 1].rgbtRed;
            image[i][j].rgbtGreen = image[i][width - j - 1].rgbtGreen;
            image[i][j].rgbtBlue = image[i][width - j - 1].rgbtBlue;

            // swap pixels with the original set
            image[i][width - j - 1].rgbtRed = red;
            image[i][width - j - 1].rgbtGreen = green;
            image[i][width - j - 1].rgbtBlue = blue;

        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    // create a temp array
    RGBTRIPLE temp[height][width];
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            temp[i][j].rgbtRed = image[i][j].rgbtRed;
            temp[i][j].rgbtGreen = image[i][j].rgbtGreen;
            temp[i][j].rgbtBlue = image[i][j].rgbtBlue;
        }
    }
    for (int i = 0; i < height; i++)
    {

        for (int j = 0; j < width; j++)
        {
            // initialise values
            double avgred = 0;
            double avggreen = 0;
            double avgblue = 0;
            double avgcount = 0;

            for (int k = i - 1; k <= i + 1; k++)
            {

                for (int p = j - 1; p <= j + 1; p++)
                {
                    // check if pixel exists
                    if (k < 0 || k >= height || p < 0 || p >= width)
                    {
                        continue;
                    }

                    else
                    {
                        avgred += temp[k][p].rgbtRed;
                        avggreen += temp[k][p].rgbtGreen;
                        avgblue += temp[k][p].rgbtBlue;
                        avgcount++;
                    }

                    // give the pixels on the image the new values
                    image[i][j].rgbtRed = round(avgred / avgcount);
                    image[i][j].rgbtGreen = round(avggreen / avgcount);
                    image[i][j].rgbtBlue = round(avgblue / avgcount);
                }
            }
        }

    }

    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    // create temp array
    // create an array that matches with the sobel operator cubes, Gx and Gy
    RGBTRIPLE temp[height][width];
    int Gx[3][3] = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
    int Gy[3][3] = {{-1, -2, -1,}, {0, 0, 0}, {1, 2, 1}};
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            temp[i][j].rgbtRed = image[i][j].rgbtRed;
            temp[i][j].rgbtGreen = image[i][j].rgbtGreen;
            temp[i][j].rgbtBlue = image[i][j].rgbtBlue;
        }
    }
    for (int i = 0; i < height; i++)
    {

        for (int j = 0; j < width; j++)
        {
            
            // initialise values
            int xavgred = 0;
            int xavggreen = 0;
            int xavgblue = 0;
            int yavgred = 0;
            int yavggreen = 0;
            int yavgblue = 0;

            for (int k = -1; k < 2; k++)
            {
                for (int p = -1; p < 2; p++)
                {
                    // check if pixel exists within picture
                    if (i + k < 0 || i + k > height - 1 || j + p < 0 || j + p > width - 1)
                    {
                        continue;
                    }
                    
                    //add all the values of Gy and Gx
                    
                    xavgred += Gx[k + 1][p + 1] * temp[i + k][j + p].rgbtRed;
                    xavggreen += Gx[k + 1][p + 1] * temp[i + k][j + p].rgbtGreen;
                    xavgblue += Gx[k + 1][p + 1] * temp[i + k][j + p].rgbtBlue;

                    yavgred += Gy[k + 1][p + 1] * temp[i + k][j + p].rgbtRed;
                    yavggreen += Gy[k + 1][p + 1] * temp[i + k][j + p].rgbtGreen;
                    yavgblue += Gy[k + 1][p + 1] * temp[i + k][j + p].rgbtBlue;

                }

            }
            
            // convert the individual Gy and Gx values to one value
            int finalred = round(sqrt(pow(xavgred, 2) + pow(yavgred, 2)));
            int finalgreen = round(sqrt(pow(xavggreen, 2) + pow(yavggreen, 2)));
            int finalblue = round(sqrt(pow(xavgblue, 2) + pow(yavgblue, 2)));

            //cap at 255
            if (finalred > 255)
            {
                finalred = 255;
            }

            if (finalgreen > 255)
            {
                finalgreen = 255;
            }

            if (finalblue > 255)
            {
                finalblue = 255;
            }

            image[i][j].rgbtRed = finalred;
            image[i][j].rgbtGreen = finalgreen;
            image[i][j].rgbtBlue = finalblue;

        }
    }
    return;
}
