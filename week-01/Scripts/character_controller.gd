extends CharacterBody3D
# Based on https://www.youtube.com/watch?v=A3HLeyaBCq4

const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003

const DO_HEADBOB = true
const BOB_FREQUENCY = 2.0
const BOB_AMPLITUDE = 0.1
var t_bob = 0.0

@onready var head = $Head
@onready var camera = $Head/Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	# Camera rotation
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
	
	if event is InputEventKey and Input.is_action_pressed("ui_end"):
		get_tree().quit()
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir: Vector2 = Input.get_vector("left", "right", "forwards", "backwards")
	var direction: Vector3 = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 10.0)
		velocity.z = lerp(velocity.z, direction.z * SPEED, delta * 10.0)

	# Head bob
	if DO_HEADBOB:
		t_bob += delta * velocity.length() * float(is_on_floor())
		camera.transform.origin = _headbob(t_bob)
	
	move_and_slide()
	
func _headbob(time) -> Vector3:
	
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQUENCY) * BOB_AMPLITUDE
	#pos.x = cos(time * BOB_FREQUENCY/2) * BOB_AMPLITUDE
	return pos
