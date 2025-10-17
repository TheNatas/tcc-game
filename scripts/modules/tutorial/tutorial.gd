extends Control

var current_page = 0

# UI elements
var label : Label
var button : Button
var title_label : Label
var page_indicator : Label
var content_container : Control  # Will hold either VBox or HBox depending on layout
var media_display : Control  # Can be TextureRect or VideoStreamPlayer

# Interactive chord demo variables
var chord_demo_active = false
var current_chord_index = 0
var chord_demo_timer = 0.0
var chord_demo_interval = 3.0  # 2 seconds per chord
var audio_player : AudioStreamPlayer = null
var degree_display_label : Label = null

# Piano chords for C major scale
const PIANO_CHORDS = {
	0: {"name": "C (Tônica)", "degree": 1, "sound": preload("res://assets/piano/C.wav")},
	1: {"name": "Dm", "degree": 2, "sound": preload("res://assets/piano/Dm.wav")},
	2: {"name": "Em", "degree": 3, "sound": preload("res://assets/piano/Em.wav")},
	3: {"name": "F", "degree": 4, "sound": preload("res://assets/piano/F.wav")},
	4: {"name": "G", "degree": 5, "sound": preload("res://assets/piano/G.wav")},
	5: {"name": "Am", "degree": 6, "sound": preload("res://assets/piano/Am.wav")},
	6: {"name": "Bm", "degree": 7, "sound": preload("res://assets/piano/Bm.wav")},
}

# Tutorial content pages from how_to_play.md
var tutorial_pages : Array[Dictionary] = [
	{
		"title": "Bem-vindo a Detetive Sonora!",
		"content": "Uma música começa assim que o jogo inicia. Na tela, sete pistas verticais representam os sete graus da escala da tonalidade da música. Seu personagem deve ficar na pista que corresponde ao acorde que está tocando.",
		"media": "res://assets/gameplay samples/resized gameplay sample 1.png",
		"media_type": "image",
		"layout": "vertical"  # Image below text
	},
	{
		"title": "Objetivo",
		"content": "Ajuste a posição do personagem para o grau da escala correto para cada acorde da música.\n\nO primeiro acorde é sempre a tônica (1), o 1º grau. O personagem sempre começa no grau 1 como referência.",
		"media": "res://assets/gameplay samples/resized gameplay sample 2.png",
		"media_type": "image",
		"layout": "horizontal"  # Image to the right
	},
	{
		"title": "Como Funciona",
		"content": "1. Ouça: Enquanto a música toca, os acordes mudam ao longo do tempo.\n\n2. Identifique: Cada acorde corresponde a um grau da escala.\n\n3. Mova: Leve o personagem para cima ou para baixo até a pista que corresponde ao grau do acorde atual.\n\n4. Mantenha: Fique na pista correta até o acorde mudar novamente e então ajuste se necessário.",
		"media": "res://assets/gameplay samples/gameplay sample 3.ogv",
		"media_type": "video",
		"layout": "horizontal"  # Video to the right
	},
	{
		"title": "Exemplo Prático",
		"content": "Aqui vai um exemplo prático dos acordes dentro de um tom com os graus equivalentes descritos, iniciando do acorde de referência (tônica).",
		"media": "",
		"media_type": "interactive",
		"layout": "interactive"  # Special layout for interactive chord demo
	},
	{
		"title": "Movimento e Dicas",
		"content": "Mova o personagem para cima ou para baixo usando as setas CIMA/BAIXO.\n\nVocê pode pular várias pistas se a mudança de acorde saltar graus.\n\nUse o primeiro acorde (tônica) como sua referência de altura.\n\nPense em graus relativos: se você ouvir uma mudança de I para V, mova da pista 1 para a pista 5.\n\nHá apenas uma pista correta para cada acorde em cada momento.",
		"media": "res://assets/updownkeys.png",
		"media_type": "image",
		"layout": "horizontal"
	}
]

func _ready():
	# Create audio player for chord demo
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	
	create_ui_elements()
	button.pressed.connect(_on_button_pressed)

