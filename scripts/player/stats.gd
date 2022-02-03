extends Node
class_name ShipStats

signal double_shot

onready var boost_timer: Timer = get_node("BoostTimer")
onready var power_timer: Timer = get_node("PowerTimer")
onready var evasiveness_timer: Timer = get_node("EvasivenessTimer")

var shield: bool = false

var velocity: Vector2

var health: float = 5
var shield_health: float = 3

var buff_speed: int = 60
var base_speed: int = 120
var speed: int = base_speed

func _ready() -> void:
	for timer in get_children():
		timer.connect("timeout", self, "on_timer_timeout", [timer])
		
	buff("boost", 7.0)
	yield(get_tree().create_timer(2.0), "timeout")
	buff("boost", 7.0)
	
	
func on_area_entered(_area) -> void:
	#if area is Enemy:
	#	update_health(area.damage)
		
	#if area is PowerUp:
	#	buff(area.buff, area.buff_value)
	pass
	
	
func update_health(damage: int) -> void:
	if not verify_shield(damage):
		health -= (shield_health * -1)
		if health <= 0:
			print("Kill")
			
		shield_health = 0
		
		
func verify_shield(damage: int) -> bool:
	if shield:
		shield_health -= damage
		if shield_health <= 0:
			shield = false
			return shield
			
	return shield
	
	
func buff(buff_type: String, buff_value: float) -> void:
	match buff_type:
		"shield":
			shield_health += buff_value
			
		"power":
			var length: float = (power_timer.time_left + buff_value)
			power_timer.start(length)
			emit_signal("double_shot", true)
			
		"boost":
			var length: float = (boost_timer.time_left)
			if length == 0:
				speed = base_speed + buff_speed
				boost_timer.start(buff_value)
			else:
				length = length + buff_value
				boost_timer.start(length)
				
		"evasiveness":
			pass
			
		"recharge":
			pass
			
			
func on_timer_timeout(timer: Timer) -> void:
	match timer.name:
		"BoostTimer":
			speed = base_speed
			
		"PowerTimer":
			emit_signal("double_shot", false)
			
		"EvasivenessTimer":
			pass
