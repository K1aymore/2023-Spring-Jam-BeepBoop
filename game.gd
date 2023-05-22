extends Node3D

var numButtonScene = preload("res://number_button.tscn")

var levels = [
	preload("res://Levels/level_0.tscn")
]
var level: Level
var curLevel := 0

@onready var healthBar = $HUD/HealthContainer/ProgressBar
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	$Menu/LevelSelect.visible = false
	
	for i in levels.size():
		var newButton = numButtonScene.instantiate()
		newButton.number = i
		newButton.onpress.connect(Callable(self, "onLevelSelected"))
		$Menu/LevelSelect/GridContainer.add_child(newButton)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healthBar.value = level.health
	
	if Input.is_action_just_pressed("quit"):
		get_tree().paused = true
		$Menu.visible = true
		$Menu/LevelSelect.visible = false



func load_level(levelNum: int):
	
	get_tree().paused = false
	$Menu.visible = false
	
	if level != null:
		level.queue_free()
	
	curLevel = levelNum
	
	level = levels[curLevel].instantiate()
	
	healthBar.max_value = level.MAX_HEALTH
	
	add_child(level)
	level.lose.connect(Callable(self, "lose"))
	level.win.connect(Callable(self, "win"))


func win():
	get_tree().paused = true
	$HUD/WinMessage.visible = true
	$WinTimer.start()


func lose():
	get_tree().paused = true
	$HUD/LoseMessage.visible = true
	$DeathTimer.start()


func _on_play_pressed():
	$Menu/LevelSelect.visible = true

func onLevelSelected(num: int):
	load_level(num)


func _on_quit_pressed():
	get_tree().quit()


func _on_win_timer_timeout():
	load_level(curLevel + 1)


func _on_death_timer_timeout():
	$Menu.visible = true
	$HUD/LoseMessage.visible = false


