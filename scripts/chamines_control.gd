extends Node2D
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"
@onready var color_rect: ColorRect = $"../CanvasLayer/ColorRect"
@onready var player_g: CharacterBody2D = $"../PlayerG"
@onready var label: Label = $"../CanvasLayer/Control/Label"
@onready var control: VBoxContainer = $"../CanvasLayer/Control"

var house = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.last_house == "0":
		return

	var marker_name := "M" + str(Globals.last_house)

	if not has_node(marker_name):
		push_error("Marker não existe: " + marker_name)
		return

	player_g.global_position = get_node(marker_name).global_position

func _on__entered(obj: Variant) -> void:
	print(obj.name)
	house = obj.name
	label.text = "Casa " + obj.name
	canvas_layer.visible = true
	player_g.move = true
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0.0, 0.0, 0.0, 0.655), 0.5)
	await tween.finished
	control.visible = true


func _on_entrar_pressed() -> void:
	Globals.last_house = house
	call_deferred("change_level")

func change_level():
	get_tree().change_scene_to_file("res://tcns/fases/" + house + ".tscn")


func _on_sair_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0.0, 0.0, 0.0, 0.0), 0.1)
	await tween.finished
	canvas_layer.visible = false
	player_g.move = false
