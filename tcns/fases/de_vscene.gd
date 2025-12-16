extends Node2D
@onready var start: CanvasLayer = $start
@onready var color_start: ColorRect = $start/ColorRect

func _ready() -> void:
	start.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(color_start, "color", Color(0.0, 0.0, 0.0, 0.0), 0.5) 
	await tween.finished
	start.visible = false
