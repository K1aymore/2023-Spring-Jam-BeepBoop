extends StaticBody3D

class_name Button3D

@export var sound := preload("res://beep.wav")

signal pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer3D.stream = sound


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func onPress():
	pressed.emit()
	$AudioStreamPlayer3D.play()
