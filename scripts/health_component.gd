class_name HealthComponent
extends Node2D

signal hp_changed(new_hp:int)

@export var max_hp:int
var remaining_hp:int

func _ready() -> void:
	remaining_hp = max_hp

func _decrease_hp(decrease_amount:int) -> void:
	if(decrease_amount > 0 && remaining_hp > 0):
		remaining_hp = max(remaining_hp - decrease_amount, 0)
		hp_changed.emit(remaining_hp)

func _increase_hp(increase_amount:int) -> void:
	if(increase_amount > 0 && remaining_hp < max_hp):
		remaining_hp = min(remaining_hp + increase_amount, max_hp)
		hp_changed.emit(remaining_hp)
