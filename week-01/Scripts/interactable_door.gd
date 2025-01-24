extends Interactable

@export var openable: bool
@export var own_collider: CollisionShape3D
@export var pivot: Node3D
var scene_controller

func _ready() -> void:
	scene_controller = $"../.."

func interact(body):
	print("interacted with ", name)
	if openable:
		scene_controller.build_room(pivot)
		disable_collider()

func disable_collider():
	#code reuse :(
	own_collider.disabled = true
	self.visible = false
