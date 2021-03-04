#include <iostream>
#include <random>

/**
 * Processed by transforamtion pass
*/
int main(void)
{
    int a, b, c, d, assert_false = 0, termCount = 500;

    // forall variable
    scanf("%d", &a);
    scanf("%d", &b);
    scanf("%d", &c);

    // PSE variable : Random Sampling
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution(0, 500);

    std::cout << "Execs : " << termCount
              << "\n";

    while (termCount--)
    {
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

        std::cerr << "\nd : " << d;
        if (a + b + c + d - 1100 <= 0)
            assert_false++;
    }

    std::cout << "Hit : " << assert_false
              << "\n";

    return 0;
}