func _process(delta):
	if chord_demo_active:
		chord_demo_timer += delta
		if chord_demo_timer >= chord_demo_interval:
			chord_demo_timer = 0.0
			current_chord_index += 1
			
			if current_chord_index < PIANO_CHORDS.size():
				play_chord_demo(current_chord_index)
			else:
				# Reset and loop
				current_chord_index = 0
				play_chord_demo(current_chord_index)
	
func _input(event):
	if event.is_action_pressed("confirm"):
		_on_button_pressed()

func play_chord_demo(index: int):
	if PIANO_CHORDS.has(index) and audio_player:
		var chord_data = PIANO_CHORDS[index]
		audio_player.stream = chord_data["sound"]
		audio_player.play()
		
		if degree_display_label:
			degree_display_label.text = "Grau: %d\nAcorde: %s" % [chord_data["degree"], chord_data["name"]]

func _on_button_pressed():
	# Stop chord demo if it's active
	if chord_demo_active:
		chord_demo_active = false
		current_chord_index = 0
		chord_demo_timer = 0.0
		if audio_player:
			audio_player.stop()
	
	current_page += 1
	
	if current_page < tutorial_pages.size():
		# Recreate UI for new page (since layout may change)
		for child in get_children():
			if child != audio_player:  # Don't remove the audio player
				child.queue_free()
		create_ui_elements()
		
		# Start chord demo if this is the interactive page
		var page = tutorial_pages[current_page]
		if page.get("layout") == "interactive":
			chord_demo_active = true
			current_chord_index = 0
			chord_demo_timer = 0.0
			play_chord_demo(0)
	else:
		# Tutorial finished, go to gameplay
		get_tree().change_scene_to_file("res://scenes/gameplay.tscn")

func update_page_content():
	var page = tutorial_pages[current_page]
	title_label.text = page["title"]
	label.text = page["content"]
	page_indicator.text = "Página %d de %d - Pressione ENTER ou ESPAÇO para continuar" % [current_page + 1, tutorial_pages.size()]
	
	# Update button text on last page
	if current_page == tutorial_pages.size() - 1:
		button.text = "Iniciar Jogo"
	else:
		button.text = "Continuar"
	
	# Update media display
	if page.has("media") and page["media"] != "":
		media_display.visible = true
		var texture = load(page["media"])
		if texture:
			media_display.texture = texture
	else:
		media_display.visible = false

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

	# === 5. Content Container (will change based on layout) ===
	content_container = create_content_layout(page)
	vbox.add_child(content_container)

	# === 6. Spacer ===
	var spacer2 = Control.new()
	spacer2.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer2)

	# === 7. Page Indicator ===
	page_indicator = Label.new()
	page_indicator.text = "Página %d de %d - Pressione ENTER ou ESPAÇO para continuar" % [current_page + 1, tutorial_pages.size()]
	page_indicator.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	page_indicator.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	page_indicator.add_theme_font_size_override("font_size", 14)
	vbox.add_child(page_indicator)

	# === 8. Continue Button ===
	button = Button.new()
	if current_page == tutorial_pages.size() - 1:
		button.text = "Iniciar Jogo"
	else:
		button.text = "Continuar"
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.custom_minimum_size = Vector2(150, 40)
	button.pressed.connect(_on_button_pressed)
	vbox.add_child(button)

