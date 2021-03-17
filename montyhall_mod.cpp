// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include <assert.h>
#include <stdio.h>
#include <vector>
#include <random>
std::default_random_engine generator;

/**
 * switch => door_switch
*/
bool montyhall(bool door_switch)
{
	int host_door = 0;
	int car_door, choice;

	std::default_random_engine generator1;
	std::uniform_int_distribution<int> distribution1(0, 3);
	std::uniform_int_distribution<int> distribution2(0, 3);

	choice = distribution1(generator1);
	car_door = distribution2(generator1);
	car_door = 3;
	choice = 3;

	/**
	 * Based on car door and choice, choose a host door. 
	*/
	if (car_door != 1 && choice != 1)
	{
		host_door = 1;
	}
	else if (car_door != 2 && choice != 2)
	{
		host_door = 2;
	}
	else
	{
		host_door = 3;
	}

	/**
	 * Based door_switch and host_door, change choices. 
	*/
	if (door_switch)
	{
		if (host_door == 1)
		{
			if (choice == 2)
			{
				choice = 3;
			}
			else
			{
				choice = 2;
			}
		}
		else if (host_door == 2)
		{
			if (choice == 1)
			{
				choice = 3;
			}
			else
			{
				choice = 1;
			}
		}
		else
		{
			if (choice == 1)
			{
				choice = 2;
			}
			else
			{
				choice = 1;
			}
		}
	}

	if (choice == car_door)
	{
		return true;
	}
	else
	{
		return false;
	}
}

int main()
{
	int door_switch;
	std::uniform_int_distribution<int> distribution1(0, 1);

	int termCount = 1000001, run = 0, win = 0;
	while (--termCount)
	{
		scanf("%d", &door_switch);
		if (montyhall(door_switch))
			win++;
		run++;
	}

	// COMMENT : Q1 -> assert(pwin <= 0.5f);
	// COMMENT : Q2 -> assert(pwin >= 0.5f);
	auto pwin = (double)win / run;
	printf("P(choice == car_door) : %f : %d\n", pwin, run);
	return 0;
}