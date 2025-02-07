extends RigidBody3D
# Based on https://www.seacreaturegame.com/blog/gerstner-waves-with-buoyancy-godot

@export var speed = 3.0
@export var sensitivity = 0.01
const X_SCALE = 320
const Y_SCALE = 240

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var debug_camera = $"DEBUG CAMERA"

var init_velocity = true
var turn_speed = 0;
var throttle = 0;

# buoyancy stuff
@export var float_force := 3.0
@onready var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var buoyant_object = $"."
@onready var probes = $ProbeContainer.get_children()
@onready var physics_material = PhysicsMaterial.new()

@export var water_plane: MeshInstance3D

var wave_a = Vector3(1.0, 0.4, 10.0)
var wave_a_dir = Vector2(1.0, 0.0)
var wave_b = Vector3(1.0, 0.25, 20.0)
var wave_b_dir = Vector2(1.0, 1.0)
var wave_c = Vector3(1.0, 0.15, 1.0)
var wave_c_dir = Vector2(1.0, 0.5)
var time: float = 0.0
var submerged := false

@export var water_drag := 0.05
@export var water_angular_drag := 0.05

var mouse_pos: Vector2

func _unhandled_input(event: InputEvent) -> void:
	# Camera rotation
	#if event is InputEventMouse:
		#head.rotate_y(-event.relative.x * sensitivity)
	
	if event is InputEventKey and Input.is_action_pressed("ui_end"):
		get_tree().quit()
	
	if event is InputEventKey and Input.is_action_pressed("debug"):
		if camera.current:
			debug_camera.current = true
		else:
			camera.current = true
		
func _physics_process(delta: float) -> void:

	# buoyancy stuff
	time += delta
	submerged = false
	update_wave_parameters() # Ensure parameters are up-to-date
	update_probes()
	for p in probes:
		var water_height = get_height(p.global_position)
		var depth = water_height - p.global_position.y
		if depth > 0 or global_position.y <= -1:
			submerged = true
			print("submerged!")
			apply_buoyancy_force(p, depth)
		elif p.global_position.y >= 10:
			buoyant_object.apply_force(Vector3.UP * depth)
			print("NOT submerged!")
	
	buoyant_object.rotation.x = clampf(buoyant_object.rotation.x, deg_to_rad(-10), deg_to_rad(10))
	buoyant_object.rotation.z = 0
	
func _ready():
	update_wave_parameters()

func update_wave_parameters():
	var water_material = water_plane.mesh.surface_get_material(0)
	wave_a = water_material.get_shader_parameter("wave_a")
	wave_a_dir = water_material.get_shader_parameter("wave_a_dir")
	wave_b = water_material.get_shader_parameter("wave_b")
	wave_b_dir = water_material.get_shader_parameter("wave_b_dir")
	wave_c = water_material.get_shader_parameter("wave_c")
	wave_c_dir = water_material.get_shader_parameter("wave_c_dir")

func get_gerstner_wave_height(wave, wave_dir, position, time):
	var amplitude = wave.x
	var steepness = wave.y
	var wavelength = wave.z

	var k = 2.0 * PI / wavelength
	var c = sqrt(9.8 / k)
	var d = wave_dir.normalized()
	var f = k * (d.dot(Vector2(position.x, position.z)) - (c * time))
	var a = steepness / k

	return amplitude * a * sin(f)

func get_height(position):
	var height = 0.0
	height += get_gerstner_wave_height(wave_a, wave_a_dir, position, time / 2.0)
	height += get_gerstner_wave_height(wave_b, wave_b_dir, position, time / 2.0)
	height += get_gerstner_wave_height(wave_c, wave_c_dir, position, time / 2.0)
	return height

func apply_buoyancy_force(p, depth):
	var buoyancy_force = Vector3.UP * float_force * gravity * depth
	buoyant_object.apply_force(buoyancy_force, p.global_position - buoyant_object.global_transform.origin)

func update_probes():
	for p in probes:
		p.global_transform = p.global_transform


func _integrate_forces(state: PhysicsDirectBodyState3D):
	mouse_pos = get_viewport().get_mouse_position()
	turn_speed = (mouse_pos.x - (X_SCALE))/X_SCALE
	buoyant_object.rotation_degrees += Vector3(0, (turn_speed * sensitivity), 0)
	throttle = -1 * (mouse_pos.y - (Y_SCALE))/Y_SCALE
	if Input.is_action_pressed("interact"):
		var direction: Vector3 = (self.transform.basis * Vector3(throttle, 0, 0)).normalized()
		#print(throttle, ", ", turn_speed)
		buoyant_object.apply_force(direction * speed)

	
	if submerged:
		state.linear_velocity *=  1 - water_drag
		state.angular_velocity *= 1 - water_angular_drag 
