extends Node2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var control_5: VBoxContainer = $CanvasLayer/Control5
@onready var control_4: VBoxContainer = $CanvasLayer/Control4
@onready var control_3: VBoxContainer = $CanvasLayer/Control3
@onready var control_2: VBoxContainer = $CanvasLayer/Control2
@onready var control: VBoxContainer = $CanvasLayer/Control


func _ready() -> void:
	Music.stream = preload("uid://bnlej8dqmdu2j")
	Music.playing = true
	Music.stream.loop = true
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0.0, 0.0, 0.0, 0.0), 1)
	await tween.finished
	timer.start(3)
	await timer.timeout
	tween = get_tree().create_tween()
	tween.tween_property(control_5, "modulate", Color(0.0, 0.0, 0.0, 0.0), 1)
	await tween.finished
	tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0.0, 0.0, 0.0, 1), 1)
	await tween.finished
	timer.start(1)
	await timer.timeout
	animation_player.stop()
	credits()

func credits():
	control.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(control, "modulate", Color(1, 1, 1, 1), 1)
	await tween.finished
	timer.start(2)
	await timer.timeout
	tween = get_tree().create_tween()
	tween.tween_property(control, "modulate", Color(1, 1, 1, 0), 1)
	await tween.finished
	control.visible = false
	
	control_2.visible = true
	tween = get_tree().create_tween()
	tween.tween_property(control_2, "modulate", Color(1, 1, 1, 1), 1)
	await tween.finished
	timer.start(2)
	await timer.timeout
	tween = get_tree().create_tween()
	tween.tween_property(control_2, "modulate", Color(1, 1, 1, 0), 1)
	await tween.finished
	control_2.visible = false
	
	control_3.visible = true
	tween = get_tree().create_tween()
	tween.tween_property(control_3, "modulate", Color(1, 1, 1, 1), 1)
	await tween.finished
	timer.start(2)
	await timer.timeout
	tween = get_tree().create_tween()
	tween.tween_property(control_3, "modulate", Color(1, 1, 1, 0), 1)
	await tween.finished
	control_3.visible = false
	
	control_4.visible = true
	tween = get_tree().create_tween()
	tween.tween_property(control_4, "modulate", Color(1, 1, 1, 1), 1)
