extends RigidBody3D


const SPEED = 6

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var path: Path3D

var nextPoint := 0


func _physics_process(delta):
	# Add the gravity.
	if position.y < -3:
		queue_free()
	
	
	if path == null:
		return
	
	if position.distance_to(path.curve.get_point_position(nextPoint)) < 1.5:
		nextPoint += 1
	
	var dir := (path.curve.get_point_position(nextPoint) - position).normalized()
	
	apply_central_force(dir * SPEED - linear_velocity * 1.5)
