extends Sprite
class_name EffectTemplate

func on_animation_finished(anim_name: String) -> void:
	if anim_name == "effect":
		queue_free()
