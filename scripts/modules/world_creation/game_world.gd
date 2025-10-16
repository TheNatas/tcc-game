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
	var scale_factor = max(
		screen_size.x / texture_size.x,
		screen_size.y / texture_size.y
	)

	# 4. Apply scale uniformly to avoid stretching
	map.scale = Vector2(scale_factor, scale_factor)

	# 5. Optional: center the sprite
	map.position = screen_size / 2

func render_player():
	player.name = "player"
	player.scale = Vector2(0.2, 0.2)

	# --- AnimatedSprite2D ---
	var animated_sprite = AnimatedSprite2D.new()
	
	# Create SpriteFrames resource
	var sprite_frames = SpriteFrames.new()
	sprite_frames.add_animation("idle")
	
	# Add frames to the animation (don't specify index, just add sequentially)
	var frame1 = load("res://assets/player7.png")
	var frame2 = load("res://assets/player8.png")
	var frame3 = load("res://assets/player6.png")
	var frame4 = load("res://assets/player9.png")
	sprite_frames.add_frame("idle", frame1)
	sprite_frames.add_frame("idle", frame2)
	sprite_frames.add_frame("idle", frame3)
	sprite_frames.add_frame("idle", frame4)
	
	# Set animation speed (frames per second)
	sprite_frames.set_animation_speed("idle", 25.0)
	
	# Apply the sprite frames and play the animation
	animated_sprite.sprite_frames = sprite_frames
	animated_sprite.animation = "idle"
	animated_sprite.play()
	
	player.add_child(animated_sprite)

	# --- CollisionShape2D ---
	var collision_shape = CollisionShape2D.new()
	if frame1:
		var tex_size = frame1.get_size()
		var rect_shape = RectangleShape2D.new()
		rect_shape.extents = tex_size / 2.0   # half because extents = half-size
		collision_shape.shape = rect_shape

	collision_shape.add_to_group("player/collision")
	player.add_child(collision_shape)

	# --- TextBalloon (Node2D or Control type) ---
	var text_balloon = Node2D.new() # Or your custom TextBalloon scene
	text_balloon.name = "TextBalloon"
	text_balloon.visible = false  # Initially invisible

	# Add a label to the balloon
	var label = Label.new()
	label.text = "Olá!"
	text_balloon.add_child(label)

	player.add_child(text_balloon)

	# Finally, add the player to the scene
	add_child(player)
	
	# Note: The debug rectangles below won't work correctly as draw_rect needs to be in _draw()
	# Commenting them out for now
	# var sprite_tex_size = animated_sprite.sprite_frames.get_frame_texture("idle", 0).get_size()
	# var _final_size = sprite_tex_size * animated_sprite.scale
	# var _collision_size = collision_shape.shape.extents * 2
	
	# var rect = collision_shape.shape.extents * 2
	# draw_rect(Rect2(-collision_shape.shape.extents, rect), Color(1, 0, 0, 0.3), true)
	# draw_rect(Rect2(-collision_shape.shape.extents, rect), Color(1, 0, 0), false)
