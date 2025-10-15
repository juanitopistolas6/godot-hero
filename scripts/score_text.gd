extends RichTextLabel

var score: int = 0
var combo_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.IncrementScore.connect(IncrementScore)
	Signals.IncrementCombo.connect(IncrementCombo)
	Signals.ResetCombo.connect(ResetCombo)
	
	ResetCombo()
	
func IncrementScore(incr: int):
	score += incr
	%ScoreText.text = "[center]" + str(score) + " pts"

func IncrementCombo():
	combo_count += 1
	%ComboText.text = str(combo_count) + "x combo"
	
func ResetCombo():
	combo_count = 0
	%ComboText.text = ""
