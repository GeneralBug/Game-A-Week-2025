extends InteractableObject

@onready var audio = $"../door_area/door_audio"
func _ready() -> void:
	mesh = $"../Door"
	
func interact(body):
	print("interacted with ", name)
	audio.stream = AudioStreamWAV.load_from_file("res://Audio/door_locked.wav")
	audio.play()
