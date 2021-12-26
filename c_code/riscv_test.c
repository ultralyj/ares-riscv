#include <stdint.h>
#include <string.h>

#define HDMI0_Base ((uint32_t)0x01000000)
#define WHITE 0x0000FFFF
#define BLACK 0x00000000
#define BLUE 0x0000001F
#define RED 0x0000F800
#define MAGENTA 0x0000F81F
#define GREEN 0x000007E0
#define CYAN 0x00007FFF
#define YELLOW 0x0000FFE0
#define BROWN 0X0000BC40
#define blockheight 10

void delay();
void hdmi_clean(uint32_t color);
void hdmi_block(uint32_t x, uint32_t y, uint32_t x1, uint32_t y1, uint32_t color);
void printbar(int *arr, int color, int color2, int changedbar);

int main()
{
    int a[14];
    const int b[14] = {5, 2, 7, 3, 1, 1, 9, 3, 4, 5, 2, 6, 8};
    int temp = 0;
    hdmi_clean(WHITE);
    while (1)
    {
        for (int i = 0; i < 14; i++)
            a[i] = b[i];
        for (int j = 0; j < 14 - 1; j++)
        {
            for (int i = 0; i < 14 - 1 - j; i++)
            {
                if (a[i] > a[i + 1])
                {
                    temp = a[i];
                    a[i] = a[i + 1];
                    a[i + 1] = temp;
                    printbar(a, BLUE, BLACK, i);
                }
            }
        }
    }

    for (int j = 0; j < 14 - 1; j++)
    {
        printbar(a, GREEN, BLACK, j);
    }
    return 0;
}

void printbar(int *arr, int color, int color2, int changedbar)
{
    for (int k = 0; k < 14; k++)
    {
        for (int k2 = 0; k2 < 10; k2++)
        {
            if (arr[k] <= k2)
            {
                if (k != changedbar)
                {
                    hdmi_block(k2 * blockheight + blockheight, k * blockheight + blockheight, k2 * blockheight + 19, k * blockheight + 19, color);
                }
                else
                {
                    hdmi_block(k2 * blockheight + blockheight, k * blockheight + blockheight, k2 * blockheight + 19, k * blockheight + 19, GREEN);
                }
            }
            else
            {
                hdmi_block(k2 * blockheight + blockheight, k * blockheight + blockheight, k2 * blockheight + 19, k * blockheight + 19, color2);
            }
        }
    }
    delay();
}

void delay()
{
    int i, j, k;
    for (i = 0; i < 10; i++)
        for (j = 0; j < 1000; j++)
            for (k = 0; k < 1000; k++)
                ;
}

void hdmi_clean(uint32_t color)
{
    int i, j;
    uint32_t *hdmi_addr = HDMI0_Base;
    for (i = 0; i < 90; i++)
    {
        for (j = 0; j < 160; j++)
        {
            hdmi_addr[i * 256 + j] = (uint32_t)color;
        }
    }
}

void hdmi_block(uint32_t x, uint32_t y, uint32_t x1, uint32_t y1, uint32_t color)
{
    uint32_t *hdmi_addr = HDMI0_Base;
    for (uint32_t i = x; i < x1; i++)
        for (uint32_t j = y; j < y1; j++)
            hdmi_addr[i * 256 + j] = (uint32_t)color;
}
