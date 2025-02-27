extends Node3D

@export var radius = 1
@onready var breadbug = $breadbug
@onready var animator = $breadbug/AnimationPlayer
@onready var collider = $breadbug/StaticBody3D/CollisionShape3D
@onready var audio = $AudioStreamPlayer3D
func _ready() -> void:
	animator.play("move1")
	breadbug.position.x += radius


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotate_y(-deg_to_rad(0.35))

func _on_area_3d_body_entered(body: Node3D) -> void:
	#print(body)
	if body.name == "Player":
		audio.play()
		GameController.breadbug_count += 1
		breadbug.queue_free()
