extends CharacterBody3D
# Based on https://www.youtube.com/watch?v=A3HLeyaBCq4

const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003

const DO_HEADBOB = false
const BOB_FREQUENCY = 2.0
const BOB_AMPLITUDE = 0.1
var t_bob = 0.0

const X_SCALE = 320
const Y_SCALE = 240

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var debug_camera = $"DEBUG CAMERA"

var init_velocity = true
var turn_speed = 0;
var throttle = 0;

func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass


func _unhandled_input(event: InputEvent) -> void:
	# Camera rotation
	#if event is InputEventMouse:
		#head.rotate_y(-event.relative.x * SENSITIVITY)
	
	if event is InputEventKey and Input.is_action_pressed("ui_end"):
		get_tree().quit()
	
	if event is InputEventKey and Input.is_action_pressed("debug"):
		if camera.current:
			debug_camera.current = true
		else:
			camera.current = true
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var mouse_pos = get_viewport().get_mouse_position()

	turn_speed = (mouse_pos.x - (X_SCALE))/X_SCALE
	throttle = -1 * (mouse_pos.y - (Y_SCALE))/Y_SCALE
	
	self.rotate_y((SPEED/20) * turn_speed)
	var direction: Vector3 = (self.transform.basis * Vector3(throttle, 0, turn_speed)).normalized()
	print(throttle, ", ", turn_speed)
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	move_and_slide()
	
func _headbob(time) -> Vector3:
	
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQUENCY) * BOB_AMPLITUDE
	#pos.x = cos(time * BOB_FREQUENCY/2) * BOB_AMPLITUDE
	return pos
