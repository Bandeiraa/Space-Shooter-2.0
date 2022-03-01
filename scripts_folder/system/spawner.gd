extends Node2D

onready var spawner_cooldown: Timer = get_node("SpawnerCooldown")

var y_spawn_position: float = -32

var min_x_spawn_position: float = 392
var max_x_spawn_position: float = 888

export(float) var min_spawn_time
export(float) var max_spawn_time

export(Array, PackedScene) var object_list

func _ready() -> void:
	randomize()
	spawner_cooldown.start(random_wait_time())
	
	
func spawn() -> void:
	var object_ref = object_list[random_number()].instance()
	object_ref.global_position = spawn_position()
	get_tree().root.call_deferred("add_child", object_ref)
	
	
func random_number() -> int:
	return randi() % object_list.size()
	
	
func spawn_position() -> Vector2:
	var x_spawn_position = rand_range(min_x_spawn_position, max_x_spawn_position)
	return Vector2(x_spawn_position, y_spawn_position)
	
	
func on_spawner_timeout() -> void:
	spawn()
	spawner_cooldown.start(random_wait_time())
	
	
func random_wait_time() -> float:
	return rand_range(min_spawn_time, max_spawn_time)
