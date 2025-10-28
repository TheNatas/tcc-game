extends Control

var current_line = 0

# UI elements
var label : Label
var button : Button
var miniature_texture_rect : TextureRect  # For character portrait

# Audio player for voice-over
var audio_player : AudioStreamPlayer

var dialog_lines : Array[DialogLine] = Levels.levels[Globals.current_level]

func _ready():
	create_ui_elements()
	button.pressed.connect(_on_button_pressed)
	
	# Create audio player for voice-over
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	
	# Play voice-over for the first line if available
	play_voice_over(dialog_lines[current_line])
	
func _input(event):
	if event.is_action_pressed("confirm"): # "ui_accept" is Enter/Space by default
		_on_button_pressed()

func _on_button_pressed():
	# Stop any currently playing voice-over
	if audio_player.playing:
		audio_player.stop()
	
	current_line += 1
	
	if current_line < dialog_lines.size():
		var line_obj = dialog_lines[current_line]
		label.text = line_obj.speaker + ": " + line_obj.line if !line_obj.speaker.is_empty() else line_obj.line
		# Update miniature image
		update_miniature(line_obj)
		# Play voice-over if available
		play_voice_over(line_obj)
	else:
		# Check if this is the first level and tutorial hasn't been shown yet
		if Globals.current_level == 0 and not Globals.tutorial_shown:
			Globals.tutorial_shown = true
			get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
		else:
			# Show pre-scale dialog before scale preview for all levels
			get_tree().change_scene_to_file("res://scenes/pre_scale_dialog.tscn")

func update_miniature(line_obj: DialogLine):
	if line_obj.has_miniature():
		var texture = load(line_obj.miniature_image_path)
		if texture:
			miniature_texture_rect.texture = texture
			miniature_texture_rect.visible = true
	else:
		miniature_texture_rect.visible = false

func play_voice_over(line_obj: DialogLine):
	if line_obj.has_voice_over():
		var audio_stream = load(line_obj.voice_over_path)
		if audio_stream:
			audio_player.stream = audio_stream
			audio_player.play()

func create_ui_elements():
	# Set up the root Control node to fill the screen
	anchor_left = 0.0
	anchor_top = 0.0
	anchor_right = 1.0
	anchor_bottom = 1.0
	offset_left = 0
	offset_top = 0
	offset_right = 0
	offset_bottom = 0

	# === 1. Black Background ===
	var bg = ColorRect.new()
	bg.color = Color.BLACK
	bg.anchor_left = 0.0
	bg.anchor_top = 0.0
	bg.anchor_right = 1.0
	bg.anchor_bottom = 1.0
	bg.offset_left = 0
	bg.offset_top = 0
	bg.offset_right = 0
	bg.offset_bottom = 0
	add_child(bg)

	# === 2. VBox at the Bottom ===
	var vbox = VBoxContainer.new()
	vbox.anchor_left = 0.0
	vbox.anchor_right = 1.0
	vbox.anchor_top = 1.0
	vbox.anchor_bottom = 1.0
	vbox.offset_left = 40
	vbox.offset_right = -40
	vbox.offset_top = -180
	vbox.offset_bottom = -20
	vbox.set("theme_override_constants/separation", 20)
	add_child(vbox)

	# === 2.5. HBox for Miniature and Dialog ===
	var hbox = HBoxContainer.new()
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	hbox.set("theme_override_constants/separation", 15)
	vbox.add_child(hbox)

	# === 2.6. Miniature Image ===
	miniature_texture_rect = TextureRect.new()
	miniature_texture_rect.custom_minimum_size = Vector2(80, 80)
	miniature_texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	miniature_texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	miniature_texture_rect.visible = false  # Hidden by default
	var line_obj = dialog_lines[current_line]
	if line_obj.has_miniature():
		var texture = load(line_obj.miniature_image_path)
		if texture:
			miniature_texture_rect.texture = texture
			miniature_texture_rect.visible = true
	hbox.add_child(miniature_texture_rect)

	# === 3. Dialog Label ===
	label = Label.new()
	label.text = line_obj.speaker + ": " + line_obj.line if !line_obj.speaker.is_empty() else line_obj.line
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.custom_minimum_size = Vector2(0, 80)
	hbox.add_child(label)

	# === 4. Continue Button ===
	button = Button.new()
	button.text = "Continuar"
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.custom_minimum_size = Vector2(150, 40)
	button.pressed.connect(_on_button_pressed)
	vbox.add_child(button)
