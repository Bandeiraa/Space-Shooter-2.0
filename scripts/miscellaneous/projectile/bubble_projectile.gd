extends Area2D
class_name BubbleProjectile

func kill() -> void:
	queue_free()
	
	
func on_screen_exited() -> void:
	kill()
