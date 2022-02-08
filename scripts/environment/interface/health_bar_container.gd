extends Control

onready var tween: Tween = get_node("Tween")

onready var health_bar: TextureProgress = get_node("BarBackground/HealthBar")
onready var health_bar_aux: TextureProgress = get_node("BarBackground/AuxHealthBar")

func update_health(damage: int) -> void:
	var current_bar_value: float = health_bar.value
	var current_aux_bar_value: float = health_bar_aux.value
	
	var _health_bar_tween: bool = tween.interpolate_property(
		health_bar,
		"value",
		current_bar_value,
		current_bar_value - damage,
		0.5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	
	var _health_aux_bar_tween: bool = tween.interpolate_property(
		health_bar_aux,
		"value",
		current_aux_bar_value,
		current_aux_bar_value - damage,
		0.5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT,
		0.5
	)
	
	var _tween_start: bool = tween.start()
