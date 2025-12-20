extends Node2D
@onready var start: CanvasLayer = $start
@onready var color_start: ColorRect = $start/ColorRect
@onready var timer: Timer = $start/Timer

func _ready() -> void:
	Music.stream.loop = true
	start.visible = true
	timer.start(0.5)
	await timer.timeout
	var tween = get_tree().create_tween()
	tween.tween_property(color_start, "color", Color(0.0, 0.0, 0.0, 0.0), 1) 
	await tween.finished
	start.visible = false

func curtinas():
	color_start.color = Color(0.0, 0.0, 0.0, 0.0)
	start.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(color_start, "color", Color(0.0, 0.0, 0.0, 1), 0.5) 
	await tween.finished
	timer.start(0.5)
	await timer.timeout
	return

func win():
	await curtinas()
	var tween2 = get_tree().create_tween()
	tween2.tween_property(Music, "volume_db", -80, 0.5)
	await tween2.finished
	Music.playing = false
	Music.volume_db = 0
	Music.stream.loop = true
	call_deferred("change_level")

func change_level():
	get_tree().change_scene_to_file("res://tcns/ending.tscn")
