extends CharacterBody2D

const GRID_SIZE: int = 32

var move := false

@export var terrain_path: NodePath
@onready var terrain: TileMap = get_node(terrain_path)

@onready var block_scene = preload("res://tcns/block.tscn")
@onready var anim: AnimatedSprite2D = $Sprite2D

@onready var canvas_die: CanvasLayer = $"../die" 
@onready var color_die: ColorRect = $"../die/ColorRect"

@onready var canvas_win: CanvasLayer = $"../win"
@onready var color_win: ColorRect = $"../win/ColorRect"


@onready var tester: Area2D = $"../tester"
@onready var duende_preso: Area2D = $"../duende_preso"

func _physics_process(_delta: float) -> void:
	if move:
		return

	if Input.get_axis("ui_left", "ui_right") != 0 \
	or Input.get_axis("ui_up", "ui_down") != 0:

		var direction := get_direction()
		if direction == Vector2.ZERO:
			return
		
		var target_pos := position + direction * GRID_SIZE
		tester.position = position + direction * GRID_SIZE
		# TileMap em Godot 4 usa Vector2i
		var cell: Vector2i = terrain.local_to_map(target_pos)

		# layer 0 (ajuste se usar mais layers)
		if terrain.get_cell_source_id(0, cell) != -1:
			if get_parent().has_key and duende_preso.inside:
				win()
				move = true
				return
			print("Célula inválida")
			return

		move = true
		play_walk_animation(direction)
		blocker()
		var tween := create_tween()
		tween.tween_property(
			self,
			"position",
			target_pos,
			0.1
		)
		await tween.finished
		move = false


func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()

func play_walk_animation(dir: Vector2) -> void:
	if dir.x > 0:
		scale.x = -1
		anim.play("lado")
	elif dir.x < 0:
		scale.x = 1
		anim.play("lado")
	elif dir.y > 0:
		anim.play("frente")
	elif dir.y < 0:
		anim.play("costas")

func blocker():
	var block = block_scene.instantiate()
	block.position = position
	get_parent().get_node("blockers").add_child(block)
	

func die():
	canvas_die.visible = true
	var tween = get_tree().create_tween() 
	tween.tween_property(color_die, "color", Color(0.0, 0.0, 0.0, 0.655), 0.5) 
	return

func win():
	canvas_win.visible = true
	var tween = get_tree().create_tween() 
	tween.tween_property(color_win, "color", Color(0.0, 0.0, 0.0, 0.655), 0.5) 
	return

func _on_tester_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "blockers": 
		print("entrou") 
		move = true 
		die() 
	print("entrou")
