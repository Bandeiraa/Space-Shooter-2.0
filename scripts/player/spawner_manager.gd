extends Node2D
class_name ShipSpawnerManager

onready var stats: Node = get_node(stats_ref)

onready var attack_timer: Timer = get_node("AttackCooldown")

onready var multi_spawner: Node2D = get_node("MultiSpawner")
onready var single_spawner: Node2D = get_node("SingleSpawner")

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
	var projectile_instance: Area2D = projectile.instance()
	projectile_instance.global_position = spawner.global_position
	get_tree().root.call_deferred("add_child", projectile_instance)
	
	
func change_ds_state(new_state: bool) -> void:
	double_shot = new_state
	if double_shot:
		multi_spawner.visible = true
		single_spawner.visible = false
		return
		
	multi_spawner.visible = false
	single_spawner.visible = true
	
	
func on_attack_cooldown_timeout() -> void:
	can_attack = true
