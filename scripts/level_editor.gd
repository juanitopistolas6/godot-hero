extends Node2D

const in_edit_node: bool = false
@export var current_level_name: String


var fk_fall_time: float = 1.9666
var fk_output_arr = [[], [], [], []]

var level_info = {
	"NOKIA": {
		"fk_times": NokiaV.value,
 		"music": preload("res://music/nokia.wav")
	},
	"NIGHTS": {
		"fk_times": Nights.value,
		"music": preload("res://music/nights.wav")
	},
	"TV_OFF": {
		"fk_times": TvOff.value,
		"music": preload("res://music/tv_off.wav")
	},
	"GEORGEOUS": {
		"fk_times": Georgeous.value,
		"music": preload("res://music/georgeous.wav")
	},
	"THE_WEEKEND": {
		"fk_times": TheWeekend.value,
		"music": preload("res://music/the_weekend.wav")
	},
	"INSTANT_CRUSH": {
		"fk_times": InstantCrush.value,
		"music": preload("res://music/instant_crush.wav")
	},
	"ONE_MORE_TIME": {
		"fk_times": OneMoreTime.value,
		"music": preload("res://music/one_more_time.wav")
	},
	"TEST": {
		"fk_times": "[
			[[2.5, 5.00], [9, 3]],
			[[2.5, 5.00]],
			[[14, 1]],
			[],
			[],
		]",
		"music": preload("res://music/the_weekend.wav")
	}
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_level_name = Signals.level
	
	$Music.stream = level_info.get(current_level_name).get("music")
	$Music.play()
	
	Signals.audio = $Music
	
	if in_edit_node:
		Signals.KeyListenerPress.connect(KeyListenerPress)
	else:
		var fk_times = level_info.get(current_level_name).get("fk_times")
		var fk_times_arr = str_to_var(fk_times)
		
		
		var counter: int = 0
		
		for key in fk_times_arr:
			var button_name: String = ""
			
			match counter:
				0:
					button_name = "A_KEY"
				1:
					button_name = "S_KEY"
				2:
					button_name = "J_KEY"
				3:
					button_name = "K_KEY"
				4:
					button_name = "L_KEY"
			for note in key:
				spawnFallingKey(button_name, note[0], note[1])
			
			counter += 1
		
	
func KeyListenerPress(button_name: String, array_num: int):
	#print(str(array_num) + " " + str($Music.get_playback_position()))
	fk_output_arr[array_num].append($Music.get_playback_position() )

	
func spawnFallingKey(button_name: String, delay: float, duration):
	await get_tree().create_timer(delay).timeout
	
	Signals.CreateFallingKey.emit(button_name, duration)
	

func _on_music_finished() -> void:
	pass
