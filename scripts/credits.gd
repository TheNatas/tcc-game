extends Control

@onready var back_button: Button = null
@onready var continue_button: Button = null
@onready var scroll_container: ScrollContainer = null

var came_from_game_finished := false
const SCROLL_SPEED := 30  # Pixels per scroll action
var credits_audio_player: AudioStreamPlayer = null

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
	scroll_container = ScrollContainer.new()
	scroll_container.anchor_left = 0.1
	scroll_container.anchor_top = 0.1
	scroll_container.anchor_right = 0.9
	scroll_container.anchor_bottom = 0.85
	scroll_container.follow_focus = true
	add_child(scroll_container)

	# Create a vertical container for credits content
	var vbox := VBoxContainer.new()
	vbox.size_flags_horizontal = Control.SIZE_FILL
	vbox.add_theme_constant_override("separation", 20)
	scroll_container.add_child(vbox)

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

	# Spacing
	vbox.add_child(Control.new())

	# Voiceover Section
	var voiceover_title := Label.new()
	voiceover_title.text = "Dublagem"
	voiceover_title.add_theme_font_size_override("font_size", 24)
	vbox.add_child(voiceover_title)

	var voice_ator := Label.new()
	voice_ator.text = "Detetive Sonora: Lorenzo Silveira Ribeiro\n(@loreribeiro)"
	voice_ator.add_theme_font_size_override("font_size", 16)
	vbox.add_child(voice_ator)

	var voice_ator2 := Label.new()
	voice_ator2.text = "Ministra de Armas: Vitória Moreira Alves\n(@vitoria__allvez)"
	voice_ator2.add_theme_font_size_override("font_size", 16)
	vbox.add_child(voice_ator2)

	var voice_ator3 := Label.new()
	voice_ator3.text = "Criminoso: Vinicius C. Serafin\n(@vinicius_soo)"
	voice_ator3.add_theme_font_size_override("font_size", 16)
	vbox.add_child(voice_ator3)

	var voice_acting_coord := Label.new()
	voice_acting_coord.text = "Coordenação: Milena C. Brasil\n(@mibrasilll)"
	voice_acting_coord.add_theme_font_size_override("font_size", 16)
	vbox.add_child(voice_acting_coord)

	# Create a container for the button at the bottom
	var bottom_container := CenterContainer.new()
	bottom_container.anchor_left = 0.0
	bottom_container.anchor_top = 0.85
	bottom_container.anchor_right = 1.0
	bottom_container.anchor_bottom = 1.0
	add_child(bottom_container)

	# Create a button container
	var button_container := HBoxContainer.new()
	button_container.alignment = BoxContainer.ALIGNMENT_CENTER
	button_container.add_theme_constant_override("separation", 20)
	bottom_container.add_child(button_container)

	# Get info if we came from game_finished scene
	came_from_game_finished = Globals.from_game_finished
	Globals.from_game_finished = false
	
	# Play music based on where we came from
	if came_from_game_finished:
		# Play the complete theme variation when coming from game finished
		credits_audio_player = AudioStreamPlayer.new()
		add_child(credits_audio_player)
		credits_audio_player.stream = preload("res://assets/songs/theme complete.wav")
		credits_audio_player.connect("finished", Callable(self, "_on_credits_music_finished"))
		credits_audio_player.play()
	# If coming from main menu, the regular theme music is already playing

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


func _input(event: InputEvent) -> void:
	# Handle scrolling with move_up/move_down
	if event.is_action_pressed("move_up"):
		if scroll_container != null:
			scroll_container.scroll_vertical -= SCROLL_SPEED
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_down"):
		if scroll_container != null:
			scroll_container.scroll_vertical += SCROLL_SPEED
			get_viewport().set_input_as_handled()
	
	if event.is_action_pressed("confirm"):
		# Check which button has focus and press it
		if back_button != null and back_button.has_focus():
			_on_back_pressed()
		elif continue_button != null and continue_button.has_focus():
			_on_continue_pressed()
	if event.is_action_pressed("back"):
		# Check which button has focus and press it
		if back_button != null:
			_on_back_pressed()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_continue_pressed() -> void:
	# Stop credits music if it was playing
	if credits_audio_player and credits_audio_player.playing:
		credits_audio_player.stop()
	# Start regular menu music for main menu
	MusicManager.play_menu_music()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_credits_music_finished() -> void:
	# Loop the credits music
	if credits_audio_player:
		credits_audio_player.play()
