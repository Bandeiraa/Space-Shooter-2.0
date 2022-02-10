extends Area2D
class_name InteractableTemplate

onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

var direction = 1

export(int) var speed
export(Array, PackedScene) var effect_list

func _physics_process(_delta: float) -> void:
	translate(Vector2(0, speed * direction))
	
	
func on_screen_exited() -> void:
	queue_free()
	
	
func kill() -> void:
	instance_effect()
	queue_free()
	
	
func instance_effect() -> void:
	randomize()
	var random_number: int = randi() % effect_list.size()
	var effect_to_instance: Sprite = effect_list[random_number].instance()
	effect_to_instance.global_position = global_position
	get_tree().root.call_deferred("add_child", effect_to_instance)
