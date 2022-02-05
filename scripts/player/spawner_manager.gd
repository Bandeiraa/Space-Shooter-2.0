extends Node2D
class_name ShipSpawnerManager

onready var multi_spawner: Node2D = get_node("MultiSpawner")
onready var single_spawner: Node2D = get_node("SingleSpawner")

var double_shot: bool = false

func change_ds_state(new_state: bool) -> void:
	double_shot = new_state
	if double_shot:
		multi_spawner.visible = true
		single_spawner.visible = false
		return
		
	multi_spawner.visible = false
	single_spawner.visible = true
