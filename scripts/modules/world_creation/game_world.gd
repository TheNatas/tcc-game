extends Node2D

@onready var map = $map
@onready var player = $player

@onready var levels_data = preload("res://scripts/modules/levels/levels.gd").new()

func _ready():
	resize_map_to_screen()

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

# Example in a scene or script where you want to create the player
func render_player():
	player.name = "player"

	# --- Sprite2D ---
	var sprite = Sprite2D.new()
	sprite.texture = preload("res://assets/icon.svg")
	player.add_child(sprite)

	# --- CollisionShape2D ---
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(16, 16)  # Adjust to match your sprite size
	collision.shape = shape
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

	# Optional: set position
	player.position = Vector2(200, 200)
