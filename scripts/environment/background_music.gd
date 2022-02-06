extends AudioStreamPlayer
class_name BackgroundMusic

var sound_list: Dictionary = {
	"Between Worlds":"res://assets/background_music/between_worlds.ogg",
	"Endless Adventure":"res://assets/background_music/endless_adventure.ogg",
	"Galaxy Exploration" :"res://assets/background_music/galaxy_exploration.ogg",
	"Lost in Space" :"res://assets/background_music/lost_in_space.ogg"
}

func _ready() -> void:
	randomize()
	var keys: Array = sound_list.keys()
	var selected_key: String = keys[get_random_number()]
	stream = load(sound_list[selected_key])
	play()
	
	
func get_random_number() -> int:
	return randi() % sound_list.size()
