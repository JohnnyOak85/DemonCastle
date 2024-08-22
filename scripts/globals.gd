extends Node

var current_player:Player
var game_instance:Game

var num_zombies:int = 0

func crossed_point(position:float, target:float, delta:float):
	return (position-target)*(position-target-delta) <= 0
