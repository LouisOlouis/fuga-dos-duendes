extends Area2D

signal entered(obj)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PlayerG":
		emit_signal("entered", self)
