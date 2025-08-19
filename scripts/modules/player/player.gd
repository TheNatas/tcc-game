extends CharacterBody2D

signal player_degree_changed(new_player_degree: int)

@export var speed := 260.0

var current_degree = Globals.STARTING_DEGREE

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += speed * delta

func _on_degree_player_entered_degree(degree_index: int) -> void:
	current_degree = degree_index
	emit_signal("player_degree_changed", degree_index)
