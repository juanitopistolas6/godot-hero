extends Control

const SONG_ENTRY = preload("res://scenes/song_entry.tscn")

@onready var song_list_container = $Control/ScrollContainer/VBoxContainer

var song_data = [
	[
		"NOKIA",
		"Drake",
		"res://music_assets/nokia_background.jpg",
		"★☆☆",
		"NOKIA"
	],
	[
		"NIGHTS",
		"Frank Ocean",
		"res://music_assets/nights_album.png",
		"★★☆",
		"NIGHTS"
	],
	[
		"TV OFF",
		"Kendrick Lamar",
		"res://music_assets/tv_off_album.png",
		"★☆☆",
		"TV_OFF"
	],
	[
		"GEORGEOUS",
		"Kanye West",
		"res://music_assets/georgeous_album.jpeg",
		"★★★",
		"GEORGEOUS"
	],
	[
		"THE WEEKEND",
		"SZA",
		"res://music_assets/the_weekend_album.jpeg",
		"★★★",
		"THE_WEEKEND"
	],
	[
		"INSTANT CRUSH",
		"DAFT PUNK",
		"res://music_assets/instant_crush.png",
		"★★★",
		"INSTANT_CRUSH"
	],
	[
		"ONE MORE TIME",
		"DAFT PUNK",
		"res://music_assets/instant_crush.png",
		"★★★",
		"ONE_MORE_TIME"
	]
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_populate_song_list()

func _populate_song_list():
	for data in song_data:
		var new_entry = SONG_ENTRY.instantiate()
		new_entry.set_song_data(data[0], data[1], data[2], data[3], data[4])
		
		song_list_container.add_child(new_entry)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
