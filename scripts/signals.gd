extends Node2D

var level: String
var difficulty: String

var audio: AudioStreamPlayer2D

var colors = {
	"A_KEY": "fffdcaff",
	"S_KEY": "ffd3d3ff",
	"J_KEY": "cfceffff",
	"K_KEY": "ffe5ceff",
	"L_KEY": "ceffcfff",
}


var score: String = "0"
var max_combo: String = "0"
var fails: String = "0"

signal IncrementScore(incr: int )

signal IncrementCombo()

signal ResetCombo()

signal CreateFallingKey(button_name: String)

signal KeyListenerPress(button_name: String, array_num: int)

signal setMenuFocused(song: String, artist: String, image: String, difficulty: String)

signal gameFinished()

signal RegisterFail()
