import z3

choice_pse_sym, door_switch_pse_sym, car_door_pse_sym = z3.Ints("choice_pse_sym door_switch_pse_sym car_door_pse_sym")

path1 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
z3.Not(z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2))),
z3.Not(z3.Not(door_switch_pse_sym == 0))
]

path2 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2)),
z3.Not(door_switch_pse_sym == 0),
z3.Not(choice_pse_sym == 1)
]

path3 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
z3.Not(z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2))),
z3.Not(door_switch_pse_sym == 0),
choice_pse_sym == 1
]

path4 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
z3.Not(z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2))),
z3.Not(door_switch_pse_sym == 0),
z3.Not(choice_pse_sym == 1)
]

path5 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
z3.Not(z3.Not(door_switch_pse_sym == 0)),
choice_pse_sym == car_door_pse_sym
]

path6 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
z3.Not(z3.Not(door_switch_pse_sym == 0)),
z3.Not(choice_pse_sym == car_door_pse_sym)
]

path7 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2)),
z3.Not(z3.Not(door_switch_pse_sym == 0)),
choice_pse_sym == car_door_pse_sym
]

path8 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2)),
z3.Not(z3.Not(door_switch_pse_sym == 0)),
z3.Not(choice_pse_sym == car_door_pse_sym)
]

path9 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
z3.Not(door_switch_pse_sym == 0),
choice_pse_sym == 2,
car_door_pse_sym == 3
]

path10 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
z3.Not(door_switch_pse_sym == 0),
choice_pse_sym == 2,
z3.Not(car_door_pse_sym == 3)
]

path11 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
z3.Not(door_switch_pse_sym == 0),
z3.Not(choice_pse_sym == 2),
car_door_pse_sym == 2
]

path12 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1)),
z3.Not(door_switch_pse_sym == 0),
z3.Not(choice_pse_sym == 2),
z3.Not(car_door_pse_sym == 2)
]

path13 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2)),
z3.Not(door_switch_pse_sym == 0),
choice_pse_sym == 1,
car_door_pse_sym == 3
]

path14 = [
(0 <= door_switch_pse_sym),
(door_switch_pse_sym <= 1),
(0 <= choice_pse_sym),
(choice_pse_sym <= 3),
(0 <= car_door_pse_sym),
(car_door_pse_sym <= 3),
z3.Not(z3.And(z3.Not(car_door_pse_sym == 1), z3.Not(choice_pse_sym == 1))),
z3.And(z3.Not(car_door_pse_sym == 2), z3.Not(choice_pse_sym == 2)),
z3.Not(door_switch_pse_sym == 0),
choice_pse_sym == 1,
z3.Not(car_door_pse_sym == 3)
]


paths = [path1, path2, path3, path4, path5, path6, path7, path8, path9, path10, path11, path12, path13, path14]
