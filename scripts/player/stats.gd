extends Node
class_name ShipStats

signal double_shot
signal attack_buff

onready var boost_timer: Timer = get_node("BoostTimer")
onready var power_timer: Timer = get_node("PowerTimer")
onready var evasiveness_timer: Timer = get_node("EvasivenessTimer")
onready var invulnerability_timer: Timer = get_node(invulnerability_timer_ref)

var velocity: Vector2

var health: float = 100
var initial_health: float = 100

var attack_cooldown: float = 1.0
var invulnerability_cooldown: float = 1.0

var can_receive_damage: bool = true

var shield: bool = false
var shield_health: float = 0

var ult_bar_value: float = 0
var max_ult_bar_value: float = 100

var buff_speed: int = 90
var base_speed: int = 180
var speed: int = base_speed

var gold: int = 0
var score: int = 0

var lives: int = 3

export(NodePath) var invulnerability_timer_ref

func _ready() -> void:
	for timer in get_children():
		timer.connect("timeout", self, "on_timer_timeout", [timer])
		
		
func on_area_entered(area) -> void:
	#if area is EnemyProjectile and can_receive_damage:
	#	damage_manager(area.damage)
	#	can_receive_damage = false
	#	invulnerability_timer.start(invulnerability_cooldown)
	#	area.kill()
		
	if area is PowerUp:
		buff(area.buff, area.buff_value)
		area.kill()
		
	if area is Gem:
		update_gold(area.value)
		area.kill()
		
	if area is Crate:
		damage_manager(area.damage)
		area.kill()
		
	if area is Miscellaneous:
		miscellaneous_buff(area)
		area.kill()
		
		
func damage_manager(damage: int) -> void:
	if shield:
		update_shield(damage)
	elif not shield:
		update_health(damage)
		
	if health <= 0:
		lives -= 1
		get_tree().call_group("interface", "update_life_count")
		health = initial_health
		
	if lives == 0:
		print("game over")
		
		
func update_health(damage: int):
	if shield_health < 0:
		health -= (shield_health * -1)
		get_tree().call_group("interface", "update_health", shield_health * -1)
		shield_health = 0
	else:
		health -= damage
		get_tree().call_group("interface", "update_health", damage)
		
		
func update_shield(damage: int) -> void:
	shield_health -= damage
	if shield_health <= 0:
		shield = false
		
		
func buff(buff_type: String, buff_value: float) -> void:
	match buff_type:
		"shield":
			shield_health += buff_value
			shield = true
			
		"power":
			var length: float = (power_timer.time_left + buff_value)
			power_timer.start(length)
			emit_signal("double_shot", true)
			
		"boost":
			var length: float = (boost_timer.time_left + buff_value)
			boost_timer.start(length)
			attack_cooldown = 0.5
				
		"evasiveness":
			var length: float = (evasiveness_timer.time_left + buff_value)
			evasiveness_timer.start(length)
			speed = base_speed + buff_speed
				
		"recharge":
			ult_bar_value = max_ult_bar_value
			get_tree().call_group("interface", "update_energy", ult_bar_value)
			
			
func update_gold(value: int) -> void:
	gold += value
	
	
func miscellaneous_buff(area) -> void:
	emit_signal("attack_buff", area.buff_name, area.buff_value)
	
	
func on_timer_timeout(timer: Timer) -> void:
	match timer.name:
		"BoostTimer":
			attack_cooldown = 1.0
			
		"PowerTimer":
			emit_signal("double_shot", false)
			
		"EvasivenessTimer":
			speed = base_speed
			
			
func on_invulnerability_timeout() -> void:
	can_receive_damage = true
