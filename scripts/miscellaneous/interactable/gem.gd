extends InteractableTemplate
class_name Gem

var value: int

export(int) var min_value
export(int) var max_value

func _ready() -> void:
	randomize()
	value = get_random_value()
	
	
func get_random_value() -> int:
	var random_number: int = randi() % max_value + min_value
	return random_number
