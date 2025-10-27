extends Control

@onready var progress_bar: TextureProgressBar = %SongProgressBar
var activated = false
var song_length := 0.0
# 'last_percent' ya no es necesario

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not Signals.audio or not progress_bar:
		return
		
	# Cuando se asigna un stream pero la barra aún no está configurada
	if Signals.audio.stream and not activated:
		song_length = Signals.audio.stream.get_length()
		progress_bar.max_value = 100.0 # Es buena práctica usar float
		progress_bar.value = 0.0
		activated = true
	
	# Si el stream se elimina (la canción termina y se limpia)
	if not Signals.audio.stream and activated:
		activated = false
		progress_bar.value = 0
		song_length = 0.0

	# Si la canción está sonando
	if Signals.audio.is_playing():
		var current_pos = Signals.audio.get_playback_position()

		if song_length > 0:
			
			var percent = (current_pos / song_length) * 100.0
			
			progress_bar.value = percent

			
		else:
			progress_bar.value = 0
	
	elif activated:
		if Signals.audio.get_playback_position() == 0:
			progress_bar.value = 0
			activated = false # Reinicia para la próxima canción
