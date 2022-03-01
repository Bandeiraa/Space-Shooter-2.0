extends Node2D

onready var timer: Timer = get_node("AttackCooldown")

onready var stats: Node = get_node(stats_ref)

onready var single_spawner: Node2D = get_node("SingleSpawner")
onready var multi_spawner: Node2D = get_node("MultiSpawner")

onready var buff_dict: Dictionary = {
	"ball_buff": [0, ball_ref],
	"bomb_buff": [0, bomb_ref],
	"bubble_buff": [0, bubble_ref]
}

var can_attack: bool = true

export(int) var base_damage

export(float) var attack_cooldown

export(NodePath) var stats_ref

export(PackedScene) var projectile_ref

export(PackedScene) var ball_ref
export(PackedScene) var bomb_ref
export(PackedScene) var bubble_ref

func _process(_delta: float) -> void:
	verify_spawner_visibility(stats.double_shot)
	if Input.is_action_just_pressed("shoot") and can_attack:
		for children in get_node(avaliable_spawner()).get_children():
			spawn_projectile(children.global_position)
				
		can_attack = false
		timer.start(attack_cooldown)
		
		
func verify_spawner_visibility(double_shot: bool) -> void:
	if double_shot:
		single_spawner.visible = false
		multi_spawner.visible = true
	else:
		single_spawner.visible = true
		multi_spawner.visible = false
		
		
func avaliable_spawner() -> String:
	if single_spawner.visible:
		return "SingleSpawner"
	else:
		return "MultiSpawner"
		
		
func spawn_projectile(spawner_position: Vector2) -> void:
	var projectile: Area2D = projectile_ref.instance()
	projectile.global_position = spawner_position
	
	for key in buff_dict.keys():
		if buff_dict[key][0] > 0:
			projectile.buff_state(buff_dict[key][1])
			buff_dict[key][0] -= 1
			
	projectile.damage += base_damage
	projectile.speed += stats.speed_boost
	get_tree().root.call_deferred("add_child", projectile)
	
	
func on_cooldown_finished() -> void:
	can_attack = true
	
	
func special_projectile(projectile_name: String, projectile_buff: int) -> void:
	buff_dict[projectile_name][0] += projectile_buff
