extends StaticBody3D

class_name Button3D

enum Sound {
	BEEP,
	BOOP
}

@export var sound: Sound

signal pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	match sound:
		Sound.BEEP:
			$AudioStreamPlayer3D.stream = load("res://beep.wav")
		Sound.BOOP:
			$AudioStreamPlayer3D.stream = load("res://boop.wav")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func onPress():
	pressed.emit()
	$AudioStreamPlayer3D.play()
