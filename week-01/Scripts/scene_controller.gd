extends Node

@export var computer_words: Array[String]
@export var rooms: Array[Node]
@onready var room_prefab = preload("res://Scenes/room.tscn")
@export var room_offset: float
var count = 0
var modify_z = true

const DOOR_POS = [Vector3(0,0,-4),]



func build_room(pivot: Node3D):
	#todo: create a new room with correct position and location, delete room before last, set screen words from list, increment count
	count += 1
	print("making room number ", count, "!")
	var new_room = room_prefab.instantiate()
	var offset_direction = 1.0
	add_child(new_room)
	
	#set transform
	match pivot.position:
		Vector3(0, 0, -8): #left door
			offset_direction = -1.0
		Vector3(0, 0, 8): #right door
			offset_direction = 1.0
	
	print(pivot.position, offset_direction)
	new_room.global_rotation.y = rooms.back().global_rotation.y + (deg_to_rad(90) * offset_direction)
	
	new_room.global_position = pivot.global_position

	#if modify_z:
		#if relative_transform.position.z != 0:
			#specific_offset = relative_transform.position.z/abs(relative_transform.position.z)
		#print("doing z offset, ", specific_offset, " is specific offset, ", relative_transform.global_rotation.y)
		#new_room.global_position.x = round(relative_transform.global_position.x)
		#new_room.global_position.z = relative_transform.global_position.z + (room_offset * specific_offset)
		#new_room.global_rotation.y = (relative_transform.global_rotation.y - (deg_to_rad(90)))
	#else:
		#if relative_transform.position.x != 0:
			#specific_offset = relative_transform.position.x/abs(relative_transform.position.x)
		#print("doing x offset, ", specific_offset, " is specific offset, ", relative_transform.global_rotation.y)
		#new_room.global_position.z = round(relative_transform.global_position.z)
		#new_room.global_position.x = relative_transform.global_position.x + (room_offset * specific_offset)
		#new_room.global_rotation.y = (relative_transform.global_rotation.y - (deg_to_rad(90)))
	#
	modify_z = !modify_z
	print(rooms.back().global_position)
	rooms.append(new_room)
	print(rooms.back().global_position)

	if rooms.size() > 3:
		rooms.front().queue_free()
		rooms.remove_at(0)
	return
