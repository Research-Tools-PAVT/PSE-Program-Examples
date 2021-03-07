#include <iostream>
#include <assert.h>
#include <random>

int main(void)
{
    int a, b, c, d, e, win, win_ones = 0, win_zeros = 0, run = 0, term_count = 15000;

    // // PSE variable : Random Sampling
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution1(0, 1); // b
    std::uniform_int_distribution<int> distribution2(1, 6); // e

    scanf("%d", &a); // [0, 1]
    scanf("%d", &c); // [1, 10]
    scanf("%d", &d); // [-5, 5]

    int alpha, delta;
    scanf("%d", &alpha); // COMMENT : Just for tweaking
    scanf("%d", &delta); // COMMENT : Just for tweaking

    while (term_count--)
    {
        b = distribution1(generator);
        e = distribution2(generator);

        if (a > b) // Coin Toss bug if a == 0 and rest ...
        {
            // Half the times we land here
            if (c + e > alpha) // [11, 16] for c == 10
            {
                win = 1;
                win_ones++;
            }
            else
            {
                win = 0;
                win_zeros++;
            }
        }
        else
        {
            // Or we land here on this path half the times.
            if (d + e < delta) // [-4, 1] for d == -5
            {
                win = 1;
                win_ones++;
            }
            else
            {
                win = 0;
                win_zeros++;
            }
        }
        run++;
    }

    fprintf(stderr, "a : %d, b : %d\n", a, b);
    fprintf(stderr, "win : %d, win_ones : %d\n", win, win_ones);
    printf("P(win == 1) : %f : %d\n", (double)win_ones / run, win_ones);
    printf("P(win == 0) : %f : %d\n", (double)win_zeros / run, win_zeros);

    // COMMENT : assert(P(win == 1) > 0.5);
    // COMMENT : Assert fails only when c >= 9 and d == -5 [a:0, c:9, d:-5] or [a:0, c:10, d:-5]
    return 0;
}