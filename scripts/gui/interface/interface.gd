extends CanvasLayer

onready var animation: AnimationPlayer = get_node("Animation")

onready var health_bar_container: Control = get_node("HealthBarContainer")
onready var energy_bar_container: Control = get_node("EnergyBarContainer")

onready var health_count_container: HBoxContainer = get_node("HealthCountContainer")

func start() -> void:
	animation.play("show_interface")
	
	
func update_life_count() -> void:
	health_count_container.update_life_count()
	
	
func update_health(damage: int) -> void:
	health_bar_container.update_health(damage)
	
	
func update_energy(value: int) -> void:
	energy_bar_container.update_energy(value)
