extends RayCast3D

var last_collider: Object = null

func _physics_process(delta: float) -> void:
	if is_colliding():
		var target = get_collider()
		#print(target.name)
		if target is InteractableObject:
			#print(target.mesh)
			target.mesh.material_override = target.highlight_mat
			last_collider = target
			if Input.is_action_just_pressed("interact"):
				target.interact(owner)
	if not is_colliding() and last_collider != null:
		last_collider.mesh.material_override = last_collider.default_mat
		last_collider = null
