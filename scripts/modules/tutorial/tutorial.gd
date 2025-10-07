extends Control

var current_page = 0

# UI elements
var label : Label
var button : Button
var title_label : Label
var page_indicator : Label

# Tutorial content pages from how_to_play.md
var tutorial_pages : Array[Dictionary] = [
	{
		"title": "Welcome to Sound Detective!",
		"content": "A song starts as soon as the game begins. On screen, seven vertical lanes represent the seven scale degrees of the song's key. Your character must stand on the lane that corresponds to the chord currently playing."
	},
	{
		"title": "Objective",
		"content": "Match the character's position to the correct scale degree for each chord in the song.\n\nThe first chord is always the tonic (1), the 1st degree. The character always starts on degree 1 for reference."
	},
	{
		"title": "How It Works",
		"content": "1. Listen: As the song plays, chords change over time.\n\n2. Identify: Each chord corresponds to a scale degree.\n\n3. Move: Shift the character up or down to the lane that matches the current chord's degree.\n\n4. Hold: Stay on the correct lane until the chord changes again, then adjust as needed."
	},
	{
		"title": "Movement & Tips",
		"content": "Move the character up or down using the UP/DOWN arrow keys.\n\nYou can jump multiple lanes if the chord change skips degrees.\n\nUse the first chord (tonic) as your pitch reference.\n\nThink in relative degrees: if you hear a move from I to V, move from lane 1 to lane 5.\n\nThere is one correct lane per chord at any moment."
	}
]

func _ready():
	create_ui_elements()
	button.pressed.connect(_on_button_pressed)
	
func _input(event):
	if event.is_action_pressed("ui_accept"): # "ui_accept" is Enter/Space by default
		_on_button_pressed()

func _on_button_pressed():
	current_page += 1
	
	if current_page < tutorial_pages.size():
		update_page_content()
	else:
		# Tutorial finished, go to gameplay
		get_tree().change_scene_to_file("res://scenes/gameplay.tscn")

func update_page_content():
	var page = tutorial_pages[current_page]
	title_label.text = page["title"]
	label.text = page["content"]
	page_indicator.text = "Page %d of %d - Press ENTER or SPACE to continue" % [current_page + 1, tutorial_pages.size()]
	
	# Update button text on last page
	if current_page == tutorial_pages.size() - 1:
		button.text = "Start Game"
	else:
		button.text = "Continue"

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
	vbox.offset_top = -250
	vbox.offset_bottom = 250
	vbox.set("theme_override_constants/separation", 20)
	add_child(vbox)

	# === 3. Title Label ===
	title_label = Label.new()
	var page = tutorial_pages[current_page]
	title_label.text = page["title"]
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", 32)
	title_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vbox.add_child(title_label)

	# === 4. Spacer ===
	var spacer1 = Control.new()
	spacer1.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer1)

	# === 5. Content Label ===
	label = Label.new()
	label.text = page["content"]
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.custom_minimum_size = Vector2(0, 200)
	label.add_theme_font_size_override("font_size", 18)
	vbox.add_child(label)

	# === 6. Spacer ===
	var spacer2 = Control.new()
	spacer2.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer2)

	# === 7. Page Indicator ===
	page_indicator = Label.new()
	page_indicator.text = "Page %d of %d - Press ENTER or SPACE to continue" % [current_page + 1, tutorial_pages.size()]
	page_indicator.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	page_indicator.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	page_indicator.add_theme_font_size_override("font_size", 14)
	vbox.add_child(page_indicator)

	# === 8. Continue Button ===
	button = Button.new()
	button.text = "Continue"
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.custom_minimum_size = Vector2(150, 40)
	button.pressed.connect(_on_button_pressed)
	vbox.add_child(button)
