extends Sprite2D

@onready var falling_key = preload("res://scenes/falling_key.tscn")
@onready var score_text = preload("res://scenes/score_press_text.tscn")
@export var key_name: String = ""

var falling_key_queue = [ ]
var timer_in_use: bool = false
var note_checked: bool = false
var is_flame_playing: bool = false
var pressed_this_frame := false

var perfect_press_threshold: float = 30
var great_press_threshold: float = 50
var good_press_threshold: float = 60
var ok_press_threshold: float = 80

var perfect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20

func _ready() -> void:
	$GlowOverlay.frame = frame + 5
	$AnimationPlayer.play("key_hit")
	Signals.CreateFallingKey.connect(CreateFallingKey)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if falling_key_queue.size() > 0:
		if falling_key_queue.front().hasPassed:
			if falling_key_queue.front().hasTail and !timer_in_use:
				$TailTimer.wait_time = falling_key_queue.front().duration
				$TailTimer.start()
				timer_in_use = true
			else:
				falling_key_queue.pop_front()
				
				if !note_checked:
					var st_inst = score_text.instantiate()
					
					setFeedBackText("MISS")
					
					Signals.ResetCombo.emit()
					
				note_checked = false
			
			
		if Input.is_action_just_pressed(key_name) and falling_key_queue.size() > 0:
			var key_to_pop = falling_key_queue[0]
			
			var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
			
			$AnimationPlayer.stop()
			$AnimationPlayer.play("key_hit")
			$AnimatedSprite2D.play("fire")
			var press_score_text: String = ""
			
			if distance_from_pass < perfect_press_threshold:
				Signals.IncrementScore.emit(perfect_press_score)
				Signals.IncrementCombo.emit()
				press_score_text = "PERFECT"
			elif distance_from_pass < great_press_threshold:
				Signals.IncrementScore.emit(great_press_score)
				Signals.IncrementCombo.emit()
				press_score_text = "GREAT"
			elif distance_from_pass < good_press_threshold:
				Signals.IncrementScore.emit(good_press_score)
				Signals.IncrementCombo.emit()
				press_score_text = "GOOD"
			elif distance_from_pass < ok_press_threshold:
				Signals.IncrementScore.emit(ok_press_score)
				Signals.IncrementCombo.emit()
				press_score_text = "OK"
			else:
				press_score_text = "MISS"
				Signals.ResetCombo.emit()
			
			#print(distance_from_pass)
			note_checked = true
			
			setFeedBackText(press_score_text)

func CreateFallingKey(button_name: String, duration: float):
	if button_name == key_name:
		var key_inst = falling_key.instantiate()
		get_tree().get_root().call_deferred("add_child", key_inst)
		key_inst.setup(position.x, frame + 4, duration, key_name)
		
		
		falling_key_queue.push_back(key_inst)

func setFeedBackText(text: String):
	var st_inst = score_text.instantiate()
	
	get_tree().get_root().call_deferred("add_child", st_inst)
	st_inst.setTextInfo(text)
	st_inst.global_position = global_position

func _input(event):
	if timer_in_use:	
		if event is InputEventKey:
			if event.as_text() == key_name.substr(0, 1):
				if event.pressed:
					print(event.as_text())
					
					#print("timer_in_use: " + str(timer_in_use) + " de: " + str(key_name))
					if !is_flame_playing:
						$AnimatedSprite2D.frame = 0
						$AnimatedSprite2D.visible = true
						$AnimatedSprite2D.play("fire")
						is_flame_playing = true
				else:
					#print("Tecla " + str(key_name.substr(0, 1)) + ": time left " + str($TailTimer.time_left) )
					
					setFeedBackText(get_score_timing($TailTimer.wait_time, $TailTimer.time_left))
					
					if is_flame_playing:
						$AnimatedSprite2D.visible = false
						$AnimatedSprite2D.stop()	
						is_flame_playing = false
					
					$TailTimer.stop()
					timer_in_use = false


func _on_tail_timer_timeout() -> void:
	setFeedBackText("TOO LATE")
	
	if is_flame_playing:
		$AnimatedSprite2D.visible = false
		$AnimatedSprite2D.stop()
		is_flame_playing = false
	
	Signals.ResetCombo.emit()
	
	timer_in_use = false

func get_score_timing(duration: float, time_left: float) -> String:
	var error = duration - time_left
	var percentage_error = (error / duration) * 100.0  # opcional: error relativo
	
	if percentage_error >= 97.0:
		Signals.IncrementScore.emit(perfect_press_score)
		return "PERFECT"
	elif percentage_error >= 92.0: 
		Signals.IncrementScore.emit(great_press_score)
		return "GREAT"
	elif percentage_error >= 85.0:  
		Signals.IncrementScore.emit(good_press_score)
		return "GOOD"
	elif percentage_error >= 75.0:
		Signals.IncrementScore.emit(ok_press_score)
		return "OK"
	else:
		Signals.ResetCombo.emit()
		return "MISS"
