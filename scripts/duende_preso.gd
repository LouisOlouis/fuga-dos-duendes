extends Area2D

var inside: bool = false


@warning_ignore("unused_parameter")
func _on_d_body_entered(body: Node2D) -> void:
	if body.name == "PlayerF":
		inside = true

@warning_ignore("unused_parameter")
func _on_r_body_entered(body: Node2D) -> void:
	if body.name == "PlayerF":
		inside = true

@warning_ignore("unused_parameter")
func _on_u_body_entered(body: Node2D) -> void:
	if body.name == "PlayerF":
		inside = true

@warning_ignore("unused_parameter")
func _on_l_body_entered(body: Node2D) -> void:
	if body.name == "PlayerF":
		inside = true

@warning_ignore("unused_parameter")
func _on_l_body_exited(body: Node2D) -> void:
	if body.name == "PlayerF":
		inside = false

@warning_ignore("unused_parameter")
func _on_u_body_exited(body: Node2D) -> void:
	if body.name == "PlayerF":
		inside = false


@warning_ignore("unused_parameter")
func _on_r_body_exited(body: Node2D) -> void:
	if body.name == "PlayerF":
		inside = false


@warning_ignore("unused_parameter")
func _on_d_body_exited(body: Node2D) -> void:
	if body.name == "PlayerF":
		inside = false
