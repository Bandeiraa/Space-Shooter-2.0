extends ProjectileTemplate
class_name AllyProjectile

var ball_direction_list: Array = [
	Vector2(1, 0),
	Vector2(-1, 0),
	Vector2(0, -1),
	Vector2(0, 1)
]

var bomb_attack: bool = false
var ball_attack: bool = false
var bubble_attack: bool = false

export(PackedScene) var ball_scene
export(PackedScene) var bomb_scene
export(PackedScene) var bubble_scene

func special_attack(bomb: bool, ball: bool, bubble: bool) -> void:
	bomb_attack = bomb
	ball_attack = ball
	bubble_attack = bubble
	
	
func kill() -> void:
	#call explosion
	bomb_special_attack()
	ball_special_attack()
	bubble_special_attack()
	queue_free()
	
	
func bomb_special_attack() -> void:
	if bomb_attack:
		var bomb_instance: Area2D = bomb_scene.instance()
		bomb_instance.global_position = global_position
		get_tree().root.call_deferred("add_child", bomb_instance)
		
		
func ball_special_attack() -> void:
	if ball_attack:
		for ball in ball_direction_list.size():
			var ball_instance: Area2D = ball_scene.instance()
			var ball_direction: Vector2 = ball_direction_list[ball]
			ball_instance.direction = ball_direction
			ball_instance.global_position = global_position
			get_tree().root.call_deferred("add_child", ball_instance)
			
			
func bubble_special_attack() -> void:
	if bubble_attack:
		var bubble_instance: Area2D = bubble_scene.instance()
		bubble_instance.global_position = global_position
		get_tree().root.call_deferred("add_child", bubble_instance)
