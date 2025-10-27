extends Panel
@onready var container = $HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.setMenuFocused.connect(setMenuFocused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setMenuFocused(song: String, artist: String, image: String, difficulty: String, levels: Dictionary, nivel: String):
	$song.text = str(song) 
	$cover.texture = load(image)
	$difficulty.text = difficulty
	$artist.text = str(artist)
	
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

	
	for level in levels.keys():
		var btn = Button.new()
		btn.text = level

		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.2, 0.4, 0.8) # Azul suave
		style.content_margin_left = 20
		style.content_margin_right = 20
		style.content_margin_top = 15
		style.content_margin_bottom = 15

		btn.add_theme_stylebox_override("normal", style)
		
		btn.connect("pressed", Callable(self, "_on_level_button_pressed").bind(nivel, levels[level]))
		
		container.add_child(btn)
	
	
func _on_level_button_pressed(song: String, difficulty: String):
	var parts = difficulty.split(".")
	
	Signals.level = song
	Signals.difficulty = parts[1]
	
	get_tree().change_scene_to_file("res://scenes/game.tscn")
