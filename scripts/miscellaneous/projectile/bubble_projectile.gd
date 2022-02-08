extends Area2D
class_name BubbleProjectile

var can_track_enemy: bool = true
var enemy_ref: Area2D

export(int) var speed
export(int) var damage

func _physics_process(_delta: float) -> void:
	if enemy_ref.alive:
		var enemy_position: Vector2 = enemy_ref.global_position
		var direction: Vector2 = (enemy_position - global_position).normalized()
		translate(direction * speed)
		
		
func kill() -> void:
	queue_free()
	
	
func on_screen_exited() -> void:
	kill()
	
	
func on_area_entered(_area):
	#if area is Enemy and can_track_enemy:
	#	enemy_ref = area
	#	can_track_enemy = false
	pass
