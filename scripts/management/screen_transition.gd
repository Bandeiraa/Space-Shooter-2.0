extends CanvasLayer
class_name ScreenTransition

onready var animation: AnimationPlayer = get_node("Animation")

var target_scene: String = "res://scenes/management/game_level.tscn"

func change_scene() -> void:
	var _change_scene: bool = get_tree().change_scene(target_scene)
	
	
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"fade_in":
			animation.play("fade_out")
			
		"fade_out":
			if target_scene == "res://scenes/management/game_level.tscn":
				get_tree().call_group("game_level", "start")
