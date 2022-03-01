extends Area2D
class_name BubbleProjectile

onready var detection_area: Area2D = get_node("DetectionArea")

var enemy_ref = null

var slow: int = 1

export(int) var speed
export(int) var damage

func _physics_process(_delta: float) -> void:
	if enemy_ref != null:
		var distance_to: Vector2 = (enemy_ref.global_position - global_position).normalized()
		translate(distance_to * speed)
		
	else:
		detection_area.set_deferred("monitoring", true)
		translate(Vector2.ZERO)
		
		
func on_screen_exited() -> void:
	kill()
	
	
func on_area_entered(area) -> void:
	if enemy_ref == null:
		enemy_ref = area
		
		
func on_area_exited(area) -> void:
	if area == enemy_ref:
		enemy_ref = null
		
		
func kill() -> void:
	queue_free()
