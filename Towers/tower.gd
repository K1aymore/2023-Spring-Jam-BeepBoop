extends StaticBody3D

var boulderScene = preload("res://Towers/boulder.tscn")
@onready var boulderStartPos = $Boulder.position

var firstButtonPressed := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_button_pressed():
	firstButtonPressed = true
	$ButtonReset.start()


func _on_button_2_pressed():
	if firstButtonPressed:
		firstButtonPressed = false
		$Catapult/AnimationPlayer.play("Launch")




func _on_button_reset_timeout():
	firstButtonPressed = false


func _on_catapult_animation_finished(anim_name):
	if anim_name == "Launch":
		var boulder = boulderScene.instantiate()
		boulder.position = boulderStartPos
		add_child(boulder)
