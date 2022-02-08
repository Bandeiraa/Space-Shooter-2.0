extends CanvasLayer

onready var animation: AnimationPlayer = get_node("Animation")
onready var lives_count: Label = get_node("HBox/LivesCount")

var lives: int = 3

func _ready() -> void:
	lives_count.text = "x" + str(lives)
	
	
func start() -> void:
	animation.play("show_interface")
	
	
func update_lives_count() -> void:
	lives -= 1
	lives_count.text = "x" + str(lives)
