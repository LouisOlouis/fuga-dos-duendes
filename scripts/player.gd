extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $Sprite2D


const SPEED = 300.0
const JUMP_VELOCITY = -350.0

var move = false


func _physics_process(delta: float) -> void:
	if move:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	
	
	if direction:
		velocity.x = direction * SPEED
		anim.scale.x = direction * -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	state()
	move_and_slide()

func state():
	if velocity == Vector2.ZERO:
		anim.play("default")
	else:
		anim.play("andando")
	if not is_on_floor():
		anim.play("pulo")
	
