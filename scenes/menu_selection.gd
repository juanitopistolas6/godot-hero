extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.setMenuFocused.connect(setMenuFocused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setMenuFocused(song: String, artist: String, image: String, difficulty: String):
	$song.text = str(song) 
	$cover.texture = load(image)
	$difficulty.text = difficulty
	$artist.text = str(artist)
