extends ParallaxBackground
class_name Background

export(Array, float) var layer_speed_list

func _process(delta: float) -> void:
	var index: int = 0
	for child in get_children():
		if child is ParallaxLayer:
			child.motion_offset.y += delta * layer_speed_list[index]
			index += 1
