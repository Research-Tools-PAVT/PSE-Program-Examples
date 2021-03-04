#include <iostream>
#include <random>

int main(void)
{
    int a, b, c, d;

    // forall variable
    scanf("%d", &a);
    scanf("%d", &b);
    scanf("%d", &c);

    // PSE variable : Random Sampling
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution(0, 500);

    if (a + b > c + d)
    {
        if (a > b)
        {
            a = 100;
            b = 500;
        }
        else
        {
            a = 500;
            b = 100;
        }
    }
    else
    {
        if (c > d)
        {
            a = 100;
            c = 100;
            b = 600;
            d = distribution(generator);
        }
        else
        {
            a = 600;
            c = 600;
            b = 100;
            d = distribution(generator);
        }
    }

    if (a + c > b + d)
    {
        a = 200;
        b = -150;
        c = -20;
        d = distribution(generator);
    }

    return 0;
}