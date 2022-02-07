extends Node2D
class_name ShipSpawnerManager

onready var stats: Node = get_node(stats_ref)

onready var attack_timer: Timer = get_node("AttackCooldown")

onready var multi_spawner: Node2D = get_node("MultiSpawner")
onready var single_spawner: Node2D = get_node("SingleSpawner")

var ball_count: int = 0
var bomb_count: int = 0
var bubble_count: int = 0

var ball: bool = false
var bomb: bool = false
var bubble: bool = false

var double_shot: bool = false
var can_attack: bool = true

export(NodePath) var stats_ref
export(PackedScene) var projectile

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and can_attack:
		can_attack = false
		if double_shot:
			attack_timer.start(stats.attack_cooldown)
			for spawner in multi_spawner.get_children():
				spawn_projectile(spawner)
				
			return
				
		attack_timer.start(stats.attack_cooldown)
		spawn_projectile(single_spawner.get_node("Spawn"))
		
		
func spawn_projectile(spawner: Position2D) -> void:
	verify_bomb()
	verify_ball()
	verify_bubble()
	
	var projectile_instance: Area2D = projectile.instance()
	projectile_instance.global_position = spawner.global_position
	projectile_instance.special_attack(bomb, ball, bubble)
	get_tree().root.call_deferred("add_child", projectile_instance)
	
	
func verify_bomb() -> void:
	if bomb:
		bomb_count -= 1
		
	if bomb_count == 0:
		bomb = false
		
		
func verify_ball() -> void:
	if ball:
		ball_count -= 1
		
	if ball_count == 0:
		ball = false
		
		
func verify_bubble() -> void:
	if bubble:
		bubble_count -= 1
		
	if bubble_count == 0:
		bubble = false
		
		
func change_ds_state(new_state: bool) -> void:
	double_shot = new_state
	if double_shot:
		multi_spawner.visible = true
		single_spawner.visible = false
		return
		
	multi_spawner.visible = false
	single_spawner.visible = true
	
	
func attack_buff(buff_name: String, buff_value: int) -> void:
	match buff_name:
		"bubble":
			bubble = true
			bubble_count += buff_value
			
		"bomb":
			bomb = true
			bomb_count += buff_value
			
		"ball":
			ball = true
			ball_count += buff_value
			
			
func on_attack_cooldown_timeout() -> void:
	can_attack = true
