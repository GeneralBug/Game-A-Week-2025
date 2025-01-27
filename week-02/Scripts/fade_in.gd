extends Control

@onready	 var box = $ColorRect
@export var fade_rate = 0.02
var finished = false

func _process(delta: float) -> void:
	if !finished:
		box.set_color(lerp(box.get_color(), Color(0,0,0,0), fade_rate))
		if box.color.a == 0:
			finished = true
