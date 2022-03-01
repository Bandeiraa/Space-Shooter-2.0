extends Area2D
class_name AllyProjectile

var buff_list: Array = []

export(int) var speed
export(int) var damage

func _physics_process(_delta: float) -> void:
	translate(Vector2(0, -speed))
	
	
func on_screen_exited() -> void:
	queue_free()
	
	
func buff_state(buff: PackedScene) -> void:
	buff_list.append(buff)
	
	
func kill() -> void:
	for buff in buff_list:
		instance_special_projectile(buff)
		
	queue_free()
	
	
func instance_special_projectile(buff: PackedScene) -> void:
	var special_projectile: Area2D = buff.instance()
	if special_projectile.name == "Ball":
		var index: int = 3
		for i in index:
			var ball_projectile: Area2D = buff.instance()
			ball_projectile.global_position = global_position
			get_tree().root.call_deferred("add_child", ball_projectile)
			
	else:
		special_projectile.global_position = global_position
		get_tree().root.call_deferred("add_child", special_projectile)
