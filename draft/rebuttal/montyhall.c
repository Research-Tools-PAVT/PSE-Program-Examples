int monty_hall(int choice, bool door_switch) { |\label{line:monty_beg}|
  int car_door = uniform_int(1,3);
  int host_door;
  if (choice == car_door) |\label{line:monty_choice_!=_car}|
    return !door_switch; |\label{line:monty_not_switch}|
  if (choice != 1 && car_door != 1) |\label{line:monty_choice_!=_1}|
    host_door = 1;
  else if (choice != 2 && car_door != 2) |\label{line:monty_choice_!=_2}|
    host_door = 2;
	else |\label{line:monty_choice_==_3}|
		host_door = 3;
	if (door_switch) |\label{line:monty_switch}|
    if (host_door == 1)  |\label{line:monty_host_==_1}|
      if (choice == 2) |\label{line:monty_choice_==_2}|
				choice = 3;
			else 
				choice = 2;
    else if (host_door == 2) |\label{line:monty_host_==_2}|
      if (choice == 1) |\label{line:monty_choice_==_1}|
				choice = 3;
			else 
				choice = 1;
    else |\label{line:monty_host_==_3}|
			if (choice == 1) |\label{line:monty_choice_==_1_2}|
				choice = 2;
			else 
				choice = 1;
  return choice == car_door;
}
