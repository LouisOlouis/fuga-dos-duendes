extends Area2D
@onready var no: CanvasLayer = $"../../no"
@onready var player_g: CharacterBody2D = $"../../PlayerG"
@onready var color_no: ColorRect = $"../../no/ColorRect"
@onready var control_no: VBoxContainer = $"../../no/Control"
@onready var dev_scene: Node2D = $"../.."


func _on_body_entered(body: Node2D) -> void:
	if body.name == "PlayerG":
		for duende in Globals.duendes:
			var ativo = Globals.duendes[duende]
			print(duende, ativo)
			if !ativo:
				no_func()
				return
		print("yes")
		dev_scene.win()

func no_func():
	no.visible = true
	player_g.move = true
	var tween = get_tree().create_tween()
	tween.tween_property(color_no, "color", Color(0.0, 0.0, 0.0, 0.655), 0.5)
	await tween.finished
	control_no.visible = true


func _on_no_sair_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(color_no, "color", Color(0.0, 0.0, 0.0, 0.0), 0.1)
	await tween.finished
	no.visible = false
	player_g.move = false
