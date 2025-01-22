extends RayCast3D

func _physics_process(delta: float) -> void:
	if is_colliding():
		var target = get_collider()
		#print(target.name)
		if target is Interactable and Input.is_action_just_pressed("interact"):
			target.interact(owner)
			
	
