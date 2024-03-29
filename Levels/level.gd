extends Node3D

class_name Level

var enemyScene = preload("res://enemy.tscn")

@export var enemySpawn: Node3D
@export var path: Path3D

const MAX_HEALTH = 10
var health := MAX_HEALTH

var surviveTime = 60
var levelTime: float

signal lose
signal win

func _process(delta):
	levelTime += delta
	if levelTime >= surviveTime && health > 0:
		win.emit()

func _on_end_body_entered(body):
	if body.is_in_group("enemies"):
		health -= 1
		body.queue_free()
		if health <= 0:
			lose.emit()


func _on_spawn_tick_timeout():
	var enemy = enemyScene.instantiate()
	enemy.position = enemySpawn.position
	enemy.path = path
	add_child(enemy)

