extends Node3D

@export var player: CharacterBody3D
@export var follow_distance = 10
@export var rotation_speed = 1

#TODO: decouple from player, limit rotation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
