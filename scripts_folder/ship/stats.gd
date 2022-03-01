extends Node

onready var projectile_spawner: Node2D = get_node(projectile_spawner_ref)

onready var ship_boost_timer: Timer = get_node("EvasivenessTimer")
onready var double_shot_timer: Timer = get_node("PowerTimer")
onready var projectile_boost_timer: Timer = get_node("BoostTimer")

onready var health: int = max_health
onready var speed: int = normal_speed

var velocity: Vector2

var score: int = 0

var shield: int = 0
var energy: int = 0

var speed_boost: int = 0

var double_shot: bool = false

export(int) var max_health
export(int) var max_energy

export(int) var normal_speed

export(NodePath) var projectile_spawner_ref

func _ready() -> void:
	for timer in get_children():
		if timer is Timer:
			timer.connect("timeout", self, "on_timer_timeout", [timer])
			
			
func on_area_entered(area) -> void:
	match area.type:
		"damage":
			update_health(area.damage)
			area.kill()
			
		"buff":
			apply_buff(area.buff_type, area.buff_value, area.buff_duration)
			area.kill()
			
		"gem":
			score += area.points
			area.kill()
			
		"special_projectile":
			projectile_spawner.special_projectile(area.sp_name, area.sp_buff)
			area.kill()
			
			
func update_health(damage: int) -> void:
	if shield > 0:
		shield -= damage
		
		if shield < 0:
			health -= (shield * -1)
			shield = 0
			
		return
		
	health -= damage
	
	
func apply_buff(buff_type: String, buff_value: int, buff_duration: int) -> void:
	match buff_type:
		"boost":
			speed_boost = buff_value
			projectile_boost_timer.start(buff_duration)
			
		"evasiveness":
			speed += buff_value
			ship_boost_timer.start(buff_duration)
			
		"power":
			double_shot = true
			double_shot_timer.start(buff_duration)
			
		"recharge":
			energy = max_energy
			
		"shield":
			shield += buff_value
			
			
func on_timer_timeout(timer: Timer) -> void:
	match timer.name:
		"BoostTimer":
			speed_boost = 0
			
		"EvasivenessTimer":
			speed = normal_speed
			
		"PowerTimer":
			double_shot = false
