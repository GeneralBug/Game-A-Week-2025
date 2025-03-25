extends CollisionObject3D
class_name InteractableObject

@export var mesh: MeshInstance3D
@export var highlight_mat: Material
@export var default_mat: Material
func interact(body):
	print("interacted with ", name)
