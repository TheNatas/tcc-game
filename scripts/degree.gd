extends Area2D

signal player_entered_degree(degree_index: int)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		emit_signal("player_entered_degree", int(String(name)))
