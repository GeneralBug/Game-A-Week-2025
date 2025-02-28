extends Node

@export var breadbug_total = 20
@export var breadbug_count = 0
var breadbug_old_count = 0
var won = false
@export var message_1: Node
@export var message_2: Node
@export var message_count: RichTextLabel
@export var BGM: AudioStreamPlayer3D
@export var victory_track: AudioStreamMP3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if breadbug_count != breadbug_old_count:
		message_count.text = "[center]{0} left[/center]".format([breadbug_total - breadbug_count])
		breadbug_old_count = breadbug_count
	if breadbug_count >= breadbug_total and !won:
		#TODO: win condition
		won = true
		print("all breadbugs wrangled!")
		message_1.visible = false
		message_2.visible = true
		BGM.stream = victory_track
		BGM.play()
