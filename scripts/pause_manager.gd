extends CanvasLayer

var is_paused = false
var pause_menu: Control
var resume_button: Button
var main_menu_button: Button
var can_pause = false  # Only allow pause in gameplay scene

func _ready():
	# Create pause menu UI
	create_pause_menu()
	# Start hidden
	pause_menu.visible = false
	# Set process mode to always process even when paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	# Connect to scene changes
	get_tree().node_added.connect(_on_node_added)
	# Check if we're in gameplay scene
	check_current_scene()

func _on_node_added(node: Node):
	# When root node changes, check if we're in gameplay
	if node == get_tree().current_scene:
		check_current_scene()

func check_current_scene():
	# Wait a frame to ensure scene is loaded
	await get_tree().process_frame
	var current_scene = get_tree().current_scene
	if current_scene:
		# Check if we're in the gameplay scene
		can_pause = current_scene.scene_file_path == "res://scenes/gameplay.tscn"
		# Make sure pause is disabled when leaving gameplay
		if !can_pause and is_paused:
			get_tree().paused = false
			is_paused = false
			pause_menu.visible = false

func _input(event):
	# Only toggle pause if we're in gameplay scene
	if can_pause and event.is_action_pressed("pause"):
		toggle_pause()
	# Allow unpausing with back button when paused
	elif is_paused and event.is_action_pressed("back"):
		resume_game()
	# Handle confirm action when paused
	elif is_paused and event.is_action_pressed("confirm"):
		# Check which button has focus and press it
		if resume_button.has_focus():
			_on_resume_pressed()
		elif main_menu_button.has_focus():
			_on_main_menu_pressed()

func toggle_pause():
	if !can_pause:
		return  # Don't allow pause if not in gameplay
		
	is_paused = !is_paused
	get_tree().paused = is_paused
	pause_menu.visible = is_paused
	
	if is_paused:
		# Stop any playing audio when paused (optional)
		pause_audio()
		# Set focus to resume button when paused
		resume_button.grab_focus()
	else:
		# Resume audio when unpaused (optional)
		resume_audio()

func pause_game():
	if !can_pause or is_paused:
		return
	toggle_pause()

func resume_game():
	if !is_paused:
		return
	toggle_pause()

func pause_audio():
	# Pause all audio in the scene
	for node in get_tree().get_nodes_in_group("audio"):
		if node is AudioStreamPlayer or node is AudioStreamPlayer2D or node is AudioStreamPlayer3D:
			node.stream_paused = true

func resume_audio():
	# Resume all audio in the scene
	for node in get_tree().get_nodes_in_group("audio"):
		if node is AudioStreamPlayer or node is AudioStreamPlayer2D or node is AudioStreamPlayer3D:
			node.stream_paused = false

func create_pause_menu():
	# Create main container
	pause_menu = Control.new()
	pause_menu.set_anchors_preset(Control.PRESET_FULL_RECT)
	pause_menu.offset_left = 0
	pause_menu.offset_top = 0
	pause_menu.offset_right = 0
	pause_menu.offset_bottom = 0
	# Set process mode to always so buttons work when paused
	pause_menu.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(pause_menu)
	
	# Semi-transparent black background
	var background = ColorRect.new()
	background.color = Color(0, 0, 0, 0.7)
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	background.offset_left = 0
	background.offset_top = 0
	background.offset_right = 0
	background.offset_bottom = 0
	pause_menu.add_child(background)
	
	# Center container for buttons
	var center_container = VBoxContainer.new()
	center_container.set_anchors_preset(Control.PRESET_CENTER)
	center_container.offset_left = -150
	center_container.offset_top = -100
	center_container.offset_right = 150
	center_container.offset_bottom = 100
	center_container.set("theme_override_constants/separation", 20)
	pause_menu.add_child(center_container)
	
	# Pause title
	var title = Label.new()
	title.text = "PAUSADO"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 48)
	title.add_theme_color_override("font_color", Color.WHITE)
	center_container.add_child(title)
	
	# Resume button
	resume_button = Button.new()
	resume_button.text = "Continuar"
	resume_button.custom_minimum_size = Vector2(250, 50)
	resume_button.pressed.connect(_on_resume_pressed)
	resume_button.process_mode = Node.PROCESS_MODE_ALWAYS
	center_container.add_child(resume_button)
	
	# Main menu button
	main_menu_button = Button.new()
	main_menu_button.text = "Menu Principal"
	main_menu_button.custom_minimum_size = Vector2(250, 50)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	main_menu_button.process_mode = Node.PROCESS_MODE_ALWAYS
	center_container.add_child(main_menu_button)
	
	# Set focus neighbor relationships for controller/keyboard navigation
	resume_button.focus_neighbor_bottom = resume_button.get_path_to(main_menu_button)
	resume_button.focus_neighbor_top = resume_button.get_path_to(main_menu_button)
	main_menu_button.focus_neighbor_top = main_menu_button.get_path_to(resume_button)
	main_menu_button.focus_neighbor_bottom = main_menu_button.get_path_to(resume_button)

func _on_resume_pressed():
	resume_game()

func _on_main_menu_pressed():
	# Unpause before changing scene
	get_tree().paused = false
	is_paused = false
	pause_menu.visible = false
	can_pause = false  # Disable pause when leaving gameplay
	# Change to main menu
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
