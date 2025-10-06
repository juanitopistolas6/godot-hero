extends Sprite2D
var hasPassed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if global_position.y > 300 and not hasPassed:
		print("Tail time: ", $Timer.wait_time - $Timer.time_left)
		$Timer.stop()
		hasPassed = true
		

func startTailtime():
	print("empezado")


func _on_draw() -> void:
	#var from = to_local(global_position)         # transforma la posición global del sprite a coordenadas locales (será 0,0)
	#var to = to_local(global_position + Vector2(0, -texture.get_height()))  # por ejemplo, 1000 px hacia arriba
	#
	#print("texture_height: ", texture.get_height())
#
	#draw_line(from, to, Color.RED, 21.0)
	pass
