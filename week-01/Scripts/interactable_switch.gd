extends InteractableObject

@export var light_source: Light3D
@export var light_model: Node3D
@onready var audio = $click

func interact(body):
	print("interacted with ", name)
	audio.play()
	if light_source.visible:
		light_source.hide()
	else:
		light_source.show()
	
	#todo: change texture on light fixture to indicate illumination
