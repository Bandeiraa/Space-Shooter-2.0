extends Node2D
class_name GameLevel

export(Vector2) var initial_ship_position

export(Array, PackedScene) var ship_list
export(Array, PackedScene) var spawner_list

func start() -> void:
	get_random_ship()
	
	for spawner in spawner_list:
		instance_spawner(spawner)
		
		
func get_random_ship() -> void:
	randomize()
	var random_number: int = randi() % ship_list.size()
	var random_ship: KinematicBody2D = ship_list[random_number].instance()
	random_ship.global_position = initial_ship_position
	add_child(random_ship)
	
	
func instance_spawner(spawner: PackedScene) -> void:
	var spawner_to_instance: Node2D = spawner.instance()
	add_child(spawner_to_instance)
