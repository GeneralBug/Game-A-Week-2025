extends Node3D

@onready var message_1 = $Control/wrangle
@onready var message_2 = $Control/stew
@onready var BGM:AudioStreamPlayer3D = $bgm
@export var victory_track: AudioStreamMP3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameController.message_1 = message_1
	GameController.message_2 = message_2
	GameController.BGM = BGM
	GameController.victory_track = victory_track
