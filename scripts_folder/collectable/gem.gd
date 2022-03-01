extends CollectableTemplate
class_name Gem

var points: int

func _ready() -> void:
	set_points()
	
	
func set_points() -> void:
	randomize()
	points = randi() % 5 + 1
