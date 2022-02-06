extends InteractableTemplate
class_name PowerUp

var buff_value: float

export(String) var buff
export(float) var min_value
export(float) var max_value

func _ready() -> void:
	randomize()
	if buff != "shield":
		buff_value = get_random_value()
		return
		
	buff_value = randi() % int(max_value + min_value)
	
	
func get_random_value() -> float:
	return rand_range(min_value, max_value)
