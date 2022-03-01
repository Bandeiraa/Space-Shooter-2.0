extends Sprite

onready var stats: Node = get_node(stats_ref)

export(NodePath) var stats_ref

func _ready() -> void:
	set_shield_texture()
	
	
func _process(_delta: float) -> void:
	if stats.shield > 0:
		set_visible(true)
	elif stats.shield <= 0:
		set_visible(false)
		
		
func set_shield_texture() -> void:
	randomize()
	var random_frame: int = randi() % 2
	frame = random_frame
