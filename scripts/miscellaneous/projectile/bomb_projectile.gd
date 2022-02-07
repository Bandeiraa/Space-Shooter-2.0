extends Area2D
class_name BombProjectile

export(int) var damage

func kill() -> void:
	queue_free()
	
	
func on_screen_exited() -> void:
	kill()
	
	
func on_explosion_timer_timeout() -> void:
	set_deferred("monitorable", true)
	yield(get_tree().create_timer(0.5), "timeout")
	kill()
