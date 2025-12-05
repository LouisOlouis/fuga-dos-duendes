extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $Sprite2D

var step := 32 
var move := false

func move_to(new_pos: Vector2): 
	move = true
	var tween = get_tree().create_tween() 
	tween.tween_property(self, "position", new_pos, 0.1) 
	tween.finished.connect(func():
		move = false
	)
	
func _process(delta: float) -> void:
	if move:
		return
	var target = position 
	var pos = target 
	if Input.is_action_just_pressed("ui_up"): 
		target.y -= step 
		anim.play("costas")
	if Input.is_action_just_pressed("ui_down"): 
		target.y += step 
		anim.play("frente")
	if Input.is_action_just_pressed("ui_left"): 
		target.x -= step 
	if Input.is_action_just_pressed("ui_right"): 
		target.x += step 
	
	if target.x <= 32 or target.y <= 32 or target.x >= 430 or target.y >= 240: 
		target = pos 
	
	if target != position: 
		move_to(target)
