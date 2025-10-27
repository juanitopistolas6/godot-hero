extends Control
var song_name_data: String
var artist_name_data: String
var image_path_data: String
var difficulty_data: String
var level_value: String
var difficulties_object: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$song.text = song_name_data
	$artist.text = artist_name_data
	$Button/cover.texture = load(image_path_data)


	
func set_song_data(song: String, artist: String, image: String, difficulty: String, level: String, difficulties: Dictionary):
	# Asignar a las variables del script (si las necesitas para otras funciones)
	song_name_data = song
	artist_name_data = artist
	image_path_data = image
	difficulty_data = difficulty
	level_value = level
	difficulties_object = difficulties
	
	# Asignar directamente a los nodos de la UI (ya que serán hijos directos)
	$song.text = song
	$artist.text = artist
	$Button/cover.texture = load(image)

func _process(delta: float) -> void:
	pass



func _on_button_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.2)
	Signals.setMenuFocused.emit(song_name_data, artist_name_data, image_path_data, difficulty_data, difficulties_object, level_value)
	z_index = 10
	



func _on_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
	z_index = 1
	
