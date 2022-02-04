extends KinematicBody2D
class_name Ship

onready var stats: Node = get_node("Stats")

var x_screen_size: int = 640

func _physics_process(_delta: float) -> void:
	move()
	verify_position()
	
	
func move() -> void:
	stats.velocity.x = input() * stats.speed
	stats.velocity = move_and_slide(stats.velocity)
	
	
func input() -> float:
	return Input.get_action_strength("right") - Input.get_action_strength("left")
	
	
func verify_position() -> void:
	var screen_transform: Transform2D = get_transform()
	if screen_transform.origin.x > x_screen_size:
		screen_transform.origin.x = 0
		
	if screen_transform.origin.x < 0:
		screen_transform.origin.x = x_screen_size
		
	set_transform(screen_transform)
