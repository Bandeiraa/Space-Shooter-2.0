extends Area2D
class_name CollectableTemplate

export(int) var speed

export(String) var type

export(PackedScene) var effect_ref
export(PackedScene) var sound_effect_ref

func _physics_process(_delta: float) -> void:
	translate(Vector2(0, speed))
	
	
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
	
	
func on_screen_exited() -> void:
	queue_free()
