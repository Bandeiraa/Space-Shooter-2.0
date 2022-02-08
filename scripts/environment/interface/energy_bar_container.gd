extends Control

onready var tween: Tween = get_node("Tween")

onready var energy_bar: TextureProgress = get_node("BarBackground/EnergyBar")
onready var energy_bar_aux: TextureProgress = get_node("BarBackground/AuxEnergyBar")

func update_energy(new_value: int) -> void:
	var current_bar_value: float = energy_bar.value
	var current_aux_bar_value: float = energy_bar_aux.value
	
	var _energy_aux_bar_tween: bool = tween.interpolate_property(
		energy_bar_aux,
		"value",
		current_aux_bar_value,
		new_value,
		0.5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	
	var _energy_bar_tween: bool = tween.interpolate_property(
		energy_bar,
		"value",
		current_bar_value,
		new_value,
		0.5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT,
		0.5
	)
	
	var _tween_start: bool = tween.start()
