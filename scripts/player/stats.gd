extends Node
class_name ShipStats

onready var boost_timer: Timer = get_node("BoostTimer")
onready var power_timer: Timer = get_node("PowerTimer")
onready var evasiveness_timer: Timer = get_node("EvasivenessTimer")

var shield: bool = true

var velocity: Vector2

var health: int = 5
var shield_health: int = 3

var base_speed: int = 120

func _ready() -> void:
	update_health(5)
	
	
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
	
	
func buff(buff_type: String, _buff_value: int) -> void:
	match buff_type:
		"shield":
			pass
			
		"power":
			pass
			
		"boost":
			pass
			
		"evasiveness":
			pass
			
		"recharge":
			pass
