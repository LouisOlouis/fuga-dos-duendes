extends Area2D
@onready var player: CharacterBody2D = $"../PlayerF"
@onready var block_scene = preload("res://tcns/block.tscn")

func move_to(): 
	if player.blocked:
		return
	var block = block_scene.instantiate() 
	block.position = player.position 
	get_parent().get_node("blockers").add_child(block)
	player.move = true  
	var tween = get_tree().create_tween() 
	tween.tween_property(player, "position", position, 0.1) 
	tween.finished.connect(func(): player.move = false ) 
	

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "blockers":
		player.move = true
		position = player.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().process_frame
	if player.move:
		return
	if player.position != position:
		if !player.move:
				move_to()
