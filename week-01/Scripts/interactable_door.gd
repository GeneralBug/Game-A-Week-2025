extends InteractableObject

@export var own_collider: CollisionShape3D
@export var pivot: Node3D
@onready var audio = $door_audio
var scene_controller
@onready var room_controller = $".."
func _ready() -> void:
	scene_controller = $"../.."
	mesh = $hinge_pivot/Door

func interact(body):
	print("interacted with ", name)
	if !room_controller.doors_locked:
		room_controller.doors_locked = true
		scene_controller.build_room(pivot)
		audio.play()
		disable_collider()
	else:
		audio.stream = AudioStreamWAV.load_from_file("res://Audio/door_locked.wav")
		audio.play()
func disable_collider():
	#code reuse :(
	own_collider.disabled = true
	self.visible = false
