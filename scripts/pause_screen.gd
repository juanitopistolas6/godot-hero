extends CanvasLayer

@onready var timer = $Timer
@onready var timer_label = $Label
@onready var panel_container = $PanelContainer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.is_stopped() == false:
		# Redondear hacia abajo el tiempo restante
		var tiempo_restante = int(floor(timer.time_left))
		timer_label.text = str(tiempo_restante)
		
	if Input.is_action_just_pressed("pause"):
		if !visible: toggle_pause()


func toggle_pause():
	print("toggle")
	var is_paused = get_tree().is_paused()
	get_tree().set_pause(!is_paused)
	
	panel_container.visible = !is_paused
	visible = !is_paused

func _on_seguir_jugando_pressed() -> void:
	timer.start()
	panel_container.visible = false
	timer_label.visible = true


func _on_volver_al_menu_pressed() -> void:
	toggle_pause()
	get_tree().change_scene_to_file("res://scenes/select_ menu.tscn")


func _on_timer_timeout() -> void:
	timer_label.visible = false
	visible = false
	toggle_pause()
