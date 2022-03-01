extends Area2D
class_name BombProjectile

export(int) var damage = 15

func _ready() -> void:
	yield(get_tree().create_timer(0.5), "timeout")
	explosion()
	
	
func explosion() -> void:
	set_deferred("monitorable", true)
	kill()
	
	
func on_screen_exited() -> void:
	kill()
	
	
func kill() -> void:
	queue_free()
