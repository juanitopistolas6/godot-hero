extends Control

# perfect ffbe00
# great e2dd25
# good a7dd25
# ok 8dbfc7
# miss 5a5758


func setTextInfo(text: String):
	$ScoreText.text = "[center]" + text
	
	match text:
		"PERFECT":
			$ScoreText.set("theme_override_colors/default_color", Color("ffbe00"))
		"GREAT":
			$ScoreText.set("theme_override_colors/default_color", Color("e2dd25"))
		"GOOD":
			$ScoreText.set("theme_override_colors/default_color", Color("a7dd25"))
		"OK":
			$ScoreText.set("theme_override_colors/default_color", Color("8dbfc7"))
		"MISS":
			$ScoreText.set("theme_override_colors/default_color", Color("5a5758"))
		_:
			$ScoreText.set("theme_override_colors/default_color", Color("5a5758"))
			
