extends Node

#target amount of money to be aquired in cents
@export var target_value: int
#total value to be spawned in cents
@export var spawn_value: int
#coordinate range in which coins can be spawned
@export var spawn_range: Array[Vector2]
var coin_values = [5, 10, 20, 50, 100, 200]
@onready var coin_prefab = "res://Scenes/coin.tscn"
func _ready() -> void:
	pass # Replace with function body.

func spawn_coins():
	var spawned_value = 0
	var new_coin
	while spawned_value < spawn_value:
		new_coin = coin_prefab.instanciate()
		new_coin.value = coin_values.pick_random()
		spawned_value += new_coin.value
		new_coin.set_texture()

	return
