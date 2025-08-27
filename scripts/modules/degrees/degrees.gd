extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

const TOTAL_DEGREES := 7
const DEGREE_HEIGHT := 60
const DEGREE_GAP := 20
const DEGREE_WIDTH_PERCENT := 0.8

var degree_script := preload("res://scripts/modules/degrees/degree.gd")

func _ready():
	var viewport_size = get_viewport_rect().size
	
	# Calculate total height of all degrees including gaps
	var total_height = TOTAL_DEGREES * DEGREE_HEIGHT + (TOTAL_DEGREES - 1) * DEGREE_GAP
	# Starting Y so that everything is vertically centered
	var start_y = (viewport_size.y + total_height) / 2

	for i in range(TOTAL_DEGREES):
		var degree = Area2D.new()
		degree.name = "degree%d" % i
		degree.position = Vector2(
			(1.0 - DEGREE_WIDTH_PERCENT) * 0.5 * viewport_size.x,
			start_y - i * (DEGREE_HEIGHT + DEGREE_GAP)
		)
		degree.set_script(degree_script)
		degree.add_to_group(degree.name)
		
		# Connect signals
		degree.connect("body_entered", Callable(degree, "_on_body_entered"))
		degree.connect("player_entered_degree", Callable(player, &"_on_degree_player_entered_degree"))
		degree.connect("body_exited", Callable(degree, "_on_body_exited"))
		degree.connect("player_exited_degree", Callable(player, &"_on_degree_player_exited_degree"))

		# Create ColorRect
		var rect = ColorRect.new()
		#rect.color = Color(0, 0, 1, 0.196) if Globals.current_level == 0 else Color(1, 0, 1, 0.196) if Globals.current_level == 1 else Color(1, 0, 0, 0.196)
		rect.color = Color(0, 0, 0, 0.196)
		rect.size = Vector2(viewport_size.x * DEGREE_WIDTH_PERCENT, DEGREE_HEIGHT)
		rect.anchor_right = 0
		rect.anchor_bottom = 0
		rect.add_to_group(degree.name + '/ColorRect')
		degree.add_child(rect)

		# Create Label
		var label = Label.new()
		label.text = str(i + 1)
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		label.position = Vector2(10, DEGREE_HEIGHT / 4) # tweak as needed
		rect.add_child(label)

		# Create CollisionShape2D
		var collision = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		shape.size = rect.size
		collision.shape = shape
		collision.position = rect.size / 2
		collision.add_to_group(degree.name + '/collision')
		degree.add_child(collision)
		
		# Position player on main degree
		if i == 0:
			player.position = Vector2(200, degree.position.y)

		add_child(degree)
