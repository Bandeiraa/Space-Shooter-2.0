extends Node2D
class_name GameLevel

export(Vector2) var initial_ship_position

export(Array, PackedScene) var ship_list

func start() -> void:
	get_random_ship()
	
	
func get_random_ship() -> void:
	randomize()
	var random_number: int = randi() % ship_list.size()
	var random_ship: KinematicBody2D = ship_list[random_number].instance()
	random_ship.global_position = initial_ship_position
	add_child(random_ship)
