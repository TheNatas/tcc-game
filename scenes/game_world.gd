extends Node2D

@onready var map = $map
@onready var player = $player

@onready var levels_data = preload("res://scripts/levels.gd").new()

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
