extends Area2D

@export var nu = false
@onready var player_f: CharacterBody2D = $"../PlayerF"
@onready var observer: AnimatedSprite2D = $observer
@onready var camera: AnimatedSprite2D = $camera
@onready var timer: Timer = $Timer

var mode = false

func _ready() -> void:
	player_f.connect("walk", Callable(self, "_on_player_walk"))
	if nu == false:
		mode = false
		observer.play("green")
		camera.play("green")


func _on_player_walk():
	var n = get_parent().steps % 2
	var tf = n == 0
	if tf == nu:
		observer.play("green")
		camera.play("green")
		mode = false
	else:
		observer.play("red")
		camera.play("red")
		mode = true
	

func _on_body_entered(body: Node2D) -> void:
	timer.start(0.1)
	await timer.timeout
	if body == player_f:
		get_parent().inside_camera = true
		print("inside")

		if mode:
			player_f.move = true
			player_f.die()

func _on_body_exited(body: Node2D) -> void:
	if body == player_f:
		get_parent().inside_camera = false
		print("outside")
