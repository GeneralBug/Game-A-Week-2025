extends Node

@export var computer_words: Array[String]
@onready var room_prefab = "res://Scenes/room.tscn"
@export var room_offset = 8
var count = 0

func new_room():
	#todo: create a new room with correct position and location, delete room before last, set screen words from list, increment count
	count += 1
	print("making room number ", count, "!")
	return
