#include <stdio.h>
#include <assert.h>
#include <random>
#include <klee/klee.h>

/**
 * switch => door_switch
*/
bool montyhall(bool door_switch)
{
	std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution(0, 3);

    int host_door = 0;
    int car_door = distribution(generator);
    int choice = distribution(generator);
	
	// No distribution or probabilities here. 
	// acts like a ForAll Variable here. 
	float empty[] = {};
	
    klee_make_pse_symbolic(&choice, sizeof(choice), "choice_pse_var_sym", empty, empty);
    klee_make_symbolic(&car_door, sizeof(car_door), "car_door_sym");
    klee_make_symbolic(&host_door, sizeof(host_door), "host_door_sym");

    /**
     * Based on car door and choice, choose a host door. 
    */
    if (car_door != 1 && choice != 1)
    {
        host_door = 1;
        klee_dump_kquery_var();
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
    	klee_dump_kquery_var();
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

	klee_dump_kquery_var();
	
    if (choice == car_door)
    {
        return true;
    }
    else
    {
        klee_dump_kquery_var();
        return false;
    }

    return true;
}

int main()
{
    int choice = 0;
    bool door_switch = false;

	float _distribution[] = {0, 1};
	float _probabilities[] = {0.5, 0.5};
	
    klee_make_pse_symbolic(&door_switch, sizeof(door_switch), "door_switch_pse_var_sym", _distribution, _probabilities);
    return montyhall(door_switch);
}

