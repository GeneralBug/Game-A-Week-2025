extends Interactable

@export var openable: bool
var scene_controller

func _ready() -> void:
	scene_controller = get_node("../../Scene Controller")

func interact(body):
	print("interacted with ", name)
	if openable:
		scene_controller.new_room()
		return
	else:
		#todo: play locked door sound
		return
