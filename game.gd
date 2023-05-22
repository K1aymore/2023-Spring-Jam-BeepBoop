extends Node3D

var numButtonScene = preload("res://number_button.tscn")

var levels = [
	preload("res://Levels/level_0.tscn"),
	preload("res://Levels/level_1.tscn"),
	preload("res://Levels/level_2.tscn"),
	preload("res://Levels/level_3.tscn"),
	preload("res://Levels/level_4.tscn"),
	preload("res://Levels/level_5.tscn"),
]
var level: Level
var curLevel := 0

@onready var healthBar = $HUD/HealthContainer/ProgressBar
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	$Menu/LevelSelect.visible = false
	$Menu.visible = true
	
	for i in levels.size():
		var newButton = numButtonScene.instantiate()
		newButton.number = i
		newButton.onpress.connect(Callable(self, "onLevelSelected"))
		$Menu/LevelSelect/GridContainer.add_child(newButton)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healthBar.value = level.health
	var timeLeft = roundi(level.surviveTime - level.levelTime)
	$HUD/SurviveTime.text = "Survive: " + str(timeLeft) + " seconds"
	
	if Input.is_action_just_pressed("quit"):
		get_tree().paused = true
		$Menu.visible = true
		$Menu/LevelSelect.visible = false



func load_level(levelNum: int):
	$Player.position = Vector3(0, 1, 0)
	$Player.rotation = Vector3.ZERO
	
	get_tree().paused = false
	$Menu.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if is_instance_valid(level):
		level.queue_free()
	
	curLevel = levelNum
	
	if curLevel >= levels.size():
		curLevel = 0
		loadMenu()
		return
	
	level = levels[curLevel].instantiate()
	
	healthBar.max_value = level.MAX_HEALTH
	
	add_child(level)
	level.lose.connect(Callable(self, "lose"))
	level.win.connect(Callable(self, "win"))


func loadMenu():
	if is_instance_valid(level):
		level.queue_free()
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	get_tree().paused = true
	$Menu.visible = true
	$Menu/LevelSelect.visible = false
	$HUD/LoseMessage.visible = false
	$HUD/WinMessage.visible = false
	$DeathTimer.stop()
	$WinTimer.stop()


func win():
	get_tree().paused = true
	$HUD/WinMessage.visible = true
	$WinTimer.start()


func lose():
	healthBar.value = 0
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
	loadMenu()


func _on_death_timer_timeout():
	loadMenu()




func _on_sens_value_changed(value):
	$Player.mouse_sens_factor = value
	$Menu/SensNum.text = str(value)
