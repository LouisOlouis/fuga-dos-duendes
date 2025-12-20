extends Node2D
@onready var color_rect: ColorRect = $start/ColorRect
@onready var canvas_layer_2: CanvasLayer = $start

var has_key = 0

var steps = 0

var inside_camera = false

func _ready() -> void:
	Music.stream.loop = true
	canvas_layer_2.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0.0, 0.0, 0.0, 0.0), 0.5) 
	await tween.finished
	canvas_layer_2.visible = false
func _on_button_pressed() -> void:
	var cur = get_tree().current_scene
	var path = cur.scene_file_path
	
	if path != "":
		get_tree().change_scene_to_file(path)
	else:
		get_tree().reload_current_scene()

func _on_button_2_pressed() -> void:
	call_deferred("change_level")

func change_level():
	get_tree().change_scene_to_file("res://tcns/fases/DEVscene.tscn")

func _on_win_pressed() -> void:
	print(self.name)
	Globals.duendes[self.name] = true
	call_deferred("change_level")
