extends Button

var number: int

signal onpress(num: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	onpress.emit(number)
