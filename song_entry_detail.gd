extends TextureRect

var border_color = Color(0.4, 0.8, 1.0, 0.6) # blanco
var border_width = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stretch_mode = STRETCH_KEEP_ASPECT_CENTERED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw():
	# Dibuja borde alrededor del rectángulo del nodo
	var rect = Rect2(Vector2.ZERO, size)
	draw_rect(rect, border_color, false, border_width)

func _on_draw() -> void:
	var rect = Rect2(Vector2.ZERO, size)
	draw_rect(rect, border_color, false, border_width)
