extends Node2D

onready var spawner_timer: Timer = get_node("SpawnerCooldown")

var y_spawn_position: float = -32

var min_x_spawn_position: float = 32
var max_x_spawn_position: float = 608

export(Array, PackedScene) var objects_list

export(float) var initial_cooldown
export(float) var spawner_cooldown

func _ready() -> void:
	randomize()
	spawner_timer.start(initial_cooldown)
	
	
func on_timer_timeout() -> void:
	spawn()
	spawner_timer.start(spawner_cooldown)
	
	
func spawn() -> void:
	var object = random_item().instance()
	object.global_position = random_spawn_position()
	get_tree().root.call_deferred("add_child", object)
	
	
func random_item() -> PackedScene:
	var random_number: int = randi() % objects_list.size()
	return objects_list[random_number]
	
	
func random_spawn_position() -> Vector2:
	var random_position = rand_range(min_x_spawn_position, max_x_spawn_position)
	return Vector2(random_position, y_spawn_position)
