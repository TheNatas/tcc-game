extends Node2D

var TIME_TO_WAIT_FOR_PLAYER_REACTION = 5.0 if Globals.current_level == 0 else 4.0 if Globals.current_level == 1 else 3.0
const MIN_RIGHT_NOTES_PERCENT_TO_ADVANCE = 70

var player_current_degree := Globals.STARTING_DEGREE
var total_chords_in_song := 0  # Will be set when the song starts

signal feedback_status_changed(new_feedback_status: String)

@onready var game_world = $GameWorld
@onready var sound = $sound

# Feedback UI elements
var feedback_container: Control
var feedback_label: Label

func _ready():
	create_feedback_ui()
	# Connect to sound's song_finished signal
	sound.connect("song_finished", Callable(self, "_on_song_finished"))
	# Get total chords from the current song (which was selected in sound.gd)
	await get_tree().create_timer(0.1).timeout  # Wait for sound to initialize
	total_chords_in_song = sound.current_song.chords.size()
	start_next_level()

func create_feedback_ui():
	print("=== Creating feedback UI ===")
	# Create a CanvasLayer to ensure UI is rendered on top and uses screen coordinates
	var canvas_layer = CanvasLayer.new()
	canvas_layer.layer = 100  # High layer to ensure it's on top
	add_child(canvas_layer)
	
	# Create a Control node for the feedback that covers the whole screen
	feedback_container = Control.new()
	feedback_container.set_anchors_preset(Control.PRESET_FULL_RECT)
	feedback_container.offset_left = 0
	feedback_container.offset_top = 0
	feedback_container.offset_right = 0
	feedback_container.offset_bottom = 0
	feedback_container.mouse_filter = Control.MOUSE_FILTER_IGNORE # Don't block mouse events
	feedback_container.visible = false
	canvas_layer.add_child(feedback_container)
	print("feedback_container created and added to canvas layer")
	
	# Add a black background ColorRect at the bottom of the screen (behind everything)
	var background = ColorRect.new()
	background.color = Color(0, 0, 0, 1.0)  # Solid black
	background.anchor_left = 0.0
	background.anchor_right = 1.0
	background.anchor_top = 1.0
	background.anchor_bottom = 1.0
	background.offset_left = 0
	background.offset_right = 0
	background.offset_top = -140
	background.offset_bottom = 0
	feedback_container.add_child(background)
	print("Black background ColorRect created and positioned at bottom")
	
	# Create a VBoxContainer at the bottom of the screen (on top of the background)
	var vbox = VBoxContainer.new()
	vbox.anchor_left = 0.0
	vbox.anchor_right = 1.0
	vbox.anchor_top = 1.0
	vbox.anchor_bottom = 1.0
	vbox.offset_left = 40
	vbox.offset_right = -40
	vbox.offset_top = -140
	vbox.offset_bottom = -20
	vbox.set("theme_override_constants/separation", 10)
	feedback_container.add_child(vbox)
	print("VBoxContainer created")
	
	# Create the feedback label
	feedback_label = Label.new()
	feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	feedback_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	feedback_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	feedback_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	feedback_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	feedback_label.custom_minimum_size = Vector2(0, 80)
	# Add styling for better visibility
	feedback_label.add_theme_color_override("font_color", Color.WHITE)
	feedback_label.add_theme_font_size_override("font_size", 24)
	vbox.add_child(feedback_label)
	print("Label created")
	print("=== Feedback UI creation complete ===")

func show_feedback(message: String, duration: float = 2.0):
	print("show_feedback called with message: ", message)
	print("feedback_container exists: ", feedback_container != null)
	print("feedback_label exists: ", feedback_label != null)
	if feedback_label:
		print("Setting label text to: ", message)
		feedback_label.text = message
	if feedback_container:
		print("Making feedback_container visible")
		feedback_container.visible = true
		feedback_container.z_index = 100  # Ensure it's on top
	await get_tree().create_timer(duration).timeout
	if feedback_container:
		print("Hiding feedback_container")
		feedback_container.visible = false

func start_next_level():
	Levels.notes_switches_on_current_level = 0
	Levels.right_notes_on_current_level = 0

func highlight_degree(degree_index: int, color_to_paint: Color) -> void:
	var degree_color_node = get_tree().get_first_node_in_group("degree" + str(degree_index) + "/ColorRect")
	degree_color_node.color = color_to_paint
	await get_tree().create_timer(3).timeout
	degree_color_node.color = Color(0, 0, 0, 0.196)
	
func finish_level() -> void:
	var right_notes_percent = (float(Levels.right_notes_on_current_level) / total_chords_in_song) * 100
	await get_tree().create_timer(2.0).timeout
	game_world.visible = false
	sound.playing = false
	if (right_notes_percent >= MIN_RIGHT_NOTES_PERCENT_TO_ADVANCE):
		Globals.current_level += 1
		if Globals.current_level >= Levels.number_of_levels:
			# Set flag to indicate we're coming from game finished
			Globals.from_game_finished = true
			get_tree().change_scene_to_file("res://scenes/credits.tscn")
			return
		else:
			get_tree().change_scene_to_file("res://scenes/context.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/failed_level.tscn")
	
func _on_sound_playing_degree_changed(current_playing_degree: int) -> void:
	print("=== _on_sound_playing_degree_changed called ===")
	print("current_playing_degree: ", current_playing_degree)
	Levels.notes_switches_on_current_level += 1
	
	await get_tree().create_timer(TIME_TO_WAIT_FOR_PLAYER_REACTION).timeout
	var player = get_tree().get_first_node_in_group("player")
	player_current_degree = player.current_degree
	print("player_current_degree: ", player_current_degree)
	
	if current_playing_degree == player_current_degree:
		print("CORRECT!")
		Levels.right_notes_on_current_level += 1
		emit_signal("feedback_status_changed", "positive")
		show_feedback("Bom trabalho!", 2.0)
	else:
		print("WRONG!")
		emit_signal("feedback_status_changed", "negative")
		show_feedback("Grau errado, chefe", 2.0)
		highlight_degree(player_current_degree, Color(1,0,0))
		highlight_degree(current_playing_degree, Color(0,1,0))

func _on_song_finished() -> void:
	print("=== Song finished! Ending level ===")
	finish_level()
