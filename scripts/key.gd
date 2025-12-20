extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "PlayerF":
		visible = false
		get_parent().has_key += 1
