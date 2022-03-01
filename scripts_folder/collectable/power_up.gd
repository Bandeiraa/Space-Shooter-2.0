extends CollectableTemplate
class_name PowerUp

var buff_value: int
var buff_duration: int

export(int) var min_buff_value
export(int) var max_buff_value

export(int) var min_buff_duration
export(int) var max_buff_duration

export(String) var buff_type

func _ready() -> void:
	randomize()
	buff_value = set_value(min_buff_value, max_buff_value)
	buff_duration = set_value(min_buff_duration, max_buff_duration)
	
	
func set_value(min_value: int, max_value: int) -> int:
	return int(rand_range(min_value, max_value))
