extends Node3D

@export var own_collider: CollisionShape3D
@onready var audio = $door_area/door_audio
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	disable_collider()
		
func enable_collider():
	#print("beep boop locking door")
	own_collider.disabled = false
	self.visible = true

func disable_collider():
	#print("unlocking door!!!!!!!!!")
	own_collider.disabled = true
	self.visible = false

func _on_door_area_body_entered(body: Node3D) -> void:
	#print("AAAAAA ", body.name, " trying to enter door")
	if body.name == "Player":
		if own_collider.disabled:
			audio.play()
		call_deferred("enable_collider")
