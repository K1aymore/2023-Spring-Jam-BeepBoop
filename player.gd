extends CharacterBody3D


const BASE_SPEED = 7.5
const SPRINT_BOOST = 2
const JUMP_VELOCITY = 5

var mouse_sens_factor := 2.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if position.y < -5:
		position = Vector3(0, 1, 0)
		global_rotation = Vector3.ZERO
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	var speed = BASE_SPEED * (SPRINT_BOOST if Input.is_action_pressed("sprint") else 1)
	
	var input_dir := Input.get_vector("right", "left", "backward", "forward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed/2)
		velocity.z = move_toward(velocity.z, 0, speed/2)
	
	move_and_slide()


func _input(event):
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		turnCamera(event.relative)
	
	elif event is InputEventMouseButton && event.pressed:
		var clickedObject = $Camera3D/RayCast3D.get_collider()
		if clickedObject is Button3D:
			clickedObject.onPress()
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func turnCamera(turn : Vector2):
	var windowSize := DisplayServer.window_get_size()
	rotate_y(-turn.x/windowSize.x * mouse_sens_factor)
	$Camera3D.rotate_x(turn.y/windowSize.y * mouse_sens_factor)
