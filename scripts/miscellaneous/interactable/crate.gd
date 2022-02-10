extends InteractableTemplate
class_name Crate

var items: Dictionary = {
	"Red Gem": "res://scenes/item/gem/blue_gem.tscn",
	"Blue Gem": "res://scenes/item/gem/blue_gem.tscn",
	"Purple Gem": "res://scenes/item/gem/purple_gem.tscn",
	"Yellow Gem": "res://scenes/item/gem/yellow_gem.tscn"
}

export(int) var health
export(int) var damage

export(Array, String) var texture_list

func _ready() -> void:
	randomize()
	set_texture()
	
	
func set_texture() -> void:
	var random_number: int = randi() % texture_list.size()
	sprite.texture = load(texture_list[random_number])
	
	
func on_area_entered(area) -> void:
	if area is AllyProjectile:
		health -= area.damage
		area.kill()
		
		if health <= 0:
			spawn_item()
			kill()
			
			
func spawn_item() -> void:
	var random_number: int = randi() % items.size()
	var keys_list: Array = items.keys()
	var dictionary_key: String = keys_list[random_number]
	var item_to_instance: Area2D = load(items[dictionary_key]).instance()
	item_to_instance.global_position = global_position
	get_tree().root.call_deferred("add_child", item_to_instance)
