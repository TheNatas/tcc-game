extends Control

@onready var free_movement_button: Button = null
@onready var fixed_movement_button: Button = null
@onready var back_button: Button = null

func _ready() -> void:
	# Make this root control fill the window
	anchor_left = 0.0
	anchor_top = 0.0
	anchor_right = 1.0
	anchor_bottom = 1.0

	# Add background color
	var background := ColorRect.new()
	background.color = Color(0.15, 0.15, 0.2) # dark bluish
	background.anchor_left = 0.0
	background.anchor_top = 0.0
	background.anchor_right = 1.0
	background.anchor_bottom = 1.0
	add_child(background)

	# Create a CenterContainer to automatically center its contents
	var center_container := CenterContainer.new()
	center_container.anchor_left = 0.0
	center_container.anchor_top = 0.0
	center_container.anchor_right = 1.0
	center_container.anchor_bottom = 1.0
	add_child(center_container)

	# Create a vertical container for title and buttons
	var vbox := VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	center_container.add_child(vbox)

	# Title Label
	var title := Label.new()
	title.text = "Configurações"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 32)
	vbox.add_child(title)

	# Add some spacing
	var spacer := Control.new()
	spacer.custom_minimum_size = Vector2(0, 30)
	vbox.add_child(spacer)

	# Subtitle for movement style
	var subtitle := Label.new()
	subtitle.text = "Estilo de Movimento"
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_font_size_override("font_size", 20)
	vbox.add_child(subtitle)

	# Add some spacing
	var spacer2 := Control.new()
	spacer2.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer2)

  # Fixed Movement Button
	fixed_movement_button = Button.new()
	fixed_movement_button.text = "Movimento Fixo"
	fixed_movement_button.custom_minimum_size = Vector2(200, 40)
	fixed_movement_button.toggle_mode = true
	vbox.add_child(fixed_movement_button)
	fixed_movement_button.connect("pressed", Callable(self, "_on_fixed_movement_pressed"))

  # Free Movement Button
	free_movement_button = Button.new()
	free_movement_button.text = "Movimento Livre"
	free_movement_button.custom_minimum_size = Vector2(200, 40)
	free_movement_button.toggle_mode = true
	vbox.add_child(free_movement_button)
	free_movement_button.connect("pressed", Callable(self, "_on_free_movement_pressed"))

	# Add some spacing
	var spacer3 := Control.new()
	spacer3.custom_minimum_size = Vector2(0, 30)
	vbox.add_child(spacer3)

	# Back Button
	back_button = Button.new()
	back_button.text = "Voltar"
	back_button.custom_minimum_size = Vector2(150, 40)
	vbox.add_child(back_button)
	back_button.connect("pressed", Callable(self, "_on_back_pressed"))

	# Update button states based on current setting
	_update_button_states()

	# Set initial focus
	free_movement_button.grab_focus()


func _update_button_states() -> void:
	if Globals.movement_style == "free":
		free_movement_button.button_pressed = true
		fixed_movement_button.button_pressed = false
	else:
		free_movement_button.button_pressed = false
		fixed_movement_button.button_pressed = true


func _on_free_movement_pressed() -> void:
	Globals.movement_style = "free"
	_update_button_states()


func _on_fixed_movement_pressed() -> void:
	Globals.movement_style = "fixed"
	_update_button_states()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("confirm"):
		# Check which button has focus and press it
		if free_movement_button.has_focus():
			_on_free_movement_pressed()
		elif fixed_movement_button.has_focus():
			_on_fixed_movement_pressed()
		elif back_button.has_focus():
			_on_back_pressed()
	if event.is_action_pressed("back"):
		# Check which button has focus and press it
		if back_button != null:
			_on_back_pressed()
