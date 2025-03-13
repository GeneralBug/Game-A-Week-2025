extends Node3D
#based on https://catlikecoding.com/godot/introduction/2-programming-a-clock/
@onready var second_hand = $second_pivot
@onready var minute_hand = $minute_pivot
@onready var hour_hand = $hour_pivot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var current_time = Time.get_time_dict_from_system()
	var seconds = current_time.second + current_time.minute * 60 + current_time.hour * 3600
	second_hand.rotation.y = -1 * fmod(seconds, 60.0) * TAU / 60.0
	minute_hand.rotation.y = -1 * fmod(seconds / 60.0, 60.0) * TAU / 60.0
	hour_hand.rotation.y = -1 * fmod(seconds / 3600.0, 12.0) * TAU / 12.0
