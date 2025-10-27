extends Node2D

const in_edit_node: bool = false
@export var current_level_name: String
@export var current_level_difficulty: String

var fk_fall_time: float = 1.9666
var fk_output_arr = [[], [], [], []]

var level_info = {
	"NOKIA": {
		"difficulties": {
			"EXPERT": NokiaV.EXPERT,
			"HARD": NokiaV.HARD,
			"MEDIUM": NokiaV.MEDIUM,
			"EASY": NokiaV.EASY
		},
 		"music": preload("res://music/nokia.wav")
	},
	"NIGHTS": {
		"difficulties": {
			"EXPERT": Nights.EXPERT,
			"EXPERT_DOUBLE_BASS": Nights.EXPERT_DOUBLE_BASS,
			"EXPERT_DRUMS": Nights.EXPERT_DRUMS
		},
		"music": preload("res://music/nights.wav")
	},
	"INSTANT_CRUSH": {
		"difficulties": {
			"EXPERT": InstantCrush.EXPERT,
			"EXPERT_DOUBLE_BASS": InstantCrush.EXPERT_DOUBLE_BASS,
		},
		"music": preload("res://music/instant_crush.wav")
	},
	"GEORGEOUS": {
		"difficulties": {
			"EXPERT": Georgeous.EXPERT,
			"EXPERT_DRUMS": Georgeous.EXPERT_DRUMS,
			"HARD": Georgeous.HARD,
			"HARD_DRUMS": Georgeous.HARD_DRUMS
		},
		"music": preload("res://music/georgeous.wav")
	},
	"ONE_MORE_TIME": {
		"difficulties": {
			"EASY": OneMoreTime.EASY,
			"MEDIUM": OneMoreTime.MEDIUM,
			"HARD": OneMoreTime.HARD,
			"EXPERT": OneMoreTime.EXPERT
		},
		"music": preload("res://music/one_more_time.wav")
	},
	"THE_WEEKEND": {
		"difficulties": {
			"EXPERT": TheWeekend.EXPERT
		},
		"music": preload("res://music/the_weekend.wav")	
	},
	# ... (resto de tu level_info) ...
	"TEST": {
		"fk_times": "[
			[[2.5, 5.00], [9, 3]],
			[[2.5, 5.00]],
			[[14, 1]],
			[],
			[],
		]",
		"music": preload("res://music/the_weekend.wav")
	}
}

# --- NUEVAS VARIABLES ---
# Almacenará los datos de las notas de la canción
var parsed_song_data = [] 
# Un contador para cada carril (A, S, J, K, L)
var next_note_index = [0, 0, 0, 0, 0]
# ------------------------

func _ready() -> void:
	current_level_name = Signals.level
	current_level_difficulty = Signals.difficulty
	print(current_level_name)
	print(current_level_difficulty)
	
	$Music.stream = level_info.get(current_level_name).get("music")
	$Music.play()
	#$Music.volume_linear = 0
	
	Signals.audio = $Music
	
	if in_edit_node:
		Signals.KeyListenerPress.connect(KeyListenerPress)
	else:
		# En lugar de crear timers, solo leemos los datos de la canción
		var fk_times_string = level_info.get(current_level_name).get("difficulties").get(current_level_difficulty)
		parsed_song_data = str_to_var(fk_times_string)
		
		# Aseguramos que haya 5 arrays (para A, S, J, K, L), aunque estén vacíos
		while parsed_song_data.size() < 5:
			parsed_song_data.append([])

# _process AHORA SE ENCARGA DE SPAWNEAR NOTAS
func _process(delta: float) -> void:
	# Si estamos en modo edición o la música no está sonando, no hacemos nada
	if in_edit_node or not $Music.is_playing():
		return

	# Obtenemos la posición actual de la música (nuestra "fuente de verdad")
	var current_time = $Music.get_playback_position()

	# Iteramos por cada uno de los 5 carriles (A, S, J, K, L)
	for lane_index in range(parsed_song_data.size()):
		
		# Verificamos si aún quedan notas por lanzar en este carril
		var current_note_list = parsed_song_data[lane_index]
		var note_idx_for_this_lane = next_note_index[lane_index]
		
		if note_idx_for_this_lane < current_note_list.size():
			
			# Obtenemos los datos de la siguiente nota
			var next_note_data = current_note_list[note_idx_for_this_lane]
			var note_spawn_time = next_note_data[0]
			var note_duration = next_note_data[1]
			
			# --- ¡ESTA ES LA LÓGICA CLAVE! ---
			# Comparamos el tiempo de la música con el tiempo de la nota
			if current_time >= note_spawn_time:
				# ¡Es hora de lanzar la nota!
				
				var button_name = get_button_name_from_index(lane_index)
				Signals.CreateFallingKey.emit(button_name, note_duration)
				
				# Avanzamos el índice para que en el próximo frame
				# busquemos la *siguiente* nota de este carril
				next_note_index[lane_index] += 1

# Pequeña función de ayuda para convertir el índice del carril en un nombre
func get_button_name_from_index(index: int) -> String:
	match index:
		0: return "A_KEY"
		1: return "S_KEY"
		2: return "J_KEY"
		3: return "K_KEY"
		4: return "L_KEY"
	return ""


func KeyListenerPress(button_name: String, array_num: int):
	#print(str(array_num) + " " + str($Music.get_playback_position()))
	fk_output_arr[array_num].append($Music.get_playback_position() )

# La función 'spawnFallingKey' con 'await' ya no es necesaria
# func spawnFallingKey(button_name: String, delay: float, duration):
	# ...

func _on_music_finished() -> void:
	print("se acabo??")
	Signals.gameFinished.emit()
