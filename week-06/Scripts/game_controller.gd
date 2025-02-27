extends Node

@export var breadbug_total = 20
@export var breadbug_count = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if breadbug_count >= breadbug_total:
		#TODO: win condition
		print("all breadbugs wrangled!")
