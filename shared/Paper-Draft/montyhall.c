int monty_hall(int choice, bool door_switch) {
	int car_door = uniform_int(1,3);
	int host_door;
	if (choice != 1 && car_door != 1) {
		host_door = 1;
	} else if (choice != 2 && car_door != 2) {
		host_door = 2;
	} else {
		host_door = 3;
	}
	if (door_switch) {
		if (host_door == 1) {
			if (choice == 2) {
				choice = 3;
			} else {
				choice = 2;
			}
		} else if (host_door == 2) {
			if (choice == 1) {
				choice = 3;
			} else {
				choice = 1;
			}
		} else {
			if (choice == 1) {
				choice = 2;
			} else {
				choice = 1;
			}
		}
	}
	if (choice == car_door) {
		return true;
	} else {
		return false;
	}
}