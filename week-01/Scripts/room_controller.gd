extends Node3D

@export var doors_locked = false

func update_text(new_text):
	print("the ROOM is going to get this cool text: ", new_text)
	$"Desk/desk_2/pc_monitor_1/pc_label".text = new_text
