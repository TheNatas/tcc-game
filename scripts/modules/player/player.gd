extends CharacterBody2D

signal player_degree_changed(new_player_degree: int)

@export var speed := 260.0

var current_degree = Globals.STARTING_DEGREE

var overlapping_degrees: Array = []

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += speed * delta
	_update_current_degree()

func _on_degree_player_entered_degree(degree_index: int) -> void:
	if degree_index not in overlapping_degrees:
		overlapping_degrees.append(degree_index)
	_update_current_degree()

func _on_degree_player_exited_degree(degree_index: int) -> void:
	overlapping_degrees.erase(degree_index)
	_update_current_degree()

func _update_current_degree() -> void:
	if overlapping_degrees.is_empty():
		return

	var best_degree := -1
	var max_overlap := 0.0
	var best_degree_rect

	# Get player rect
	var player_shape: CollisionShape2D = get_tree().get_first_node_in_group("player/collision")
	var player_rect: Rect2 = _get_shape_rect(player_shape)

	# Compare with each overlapping degree
	for degree_index in overlapping_degrees:
		var degree = get_tree().get_first_node_in_group("degree" + str(degree_index))
		var degree_shape: CollisionShape2D = get_tree().get_first_node_in_group("degree" + str(degree_index) + "/collision")
		var degree_rect: Rect2 = _get_shape_rect(degree_shape)

		var overlap: Rect2 = player_rect.intersection(degree_rect)
		print("Degree ", degree_index, " overlap: ", overlap.size)
		if overlap.has_area():
			var area: float = overlap.size.x * overlap.size.y
			#if area > max_overlap:
				#max_overlap = area
				#best_degree = degree_index
			if area > max_overlap or (area == max_overlap and degree_rect.position.y < best_degree_rect.position.y):
				max_overlap = area
				best_degree = degree_index
				best_degree_rect = degree_rect

	if best_degree != -1 and best_degree != current_degree:
		current_degree = best_degree
		emit_signal("player_degree_changed", current_degree)

#func _get_shape_rect(cshape: CollisionShape2D) -> Rect2:
	#var extents = cshape.shape.extents if cshape.shape is RectangleShape2D else Vector2.ONE
	#var rect_size = extents * 2.0 * cshape.scale
	#var rect_pos = cshape.global_position - rect_size / 2.0
	#return Rect2(rect_pos, rect_size)

func _get_shape_rect(cshape: CollisionShape2D) -> Rect2:
	if cshape.shape is RectangleShape2D:
		var rect_size = cshape.shape.extents * 2 * cshape.global_scale
		var rect_pos = cshape.global_position - rect_size / 2
		return Rect2(rect_pos, rect_size)
	return Rect2(cshape.global_position, Vector2.ZERO)
