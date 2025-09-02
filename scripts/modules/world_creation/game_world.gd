extends Node2D

@onready var map = $map
@onready var player = $player
@onready var collision = $CollisionShape2D
@onready var feedback = $feedback

@onready var levels_data = preload("res://scripts/modules/levels/levels.gd").new()

func _ready():
	resize_map_to_screen()
	render_player()
	#render_feedback()

func resize_map_to_screen():
	var screen_size = get_viewport_rect().size

	# 1. Load and assign the texture
	var map_texture = load(levels_data.levels_textures[Globals.current_level])
	map.texture = map_texture

	# 2. Get texture size
	var texture_size = map_texture.get_size()

	# 3. Compute scale factor that maintains aspect ratio and fills the screen
	var scale = max(
		screen_size.x / texture_size.x,
		screen_size.y / texture_size.y
	)

	# 4. Apply scale uniformly to avoid stretching
	map.scale = Vector2(scale, scale)

	# 5. Optional: center the sprite
	map.position = screen_size / 2

func render_player():
	player.name = "player"
	player.scale = Vector2(0.2, 0.2)

	# --- Sprite2D ---
	var sprite = Sprite2D.new()
	sprite.texture = preload("res://assets/player4.png")
	player.add_child(sprite)

	# --- CollisionShape2D ---
	var collision = CollisionShape2D.new()
	if sprite.texture:
		var tex_size = sprite.texture.get_size()
		var rect_shape = RectangleShape2D.new()
		rect_shape.extents = tex_size / 2.0   # half because extents = half-size
		collision.shape = rect_shape

	collision.add_to_group("player/collision")
	player.add_child(collision)

	# --- TextBalloon (Node2D or Control type) ---
	var text_balloon = Node2D.new() # Or your custom TextBalloon scene
	text_balloon.name = "TextBalloon"
	text_balloon.visible = false  # Initially invisible

	# Add a label to the balloon
	var label = Label.new()
	label.text = "Hello!"
	text_balloon.add_child(label)

	player.add_child(text_balloon)

	# Finally, add the player to the scene
	add_child(player)
	
	var tex_size = sprite.texture.get_size()
	var final_size = tex_size * sprite.scale
	var collision_size = collision.shape.extents * 2
	
	var rect = collision.shape.extents * 2
	draw_rect(Rect2(-collision.shape.extents, rect), Color(1, 0, 0, 0.3), true)
	draw_rect(Rect2(-collision.shape.extents, rect), Color(1, 0, 0), false)
