extends CharacterBody2D

signal player_degree_changed(new_player_degree: int)

@export var speed := 260.0

var current_degree = Globals.STARTING_DEGREE

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += speed * delta

var overlapping_degrees: Array = []

func _on_degree_player_entered_degree(degree_index: int) -> void:
	if degree_index not in overlapping_degrees:
		overlapping_degrees.append(degree_index)
	_update_current_degree()

func _on_degree_player_exited_degree(degree_index: int) -> void:
	overlapping_degrees.erase(degree_index)
	_update_current_degree()

func _update_current_degree() -> void:
	if overlapping_degrees.is_empty():
		current_degree = -1
		return
	
	var player_pos = global_position
	var best_degree = overlapping_degrees[0]
	var min_distance = INF
	
	for degree_index in overlapping_degrees:
		var degree_node = get_tree().get_first_node_in_group("degree" + str(degree_index))
		var degree_center = degree_node.global_position
		print(degree_index)
		print(degree_center)
		var distance = player_pos.distance_to(degree_center)
		print(distance)
		if distance < min_distance:
			min_distance = distance
			best_degree = degree_index

	current_degree = best_degree
	emit_signal("player_degree_changed", current_degree)
