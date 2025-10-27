extends CanvasLayer

var isFinished = false
var isUpdated = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	
	Signals.gameFinished.connect(hasFinished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !isFinished: return
	
	if !isUpdated:
		visible = true
		
		%ScoreLabel.text = "PUNTUACION FINAL: " + Signals.score
		%ComboLabel.text = "COMBO MAS LARGO: X" + Signals.max_combo
		%MissedNotesLabel.text = "NOTAS FALLIDAS: " + Signals.fails
		
		isUpdated = true
	
	
func hasFinished():
	isFinished = true


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/select_ menu.tscn")
