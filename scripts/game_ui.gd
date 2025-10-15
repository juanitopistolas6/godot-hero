extends Control

@onready var progress_bar: TextureProgressBar = %SongProgressBar
var activated = false
var song_length := 0.0
var last_percent: float = 0.0



func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if not Signals.audio or not progress_bar:
		return
	
	# When a stream is assigned but progress bar hasn't been set up yet
	if Signals.audio.stream and not activated:
		song_length = Signals.audio.stream.get_length()
		progress_bar.max_value = 100
		activated = true
	
	# If audio is playing, update the progress bar
	if Signals.audio.is_playing():
		var current_pos = Signals.audio.get_playback_position()

		if song_length > 0:
			var percent = (current_pos / song_length) * 100.0
			var diff = percent - last_percent
			progress_bar.value += diff * 10
			last_percent = percent
			
			print("diff:", diff, " | value:", str(progress_bar.value))
		else:
			progress_bar.value = 0
