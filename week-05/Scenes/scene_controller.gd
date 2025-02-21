extends Node

@export var debug_mode = false
@export var debug_start_time = 0
@export var sky_animator: AnimationPlayer
@export var prop_animator: AnimationPlayer


func _ready() -> void:
	var seconds = 0
	var current_time = Time.get_time_dict_from_system()
	if debug_mode:
		seconds = debug_start_time
	else:
		seconds = current_time.second + current_time.minute * 60 + current_time.hour * 3600

	sky_animator.play("sky animation")
	sky_animator.advance(seconds)
	prop_animator.play("prop animation")
	prop_animator.advance(seconds)

	print("seconds is ", seconds, ", which is about ", seconds/3600, " hours")
