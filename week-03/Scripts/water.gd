extends MeshInstance3D

@export var time: float = 0.0
var material: ShaderMaterial

func _ready():
	material = mesh.surface_get_material(0)

func _physics_process(delta: float) -> void:
	time += delta
	material.set_shader_parameter("wave_time", time)
