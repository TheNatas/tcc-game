extends Control

@onready var start_button: Button = null
@onready var exit_button: Button = null

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

	# Create a vertical container for buttons
	var vbox := VBoxContainer.new()
	vbox.anchor_left = 0.5
	vbox.anchor_top = 0.5
	vbox.anchor_right = 0.5
	vbox.anchor_bottom = 0.5
	vbox.grow_horizontal = Control.GROW_DIRECTION_BOTH
	vbox.grow_vertical = Control.GROW_DIRECTION_BOTH
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.set_position(Vector2(-75, -50)) # Centered with offset
	add_child(vbox)

	# Start Game Button
	start_button = Button.new()
	start_button.text = "Start Game"
	start_button.custom_minimum_size = Vector2(150, 40)
	vbox.add_child(start_button)
	start_button.connect("pressed", Callable(self, "_on_start_game_pressed"))

	# Exit Button
	exit_button = Button.new()
	exit_button.text = "Exit"
	exit_button.custom_minimum_size = Vector2(150, 40)
	vbox.add_child(exit_button)
	exit_button.connect("pressed", Callable(self, "_on_exit_pressed"))

	# Set initial focus to Start button
	start_button.grab_focus()


func _on_start_game_pressed() -> void:
	var is_game_finished = Globals.current_level == 3
	if is_game_finished:
		Globals.current_level = 0 # reset game
	get_tree().change_scene_to_file("res://scenes/context.tscn")


func _on_exit_pressed() -> void:
	print("Exit pressed!")
	get_tree().quit()
