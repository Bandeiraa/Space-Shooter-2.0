extends Area2D
class_name InteractableTemplate

onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

var direction = 1

export(int) var speed

func _physics_process(_delta: float) -> void:
	translate(Vector2(0, speed * direction))
	
	
func on_screen_exited() -> void:
	kill()
	
	
func kill() -> void:
	queue_free()