func create_content_layout(page: Dictionary) -> Control:
	var layout = page.get("layout", "vertical")
	var has_media = page.has("media") and page["media"] != ""
	var media_type = page.get("media_type", "none")
	
	# Handle interactive chord demo layout
	if layout == "interactive":
		var vbox_interactive = VBoxContainer.new()
		vbox_interactive.set("theme_override_constants/separation", 30)
		vbox_interactive.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox_interactive.size_flags_vertical = Control.SIZE_EXPAND_FILL
		vbox_interactive.alignment = BoxContainer.ALIGNMENT_CENTER
		
		# Text label
		label = Label.new()
		label.text = page["content"]
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.add_theme_font_size_override("font_size", 18)
		vbox_interactive.add_child(label)
		
		# Degree display (large text showing current degree and chord)
		degree_display_label = Label.new()
		degree_display_label.text = "Grau: 1\nAcorde: C (Tônica)"
		degree_display_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		degree_display_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		degree_display_label.add_theme_font_size_override("font_size", 48)
		degree_display_label.custom_minimum_size = Vector2(400, 200)
		degree_display_label.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		vbox_interactive.add_child(degree_display_label)
		
		# Info label
		var info_label = Label.new()
		info_label.text = "Os acordes tocarão automaticamente, um a cada %d segundos." % int(chord_demo_interval)
		info_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		info_label.add_theme_font_size_override("font_size", 14)
		info_label.modulate = Color(0.8, 0.8, 0.8)
		vbox_interactive.add_child(info_label)
		
		media_display = degree_display_label
		return vbox_interactive
	
	if layout == "horizontal" and has_media:
		# Horizontal layout: text on left, media on right
		var hbox = HBoxContainer.new()
		hbox.set("theme_override_constants/separation", 30)
		hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
		hbox.alignment = BoxContainer.ALIGNMENT_CENTER  # Center items vertically
		
		# Text label on the left
		label = Label.new()
		label.text = page["content"]
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		label.custom_minimum_size = Vector2(300, 0)
		label.add_theme_font_size_override("font_size", 18)
		hbox.add_child(label)
		
		# Media on the right
		if media_type == "video":
			var video_player = VideoStreamPlayer.new()
			var video_stream = load(page["media"])
			if video_stream:
				video_player.stream = video_stream
				video_player.autoplay = true
				video_player.loop = true
				video_player.volume_db = -80  # Mute the video
				video_player.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				video_player.size_flags_vertical = Control.SIZE_FILL
				video_player.custom_minimum_size = Vector2(350, 250)
				video_player.expand = true
				media_display = video_player
				hbox.add_child(video_player)
			else:
				print("Failed to load video: ", page["media"])
				# Fallback to a label showing error
				var error_label = Label.new()
				error_label.text = "[Video não disponível]"
				error_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
				error_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
				error_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				error_label.size_flags_vertical = Control.SIZE_FILL
				error_label.custom_minimum_size = Vector2(350, 250)
				media_display = error_label
				hbox.add_child(error_label)
		else:
			var texture_rect = TextureRect.new()
			texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
			texture_rect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			texture_rect.size_flags_vertical = Control.SIZE_FILL
			texture_rect.custom_minimum_size = Vector2(350, 250)
			var texture = load(page["media"])
			if texture:
				texture_rect.texture = texture
			media_display = texture_rect
			hbox.add_child(texture_rect)
		
		return hbox
	else:
		# Vertical layout: text on top, media below (or just text if no media)
		var vbox_content = VBoxContainer.new()
		vbox_content.set("theme_override_constants/separation", 20)
		vbox_content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox_content.size_flags_vertical = Control.SIZE_EXPAND_FILL
		
		# Text label
		label = Label.new()
		label.text = page["content"]
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
		label.add_theme_font_size_override("font_size", 18)
		vbox_content.add_child(label)
		
		# Media below (if exists)
		if has_media:
			if media_type == "video":
				var video_player = VideoStreamPlayer.new()
				var video_stream = load(page["media"])
				if video_stream:
					video_player.stream = video_stream
					video_player.autoplay = true
					video_player.loop = true
					video_player.volume_db = -80  # Mute the video
					video_player.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
					video_player.size_flags_vertical = Control.SIZE_EXPAND_FILL
					video_player.custom_minimum_size = Vector2(0, 200)
					video_player.expand = true
					media_display = video_player
					vbox_content.add_child(video_player)
				else:
					print("Failed to load video: ", page["media"])
					# Fallback to error label
					var error_label = Label.new()
					error_label.text = "[Video não disponível]"
					error_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
					media_display = error_label
					vbox_content.add_child(error_label)
			else:
				var texture_rect = TextureRect.new()
				texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
				texture_rect.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
				texture_rect.size_flags_vertical = Control.SIZE_EXPAND_FILL
				texture_rect.custom_minimum_size = Vector2(0, 200)
				var texture = load(page["media"])
				if texture:
					texture_rect.texture = texture
				media_display = texture_rect
				vbox_content.add_child(texture_rect)
		else:
			# No media placeholder
			media_display = Control.new()
			media_display.visible = false
		
		return vbox_content
