extends Node

@export var sky_animator: AnimationPlayer
@export var prop_animator: AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_time = Time.get_time_dict_from_system()
	var seconds = current_time.second + current_time.minute * 60 + current_time.hour * 3600
	sky_animator.set_autoplay("sky animation")
	#sky_animator.seek(seconds, false, false)
	prop_animator.set_autoplay("prop animation")
	#prop_animator.seek(seconds, false, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
