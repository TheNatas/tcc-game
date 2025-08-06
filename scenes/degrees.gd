extends Node2D

@onready var player = get_tree().get_first_node_in_group("player") # make sure player is in group "player"

const TOTAL_DEGREES := 7
const DEGREE_HEIGHT := 60
const DEGREE_GAP := 20
const DEGREE_WIDTH_PERCENT := 0.8

var degree_scene := preload("res://scripts/degree.gd") # The script, not a scene – we’ll create the node manually

func _ready():
	for i in range(TOTAL_DEGREES):
		var degree = Area2D.new()
		degree.name = "degree%d" % i
		degree.position = Vector2(
			(1.0 - DEGREE_WIDTH_PERCENT) * 0.5 * get_viewport_rect().size.x,
			i * (DEGREE_HEIGHT + DEGREE_GAP)
		)
		degree.set_script(degree_scene)
		
		# Connect signals
		degree.connect("body_entered", Callable(degree, "_on_body_entered"))
		degree.connect("player_entered_degree", Callable(player, &"_on_degree_player_entered_degree"))

		# Create ColorRect
		var rect = ColorRect.new()
		rect.color = Color(1, 1, 1, 0.196)
		rect.size = Vector2(get_viewport_rect().size.x * DEGREE_WIDTH_PERCENT, DEGREE_HEIGHT)
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
		degree.add_child(collision)
		
		# Reposition the player accordingly to the degrees
		if i == 0:
			player.position.x = degree.position.x


		add_child(degree)
