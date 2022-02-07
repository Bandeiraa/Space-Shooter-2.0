extends Area2D
class_name ProjectileTemplate

export(int) var speed
export(int) var damage
export(int, -1, 1, 1) var direction

func _physics_process(_delta: float) -> void:
	translate(Vector2(0, speed * direction))
	
	
func on_screen_exited() -> void:
	queue_free()
	
	
func kill() -> void:
	#call explosion
	queue_free()
