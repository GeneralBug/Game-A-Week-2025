extends Interactable

@export var light_source: Light3D
@export var light_model: Node3D

func interact(body):
	print("interacted with ", name)
	
	if light_source.visible:
		light_source.hide()
	else:
		light_source.show()
	
	#todo: change texture on light fixture to indicate illumination
