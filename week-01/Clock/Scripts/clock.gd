extends Node3D
#based on https://catlikecoding.com/godot/introduction/2-programming-a-clock/
@onready var second_hand = $second_pivot
@onready var minute_hand = $minute_pivot
@onready var hour_hand = $hour_pivot

@onready var audio_tick = $tick
@onready var audio_tock = $tock
var prev_seconds
var tick;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prev_seconds = Time.get_time_dict_from_system().second + Time.get_time_dict_from_system().minute * 60 + Time.get_time_dict_from_system().hour * 3600;

func _process(delta: float) -> void:
	var current_time = Time.get_time_dict_from_system()
	var seconds = current_time.second + current_time.minute * 60 + current_time.hour * 3600
	if(seconds != prev_seconds):
		if tick:
			audio_tick.play()
			tick = false
		else:
			audio_tock.play()
			tick = true
	prev_seconds = seconds
	second_hand.rotation.y = -1 * fmod(seconds, 60.0) * TAU / 60.0
	minute_hand.rotation.y = -1 * fmod(seconds / 60.0, 60.0) * TAU / 60.0
	hour_hand.rotation.y = -1 * fmod(seconds / 3600.0, 12.0) * TAU / 12.0
