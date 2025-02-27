extends CharacterBody3D
# Based on https://www.youtube.com/watch?v=A3HLeyaBCq4

@export var walk_speed = 3.0
@export var run_speed = 6.0
@export var crouch_speed = 1.5
@export var jump_velocity = 2.0
const SENSITIVITY = 0.003

const BOB_FREQUENCY = 2.0
const BOB_AMPLITUDE = 0.1
var t_bob = 0.0

@onready var head = $Head

@export var headbob = true
@export var debug = true
var speed_modifier = 0
var init_velocity = true

#these are changed only if run/crouch is set to toggle mode
var run_toggle = false
var crouch_toggle = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	# Camera rotation
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * SENSITIVITY)
		head.rotate_x(-event.relative.y * SENSITIVITY)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-85), deg_to_rad(60))
		
	if event.is_action_pressed("fullscreen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)
	
	if event is InputEventKey and Input.is_action_pressed("quit_to_desktop"):
		get_tree().quit()
		
	if Options.run_mode_toggle and Input.is_action_pressed("run"):
		run_toggle = !run_toggle
	if Options.crouch_mode_toggle and Input.is_action_pressed("crouch"):
		crouch_toggle = !crouch_toggle
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity

	#TODO: refactor to make optionally toggleable
	var speed = walk_speed
	if Input.is_action_pressed("crouch") or crouch_toggle:
		speed = crouch_speed
	elif Input.is_action_pressed("run") or run_toggle:
		speed = run_speed

	
	var input_dir: Vector2 = Input.get_vector("left", "right", "forwards", "backwards")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 10.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 10.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 5.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 5.0)
			
	move_and_slide()
