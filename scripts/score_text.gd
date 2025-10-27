extends RichTextLabel

var score: int = 0
var combo_count: int = 0
var max_combo: int = 0
var fails: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.IncrementScore.connect(IncrementScore)
	Signals.IncrementCombo.connect(IncrementCombo)
	Signals.ResetCombo.connect(ResetCombo)
	Signals.RegisterFail.connect(RegisterFail)
	
	ResetCombo()
	UpdateTexts()

func IncrementScore(incr: int):
	score += incr
	Signals.score = str(score)
	UpdateTexts()

func IncrementCombo():
	combo_count += 1
	if combo_count > max_combo:
		max_combo = combo_count
		Signals.max_combo = str(max_combo)
	UpdateTexts()

func ResetCombo():
	combo_count = 0
	UpdateTexts()

func RegisterFail():
	fails += 1
	Signals.fails = str(fails)
	ResetCombo()
	UpdateTexts()

func UpdateTexts():
	%ScoreText.text = "[center]" + str(score) + " pts"
	if combo_count > 0:
		%ComboText.text = str(combo_count) + "x combo"
	else:
		%ComboText.text = ""
	# Puedes mostrar estos datos extra en otros nodos si quieres:
	if has_node("%MaxComboText"):
		%MaxComboText.text = "Máx Combo: " + str(max_combo)
	if has_node("%FailsText"):
		%FailsText.text = "Fallos: " + str(fails)
