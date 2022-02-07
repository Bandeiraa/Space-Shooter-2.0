extends Area2D
class_name BallProjectile

var direction: Vector2

export(int) var speed
export(int) var damage

func _physics_process(_delta: float) -> void:
	translate(direction * speed)
	
	
func kill() -> void:
	queue_free()
	
	
func on_screen_exited() -> void:
	kill()
