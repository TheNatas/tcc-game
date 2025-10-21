extends CharacterBody2D

signal player_degree_changed(new_player_degree: int)

@export var speed := 260.0

var current_degree = Globals.STARTING_DEGREE

var overlapping_degrees: Array = []

# For fixed movement
var is_moving_fixed := false
var target_y := 0.0
var fixed_movement_speed := 800.0

# Constants from degrees.gd
const TOTAL_DEGREES := 7
const DEGREE_HEIGHT := 60
const DEGREE_GAP := 20

func _ready() -> void:
	# In fixed movement mode, ensure player starts at the correct visual position
	if Globals.movement_style == "fixed":
		var viewport_size = get_viewport_rect().size
		var total_height = TOTAL_DEGREES * DEGREE_HEIGHT + (TOTAL_DEGREES - 1) * DEGREE_GAP
		var start_y = (viewport_size.y + total_height) / 2 - DEGREE_HEIGHT
		var target_degree_y = start_y - current_degree * (DEGREE_HEIGHT + DEGREE_GAP) + DEGREE_HEIGHT / 2
		position.y = target_degree_y
		print("_ready: Initialized player at degree ", current_degree, " with Y position: ", position.y)

func _process(delta: float) -> void:
	if Globals.movement_style == "free":
		_process_free_movement(delta)
		_update_current_degree()
	else: # fixed
		_process_fixed_movement(delta)
		# Never call _update_current_degree in fixed mode from _process
		# The degree is updated immediately when movement starts

func _process_free_movement(delta: float) -> void:
	if Input.is_action_pressed("move_up"):
		position.y -= speed * delta
	elif Input.is_action_pressed("move_down"):
		position.y += speed * delta

func _process_fixed_movement(delta: float) -> void:
	# If already moving, continue to target
	if is_moving_fixed:
		var distance = target_y - position.y
		
		# Check if we're close enough to stop
		if abs(distance) < 2.0:
			position.y = target_y
			is_moving_fixed = false
			print("Movement finished at degree: ", current_degree)
		else:
			# Calculate the movement amount for this frame
			var movement_this_frame = fixed_movement_speed * delta
			
			# Don't overshoot - if we would pass the target, just go to the target
			if abs(distance) <= movement_this_frame:
				position.y = target_y
				is_moving_fixed = false
				print("Movement finished at degree: ", current_degree)
			else:
				# Move toward target
				var direction = sign(distance)
				position.y += direction * movement_this_frame
		return
	
	# Check for input to start new movement
	if Input.is_action_just_pressed("move_up"):
		print("Move up pressed, current_degree: ", current_degree)
		_move_to_degree_fixed(current_degree + 1)
	elif Input.is_action_just_pressed("move_down"):
		print("Move down pressed, current_degree: ", current_degree)
		_move_to_degree_fixed(current_degree - 1)

func _move_to_degree_fixed(target_degree: int) -> void:
	print("entered _move_to_degree_fixed with target: ", target_degree, ", current: ", current_degree)
	# Clamp to valid degree range (0-6)
	target_degree = clamp(target_degree, 0, TOTAL_DEGREES - 1)
	
	if target_degree == current_degree:
		print("Target equals current, returning")
		return
	
	# Update current_degree immediately to the target
	current_degree = target_degree
	print("Updated current_degree to: ", current_degree)
	emit_signal("player_degree_changed", current_degree)
	
	# Calculate target Y position based on degree
	var viewport_size = get_viewport_rect().size
	var total_height = TOTAL_DEGREES * DEGREE_HEIGHT + (TOTAL_DEGREES - 1) * DEGREE_GAP
	var start_y = (viewport_size.y + total_height) / 2 - DEGREE_HEIGHT
	
	# Calculate center Y of the target degree
	target_y = start_y - target_degree * (DEGREE_HEIGHT + DEGREE_GAP) + DEGREE_HEIGHT / 2
	is_moving_fixed = true
	print("Starting movement to Y: ", target_y, ", current Y: ", position.y)

func _on_degree_player_entered_degree(degree_index: int) -> void:
	if degree_index not in overlapping_degrees:
		overlapping_degrees.append(degree_index)
	# Only update degree in free movement mode
	if Globals.movement_style == "free":
		_update_current_degree()

func _on_degree_player_exited_degree(degree_index: int) -> void:
	overlapping_degrees.erase(degree_index)
	# Only update degree in free movement mode
	if Globals.movement_style == "free":
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
		print("_update_current_degree changing from ", current_degree, " to ", best_degree, ", is_moving_fixed: ", is_moving_fixed)
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
