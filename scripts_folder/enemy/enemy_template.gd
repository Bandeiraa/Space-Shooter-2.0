extends Area2D
class_name Enemy

onready var base_speed = speed

export(int) var speed
export(int) var health
export(int) var points
export(int) var damage

export(String) var type

export(PackedScene) var effect_ref
export(PackedScene) var sound_effect_ref

func _physics_process(_delta: float) -> void:
	translate(Vector2(0, 1) * base_speed)
	
	
func on_area_entered(area) -> void:
	if area is AllyProjectile or area is BallProjectile or area is BombProjectile:
		update_health(area.damage, false, 0)
		area.kill()
		
	if area is BubbleProjectile:
		update_health(area.damage, true, area.slow)
		area.kill()
		
		
func update_health(area_damage: int, can_slow: bool, slow_value: int) -> void:
	if can_slow:
		base_speed = speed - slow_value
		
	print(base_speed)
	health -= area_damage
	if health <= 0:
		kill()
		
		
func kill() -> void:
	instance_effect()
	instance_sound_effect()
	queue_free()
	
	
func instance_effect() -> void:
	if effect_ref != null:
		instance(effect_ref)
		
		
func instance_sound_effect() -> void:
	if sound_effect_ref != null:
		instance(sound_effect_ref)
		
		
func instance(object_ref: PackedScene) -> void:
	var object = object_ref.instance()
	get_tree().root.call_deferred("add_child", object)
