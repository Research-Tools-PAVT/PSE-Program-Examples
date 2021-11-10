def monty_hall(choice, switch) {
        carDoor = pyro.sample("carDoor", dist.Uniform(1,3))
        if carDoor != 1 && choice != 1: hostDoor = 1
        if carDoor != 2 && choice != 2: hostDoor = 2
        else : hostDoor = 3

        if switch: return 
        
        
                        
                              
}
