extends StaticBody3D

var boulderScene = preload("res://Towers/boulder.tscn")
var boulderStartPos = Vector3(0, 4.2, 5.4)


var boulder: RigidBody3D = null



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_button_pressed():
	if !is_instance_valid(boulder):
		var newBoulder = boulderScene.instantiate()
		newBoulder.position = boulderStartPos
		boulder = newBoulder
		add_child(newBoulder)


func _on_button_2_pressed():
	$Catapult/AnimationPlayer.play("Launch")




func boulder_boost():
	if boulder != null:
		boulder.apply_central_impulse(boulder.linear_velocity * 40)
		boulder = null
