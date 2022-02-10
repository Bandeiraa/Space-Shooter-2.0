extends Area2D
class_name EnemyTemplate

export(int) var speed
export(int) var damage
export(int) var health

export(Array, PackedScene) var effect_list

func _physics_process(_delta: float) -> void:
	translate(Vector2.DOWN * speed)
	
	
func on_area_entered(_area) -> void:
	pass
	
	
func on_screen_exited() -> void:
	queue_free()
	
	
func kill() -> void:
	queue_free()
	instance_explosion()
	
	
func instance_explosion() -> void:
	randomize()
	var random_number: int = randi() % effect_list.size()
	var effect_to_instance: Sprite = effect_list[random_number].instance()
	effect_to_instance.global_position = global_position
	get_tree().root.call_deferred("add_child", effect_to_instance)
