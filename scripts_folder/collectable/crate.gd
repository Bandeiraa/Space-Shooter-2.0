extends CollectableTemplate
class_name Crate

onready var sprite: Sprite = get_node("CollectableTexture")

onready var normal_speed: int = speed

export(int) var damage
export(int) var health

export(Array, PackedScene) var gem_list

func _ready() -> void:
	randomize()
	set_texture()
	
	
func set_texture() -> void:
	sprite.frame = randi() % 2
	
	
func on_area_entered(area) -> void:
	if area is AllyProjectile or area is BallProjectile or area is BombProjectile:
		update_health(area.damage, false, 0)
		area.kill()
		
	if area is BubbleProjectile:
		update_health(area.damage, true, area.slow)
		area.kill()
		
		
func update_health(area_damage: int, can_slow: bool, area_slow: int) -> void:
	if can_slow:
		speed = normal_speed - area_slow
		
	health -= area_damage
	if health <= 0:
		spawn_gem()
		kill()
		
		
func spawn_gem() -> void:
	var random_gem: int = randi() % gem_list.size()
	var gem: Area2D = gem_list[random_gem].instance()
	gem.global_position = global_position
	get_tree().root.call_deferred("add_child", gem)
