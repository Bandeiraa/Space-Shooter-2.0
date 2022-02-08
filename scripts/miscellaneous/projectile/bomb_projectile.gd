extends Area2D
class_name BombProjectile

export(int) var damage

func _ready() -> void:
	#explosion
	pass
	
	
func kill() -> void:
	queue_free()
	
	
func on_screen_exited() -> void:
	kill()
