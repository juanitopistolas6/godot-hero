extends Control

const SONG_ENTRY = preload("res://scenes/song_entry.tscn")

@onready var song_list_container = $Control/ScrollContainer/VBoxContainer

var song_data = [
	[
		"NOKIA",
		"Drake",
		"res://music_assets/nokia_background.jpg",
		"★☆☆",
		"NOKIA",
		{
			"EASY": "Nokia.EASY",
			"MEDIUM": "Nokia.MEDIUM",
			"HARD": "Nokia.HARD",
			"EXPERT": "Nokia.EXPERT"
		}
	],
	[
		"NIGHTS",
		"Frank Ocean",
		"res://music_assets/nights_album.png",
		"★★☆",
		"NIGHTS",
		{
			"EXPERT": "Nights.EXPERT",
			"EXPERT DOUBLE BASS": "Nights.EXPERT_DOUBLE_BASS",
			"EXPERT DRUMS": "Nights.EXPERT_DRUMS"
		}
	],
	[
		"GEORGEOUS",
		"Kanye West",
		"res://music_assets/georgeous_album.jpeg",
		"★★★",
		"GEORGEOUS",
		{
			"HARD DRUMS": "Georgeous.HARD_DRUMS",
			"EXPERT DRUMS": "Georgeous.EXPERT_DRUMS",
			"HARD": "Georgeous.HARD",
			"EXPERT": "Georgeous.EXPERT",
		}
	],
	[
		"THE WEEKEND",
		"SZA",
		"res://music_assets/the_weekend_album.jpeg",
		"★★★",
		"THE_WEEKEND",
		{
			"EXPERT": "TheWeekend.EXPERT",
		}
	],
	[
		"INSTANT CRUSH",
		"DAFT PUNK",
		"res://music_assets/instant_crush.png",
		"★★★",
		"INSTANT_CRUSH",
		{
			"EXPERT DOUBLE BLASS": "InstantCrush.EXPERT_DOUBLE_BASS",
			"EXPERT": "InstantCrush.EXPERT",
		}
	],
	[
		"ONE MORE TIME",
		"DAFT PUNK",
		"res://music_assets/instant_crush.png",
		"★★★",
		"ONE_MORE_TIME",
		{
			"EASY": "OneMoreTime.EASY",
			"MEDIUM": "OneMoreTime.MEDIUM",
			"HARD": "OneMoreTime.HARD",
			"EXPERT": "OneMoreTime.EXPERT",
		}
	]
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_populate_song_list()

func _populate_song_list():
	for data in song_data:
		var new_entry = SONG_ENTRY.instantiate()
		new_entry.set_song_data(data[0], data[1], data[2], data[3], data[4], data[5])
		
		
		song_list_container.add_child(new_entry)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
