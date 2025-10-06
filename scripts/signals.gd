extends Node2D

var level: String

var colors = {
	"A_KEY": "fffdcaff",
	"S_KEY": "ffd3d3ff",
	"D_KEY": "cfceffff",
	"F_KEY": "ffe5ceff",
	"G_KEY": "ceffcfff",
	
}

signal IncrementScore(incr: int )

signal IncrementCombo()

signal ResetCombo()

signal CreateFallingKey(button_name: String)

signal KeyListenerPress(button_name: String, array_num: int)

signal setMenuFocused(song: String, artist: String, image: String, difficulty: String)
