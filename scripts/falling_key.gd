extends Sprite2D

@export var fall_speed: float = 5.5

var hasTail: bool = false
var init_y_pos: float = -353
var hasPassed = false
var pass_threshold = 300.0
var duration = 0.00
var key_name = ""

func _init() -> void:
	set_process(false)
	
func _ready() -> void:
	if duration > 0.00:
		$DestroyerTimer.wait_time = duration + 2
		
		$DestroyerTimer.start()
		
		hasTail = true
	else:
		duration = 0.00
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	global_position += Vector2(0, fall_speed)
	
	# FALLING TIME
	# 1.96658799999998s
	if (global_position.y > pass_threshold and not hasPassed):
		hasPassed = true
		
		
func setup(target_x, target_frame, time, name):
	global_position = Vector2(target_x, init_y_pos)
	
	frame = target_frame + 1
	
	duration = time
	
	key_name = name
	
	set_process(true)
	
func calculate_line_height(time_seconds: float):
	var speed_per_second = fall_speed / 0.016
	return speed_per_second * time_seconds

func _on_destroyer_timer_timeout() -> void:
	queue_free()


func _on_draw() -> void:
	if duration <= 0.0: return

	var line_height = calculate_line_height(duration)
	
	var from = to_local(global_position)     
	from.y -= 90    
	var to = to_local(global_position + Vector2(0, -line_height))  # por ejemplo, 1000 px hacia arriba
	
	draw_line(from, to, Signals.colors.get(key_name), 21.0)
