#include <stdint.h>

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

void delay();
void hdmi_clean(uint32_t color);
void hdmi_block(uint32_t x, uint32_t y, uint32_t x1, uint32_t y1, uint32_t color);

int main()
{
    int a[6], b[6] = {5, 2, 7, 3, 8, 1};
    int temp = 0;
    hdmi_clean(MAGENTA);
    for (int i = 0; i < 6; i++)
    {
        a[i] = b[i];
    }
    for (int j = 0; j < 6 - 1; j++)
    {
        for (int i = 0; i < 6 - 1 - j; i++)
        {
            if (a[i] > a[i + 1])
            {
                temp = a[i];
                a[i] = a[i + 1];
                a[i + 1] = temp;
                for (int k = 0; k < 6; k++)
                {
                    for (int k2 = 0; k2 < 10; k2++)
                    {
                        if (a[k] <= k2)
                        {
                            hdmi_block(k2 * 10 + 10, k * 10 + 10, k2 * 10 + 19, k * 10 + 19, RED);
                        }
                        else
                        {
                            hdmi_block(k2 * 10 + 10, k * 10 + 10, k2 * 10 + 19, k * 10 + 19, CYAN);
                        }
                    }
                }
                delay();
            }
        }
    }
    return 0;
}

void delay()
{
    int i, j, k;
    for (i = 0; i < 5; i++)
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
// int main()
// {
//     int i = 0, ans = 0;
//     for (i = 0; i < 10; i++)
//         ans += i;
//     return 0;
// }