extends Control

# Interactive chord demo variables
var current_chord_index = 0
var chord_demo_timer = 0.0
var chord_demo_interval = 3.0  # 3 seconds per chord
var audio_player : AudioStreamPlayer = null
var degree_display_label : Label = null
var button : Button = null

# Chords for each level based on key and instrument
const LEVEL_CHORDS = {
	0: {  # Level 0 - C major, piano
		0: {"name": "C (Tônica)", "degree": 1, "sound": preload("res://assets/piano/C.wav")},
		1: {"name": "Dm", "degree": 2, "sound": preload("res://assets/piano/Dm.wav")},
		2: {"name": "Em", "degree": 3, "sound": preload("res://assets/piano/Em.wav")},
		3: {"name": "F", "degree": 4, "sound": preload("res://assets/piano/F.wav")},
		4: {"name": "G", "degree": 5, "sound": preload("res://assets/piano/G.wav")},
		5: {"name": "Am", "degree": 6, "sound": preload("res://assets/piano/Am.wav")},
		6: {"name": "Bm", "degree": 7, "sound": preload("res://assets/piano/Bm.wav")},
	},
	1: {  # Level 1 - G major, guitar
		0: {"name": "G (Tônica)", "degree": 1, "sound": preload("res://assets/guitar/G.wav")},
		1: {"name": "Am", "degree": 2, "sound": preload("res://assets/guitar/Am.wav")},
		2: {"name": "Bm", "degree": 3, "sound": preload("res://assets/guitar/Bm.wav")},
		3: {"name": "C", "degree": 4, "sound": preload("res://assets/guitar/C.wav")},
		4: {"name": "D", "degree": 5, "sound": preload("res://assets/guitar/D.wav")},
		5: {"name": "Em", "degree": 6, "sound": preload("res://assets/guitar/Em.wav")},
		6: {"name": "F#m", "degree": 7, "sound": preload("res://assets/guitar/F#m.wav")},
	},
	2: {  # Level 2 - D major, electric guitar
		0: {"name": "D (Tônica)", "degree": 1, "sound": preload("res://assets/eletric_guitar/D.wav")},
		1: {"name": "Em", "degree": 2, "sound": preload("res://assets/eletric_guitar/Em.wav")},
		2: {"name": "F#m", "degree": 3, "sound": preload("res://assets/eletric_guitar/F#m.wav")},
		3: {"name": "G", "degree": 4, "sound": preload("res://assets/eletric_guitar/G.wav")},
		4: {"name": "A", "degree": 5, "sound": preload("res://assets/eletric_guitar/A.wav")},
		5: {"name": "Bm", "degree": 6, "sound": preload("res://assets/eletric_guitar/Bm.wav")},
		6: {"name": "C#m", "degree": 7, "sound": preload("res://assets/eletric_guitar/C#m.wav")},
	}
}

var current_level_chords: Dictionary

func _ready():
	# Get the chords for the current level
	var level = Globals.current_level
	if LEVEL_CHORDS.has(level):
		current_level_chords = LEVEL_CHORDS[level]
	else:
		# Fallback to level 0 chords if level not found
		current_level_chords = LEVEL_CHORDS[0]
	
	# Create audio player for chord demo
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	
	create_ui_elements()
	button.pressed.connect(_on_button_pressed)
	
	# Start the chord demo
	current_chord_index = 0
	chord_demo_timer = 0.0
	play_chord_demo(0)

func _process(delta):
	chord_demo_timer += delta
	if chord_demo_timer >= chord_demo_interval:
		chord_demo_timer = 0.0
		current_chord_index += 1
		
		if current_chord_index < current_level_chords.size():
			play_chord_demo(current_chord_index)
		else:
			# Reset and loop
			current_chord_index = 0
			play_chord_demo(current_chord_index)
	
func _input(event):
	if event.is_action_pressed("confirm"):
		_on_button_pressed()

func play_chord_demo(index: int):
	if current_level_chords.has(index) and audio_player:
		var chord_data = current_level_chords[index]
		audio_player.stream = chord_data["sound"]
		audio_player.play()
		
		if degree_display_label:
			degree_display_label.text = "Grau: %d\nAcorde: %s" % [chord_data["degree"], chord_data["name"]]

func _on_button_pressed():
	# Stop the audio and go to gameplay
	if audio_player:
		audio_player.stop()
	get_tree().change_scene_to_file("res://scenes/gameplay.tscn")

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

	# === 2. Main VBox Container (centered vertically) ===
	var vbox = VBoxContainer.new()
	vbox.anchor_left = 0.0
	vbox.anchor_right = 1.0
	vbox.anchor_top = 0.5
	vbox.anchor_bottom = 0.5
	vbox.offset_left = 60
	vbox.offset_right = -60
	vbox.offset_top = -300
	vbox.offset_bottom = 300
	vbox.set("theme_override_constants/separation", 20)
	add_child(vbox)

	# === 3. Title Label ===
	var title_label = Label.new()
	title_label.text = "Revisão dos Graus da Escala"
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", 32)
	title_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vbox.add_child(title_label)

	# === 4. Spacer ===
	var spacer1 = Control.new()
	spacer1.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer1)

	# === 5. Description Label ===
	var label = Label.new()
	label.text = "Ouça os acordes da escala antes de começar o nível.\nCada acorde corresponde a um grau da escala."
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 18)
	vbox.add_child(label)

	# === 6. Spacer ===
	var spacer2 = Control.new()
	spacer2.custom_minimum_size = Vector2(0, 30)
	vbox.add_child(spacer2)

	# === 7. Degree display (large text showing current degree and chord) ===
	degree_display_label = Label.new()
	# Get the first chord name for the current level
	var first_chord_name = current_level_chords[0]["name"] if current_level_chords.has(0) else "C (Tônica)"
	degree_display_label.text = "Grau: 1\nAcorde: %s" % first_chord_name
	degree_display_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	degree_display_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	degree_display_label.add_theme_font_size_override("font_size", 48)
	degree_display_label.custom_minimum_size = Vector2(400, 200)
	degree_display_label.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	vbox.add_child(degree_display_label)

	# === 8. Spacer ===
	var spacer3 = Control.new()
	spacer3.custom_minimum_size = Vector2(0, 30)
	vbox.add_child(spacer3)

	# === 9. Info label ===
	var info_label = Label.new()
	info_label.text = "Os acordes tocarão automaticamente, um a cada %d segundos." % int(chord_demo_interval)
	info_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	info_label.add_theme_font_size_override("font_size", 14)
	info_label.modulate = Color(0.8, 0.8, 0.8)
	vbox.add_child(info_label)

	# === 10. Spacer ===
	var spacer4 = Control.new()
	spacer4.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer4)

	# === 11. Continue Button ===
	button = Button.new()
	button.text = "Iniciar Nível"
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.custom_minimum_size = Vector2(150, 40)
	button.pressed.connect(_on_button_pressed)
	vbox.add_child(button)

	# === 12. Page Indicator ===
	var page_indicator = Label.new()
	page_indicator.text = "Pressione ENTER ou ESPAÇO para continuar"
	page_indicator.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	page_indicator.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	page_indicator.add_theme_font_size_override("font_size", 14)
	vbox.add_child(page_indicator)
