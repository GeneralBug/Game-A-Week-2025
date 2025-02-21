extends StaticBody3D

@export var lit = false
@export var shader: Material
@export var light: Light3D
@export var energy_strength = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lit:
		shader.set("emission_energy_multiplier", lerp(shader.get("emission_energy_multiplier"), energy_strength/2, delta))
		light.light_energy = lerp(light.light_energy, energy_strength, delta)
	else:
		shader.set("emission_energy_multiplier", lerp(shader.get("emission_energy_multiplier"), 0.0, delta))
		light.light_energy = lerp(light.light_energy, 0.0, delta)
