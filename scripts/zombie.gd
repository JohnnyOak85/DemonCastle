class_name Zombie
extends CharacterBody2D

const SPEED:int = 52

signal died

@onready var hitbox:Hitbox = $Hitbox
@onready var health_component:HealthComponent = $HealthComponent
@onready var gravity_component:GravityComponent = $GravityComponent
@onready var sprite:Sprite2D = $Sprite2D
@onready var flame_spawner:FlameSpawner = $FlameSpawner
@onready var stop_component:StopComponent = $StopComponent

var facing_direction = -1:
	set(new_facing_direction):
		sprite.flip_h = new_facing_direction == 1
		facing_direction = new_facing_direction

func orient_towards_player() -> void:
	if(is_instance_valid(Globals.current_player)):
		facing_direction = sign(Globals.current_player.global_position.x - global_position.x)
		if(facing_direction == 0):
			facing_direction = -1

func _ready() -> void:
	Globals.num_zombies += 1
	orient_towards_player()

func _physics_process(delta: float) -> void:
	if(stop_component.is_stopped):
		return
	velocity = gravity_component.apply_gravity(velocity, delta)
	if(is_on_wall()):
		facing_direction *= -1
	if(is_on_floor()):
		velocity.x = SPEED * facing_direction
	else:
		velocity.x = 0
	move_and_slide()

func _on_hp_changed(new_hp:int) -> void:
	if(new_hp <= 0):
		flame_spawner.spawn_flame()
		died.emit()
		queue_free()
		return
	stop_component.stun()

func _notification(what: int) -> void:
	if(what == NOTIFICATION_PREDELETE):
		Globals.num_zombies -= 1
