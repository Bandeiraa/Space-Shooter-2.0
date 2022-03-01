extends Area2D
class_name BallProjectile

var direction: Vector2

export(int) var speed
export(int) var damage

func _ready() -> void:
	randomize()
	direction = Vector2(random_direction()/90, -1)
	
	
func _physics_process(_delta: float) -> void:
	translate(Vector2(direction.x, -1) * speed)
	
	
func random_direction() -> float:
	return rand_range(-90, 90)
	
	
func on_screen_exited() -> void:
	kill()
	
	
func kill() -> void:
	queue_free()
