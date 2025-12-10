extends CharacterBody2D 
@onready var anim: AnimatedSprite2D = $Sprite2D 
@onready var block_scene = preload("res://tcns/block.tscn") 
@onready var tester: Area2D = $"../tester"
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"
@onready var color_rect: ColorRect = $"../CanvasLayer/ColorRect"


var step := 32 
var move := false 
var blocked := false

func move_to(new_pos: Vector2): 
	move = true 
	var block = block_scene.instantiate() 
	block.position = position 
	get_parent().get_node("blockers").add_child(block) 
	var tween = get_tree().create_tween() 
	tween.tween_property(self, "position", new_pos, 0.1) 
	tween.finished.connect(func(): move = false ) 
	

@warning_ignore("unused_parameter")
func _process(delta: float) -> void: 
	if move: 
		return
	
	var target = position 
	var pos = target 
	tester.position = position
	
	if Input.is_action_just_pressed("ui_up"):
		if !move:
			move = true
			target.y -= step 
			tester.position.y -= step
			anim.play("costas")
	
	if Input.is_action_just_pressed("ui_down"): 
		if !move:
			move = true
			target.y += step 
			tester.position.y += step
			anim.play("frente") 
	
	if Input.is_action_just_pressed("ui_left"): 
		if !move:
			move = true
			target.x -= step 
			tester.position.x -= step
			anim.play("lado")
			anim.scale.x = 1
	
	if Input.is_action_just_pressed("ui_right"): 
		if !move:
			move = true
			target.x += step 
			tester.position.x += step
			anim.play("lado")
			anim.scale.x = -1
	
	if target.x <= 32 or target.y <= 32 or target.x >= 430 or target.y >= 240: 
		target = pos 
		tester.position = pos
		move = false
	
	if blocked:
		target = pos
		tester.position = pos 
	
	if target != position: 
		move_to(target) 
	
	

func _on_tester_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "blockers":
		print("entrou")
		blocked = true
		move = true
		die()

func die():
	canvas_layer.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0.0, 0.0, 0.0, 0.655), 0.5) 
	return
