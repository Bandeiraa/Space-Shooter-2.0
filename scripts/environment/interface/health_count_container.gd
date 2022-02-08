extends HBoxContainer

onready var life_count: Label = get_node("LivesCount")

var lifes: int = 3

func _ready() -> void:
	life_count.text = "x" + str(lifes)
	
	
func update_life_count() -> void:
	lifes -= 1
	life_count.text = "x" + str(lifes)
