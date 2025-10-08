extends Control

@onready var back_button: Button = null
@onready var continue_button: Button = null

var came_from_game_finished := false

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

	# Create a scroll container for credits
	var scroll := ScrollContainer.new()
	scroll.anchor_left = 0.1
	scroll.anchor_top = 0.1
	scroll.anchor_right = 0.9
	scroll.anchor_bottom = 0.85
	scroll.follow_focus = true
	add_child(scroll)

	# Create a vertical container for credits content
	var vbox := VBoxContainer.new()
	vbox.size_flags_horizontal = Control.SIZE_FILL
	vbox.add_theme_constant_override("separation", 20)
	scroll.add_child(vbox)

	# Title
	var title := Label.new()
	title.text = "CRÉDITOS"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 32)
	vbox.add_child(title)

	# Add some spacing
	vbox.add_child(Control.new())

	# Game Development Section
	var dev_title := Label.new()
	dev_title.text = "Desenvolvimento do Jogo"
	dev_title.add_theme_font_size_override("font_size", 24)
	vbox.add_child(dev_title)

	var creator := Label.new()
	creator.text = "Criador & Desenvolvedor: Natanael Alves Gabriel\n(natasnael2002@gmail.com)"
	creator.add_theme_font_size_override("font_size", 16)
	vbox.add_child(creator)

	# Spacing
	vbox.add_child(Control.new())

	# Project Supervision Section
	var supervision_title := Label.new()
	supervision_title.text = "Supervisão do Projeto"
	supervision_title.add_theme_font_size_override("font_size", 24)
	vbox.add_child(supervision_title)

	var orientator := Label.new()
	orientator.text = "Orientador do Projeto: Giácomo Antônio Althoff Bolan"
	orientator.add_theme_font_size_override("font_size", 16)
	vbox.add_child(orientator)

	# Spacing
	vbox.add_child(Control.new())

	# Consultancy Section
	var consultancy_title := Label.new()
	consultancy_title.text = "Consultoria"
	consultancy_title.add_theme_font_size_override("font_size", 24)
	vbox.add_child(consultancy_title)

	var consultant := Label.new()
	consultant.text = "Consultora de Pedagogia Musical: Édina Reginar Baumer"
	consultant.add_theme_font_size_override("font_size", 16)
	vbox.add_child(consultant)

	# Spacing
	vbox.add_child(Control.new())

	# Music & Soundtrack Section
	var music_title := Label.new()
	music_title.text = "Música & Trilha Sonora"
	music_title.add_theme_font_size_override("font_size", 24)
	vbox.add_child(music_title)

	var composer := Label.new()
	composer.text = "Compositor: Natanael Alves Gabriel"
	composer.add_theme_font_size_override("font_size", 16)
	vbox.add_child(composer)

	# Create a button container at the bottom
	var button_container := HBoxContainer.new()
	button_container.anchor_left = 0.5
	button_container.anchor_top = 0.9
	button_container.anchor_right = 0.5
	button_container.anchor_bottom = 0.9
	button_container.grow_horizontal = Control.GROW_DIRECTION_BOTH
	button_container.alignment = BoxContainer.ALIGNMENT_CENTER
	button_container.add_theme_constant_override("separation", 20)
	button_container.set_position(Vector2(-100, 0))
	add_child(button_container)

	# Get info if we came from game_finished scene
	came_from_game_finished = Globals.from_game_finished
	Globals.from_game_finished = false

	# Back Button (shown when accessed from main menu)
	if not came_from_game_finished:
		back_button = Button.new()
		back_button.text = "Voltar"
		back_button.custom_minimum_size = Vector2(150, 40)
		button_container.add_child(back_button)
		back_button.connect("pressed", Callable(self, "_on_back_pressed"))
		back_button.grab_focus()
	else:
		# Continue Button (shown when accessed after game finished)
		continue_button = Button.new()
		continue_button.text = "Menu Principal"
		continue_button.custom_minimum_size = Vector2(200, 40)
		button_container.add_child(continue_button)
		continue_button.connect("pressed", Callable(self, "_on_continue_pressed"))
		continue_button.grab_focus()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
