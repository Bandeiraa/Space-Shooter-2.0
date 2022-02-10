extends Sprite

onready var stats: Node = get_node(stats_ref)

var shield_list: Array = [
	"res://assets/effect/shield/1.png",
	"res://assets/effect/shield/2.png"
]

export(NodePath) var stats_ref

func _ready() -> void:
	randomize()
	define_texture()
	
	
func define_texture() -> void:
	var random_number: int = randi() % shield_list.size()
	texture = load(shield_list[random_number])
	
	
func _process(_delta: float) -> void:
	if stats.shield:
		visible = true
	else:
		visible = false
