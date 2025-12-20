extends Node2D
@onready var color_rect: ColorRect = $inicio/ColorRect
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var control: VBoxContainer = $Cutscene/Control
@onready var control_2: VBoxContainer = $Cutscene/Control2
@onready var control_3: VBoxContainer = $Cutscene/Control3


func _ready() -> void:
	Music.stream = preload("uid://bnlej8dqmdu2j")
	Music.stream.loop = true
	Music.playing = true
	
	
func curtinas():
	color_rect.color = Color(0.0, 0.0, 0.0, 0.0)
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0.0, 0.0, 0.0, 1), 0.5)
	tween2.tween_property(Music, "volume_db", -80, 0.5)
	await tween.finished
	await tween2.finished
	Music.playing = false
	Music.volume_db = 0
	timer.start(0.1)
	await timer.timeout
	return

func _on_sair_pressed() -> void:
	$inicio/Control.visible = false
	await curtinas()
	animation_player.play("cutscene")
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0.0, 0.0, 0.0, 0), 0.5)
	await animation_player.animation_finished
	tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0.0, 0.0, 0.0, 1), 0.5)
	await tween.finished
	
	control.visible = true
	tween = get_tree().create_tween()
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
	timer.start(4)
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
	
	Music.stream.loop = true
	Music.stream = preload("uid://bwqkn014b5g4x")
	Music.playing = true
	call_deferred("change_level")

func change_level():

	get_tree().change_scene_to_file("res://tcns/fases/DEVscene.tscn")
