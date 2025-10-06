extends Node

# -----------------------
# Variables principales
# -----------------------
var resolution: int = 192
var current_tick: float = 0.0
var current_bpm: float = 120.0
var bpm_index: int = 0

var bpms: Array = []   # [{ "tick": int, "bpm": float }]
var notes: Array = []  # [{ "tick": int, "fret": int, "length": int }]

var next_note_index: int = 0

@onready var music = $Music

# -----------------------
# Inicialización
# -----------------------
func _ready():
	var chart = load_chart("res://charts/nokia.chart")
	resolution = chart["resolution"]
	bpms = chart["bpms"]
	notes = chart["notes"]

	current_bpm = bpms[0]["bpm"]
	music.stream = preload("res://music/nokia.wav")
	music.play()

# -----------------------
# Lógica principal
# -----------------------
func _process(delta: float) -> void:
	update_bpm()
	advance_ticks(delta)
	check_notes()

func update_bpm():
	if bpm_index + 1 < bpms.size() and current_tick >= bpms[bpm_index + 1]["tick"]:
		bpm_index += 1
		current_bpm = bpms[bpm_index]["bpm"]

func advance_ticks(delta: float):
	var tps = (current_bpm / 60.0) * resolution
	current_tick += delta * tps

func check_notes():
	while next_note_index < notes.size() and current_tick >= notes[next_note_index]["tick"]:
		var note = notes[next_note_index]
		spawn_note(note)
		next_note_index += 1

# -----------------------
# Spawnear notas
# -----------------------
func spawn_note(note: Dictionary):
	# ejemplo dentro de spawn_note(note)
	var fret = int(note.get("fret", -1))
	var button_name: String = ""

	match fret:
		0:
			button_name = "A_KEY"
		1:
			button_name = "S_KEY"
		2:
			button_name = "D_KEY"
		3:
			button_name = "F_KEY"
		_:
			button_name = "UNKNOWN"

	var sustain_ticks = note["length"]

	if sustain_ticks > 0:
		# Calcular duración en segundos para el gráfico
		var duration = ticks_to_seconds(sustain_ticks, current_bpm, resolution)
		Signals.CreateFallingSustain.emit(button_name, duration)
	else:
		Signals.CreateFallingKey.emit(button_name)

# -----------------------
# Conversión ticks → segundos
# -----------------------
func ticks_to_seconds(ticks: int, bpm: float, resolution: int) -> float:
	# duración de un tick en segundos = (60 / BPM) / resolution
	var seconds_per_tick = (60.0 / bpm) / resolution
	return ticks * seconds_per_tick

# -----------------------
# Cargar el .chart
# -----------------------
func load_chart(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	var chart_data := {
		"resolution": 192,
		"bpms": [],
		"notes": []
	}

	var section := ""
	while not file.eof_reached():
		var line := file.get_line().strip_edges()
		if line.begins_with("["):
			section = line
			continue

		if section == "[Song]":
			if line.begins_with("Resolution"):
				chart_data["resolution"] = int(line.split("=")[1].strip_edges())

		elif section == "[SyncTrack]":
			if "=" in line and "B" in line:
				var parts = line.split("=")
				var tick = int(parts[0].strip_edges())
				var bpm = float(parts[1].split("B")[1].strip_edges()) / 1000.0
				chart_data["bpms"].append({"tick": tick, "bpm": bpm})

		elif section == "[ExpertSingle]":
			if "=" in line and "N" in line:
				var parts = line.split("=")
				var tick = int(parts[0].strip_edges())
				var note_parts = parts[1].split(" ")
				var fret = int(note_parts[1])
				var length = int(note_parts[2]) if note_parts.size() > 2 else 0
				chart_data["notes"].append({"tick": tick, "fret": fret, "length": length})

	file.close()
	return chart_data
