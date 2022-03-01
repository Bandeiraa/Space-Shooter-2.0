extends Area2D
class_name Ship

onready var stats: Node = get_node("ShipStats")
onready var projectile_spawner: Node2D = get_node("ShipProjectileSpawner")

var x_screen_size: int = 1280

func _physics_process(_delta: float) -> void:
	stats.velocity.x = input() * stats.speed
	verify_position()
	translate(stats.velocity)
	
	
func input() -> float:
	var direction: float = Input.get_action_strength("right") - Input.get_action_strength("left")
	return direction
	
	
func verify_position() -> void:
	var screen_transform: Transform2D = get_transform()
	if screen_transform.origin.x > (x_screen_size - 360):
		screen_transform.origin.x = 360
		
	if screen_transform.origin.x < 360:
		screen_transform.origin.x = (x_screen_size - 360)
		
	set_transform(screen_transform)
