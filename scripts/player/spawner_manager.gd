extends Node2D
class_name ShipSpawnerManager

var double_shot: bool = false

func change_ds_state(new_state: bool) -> void:
	double_shot = new_state
