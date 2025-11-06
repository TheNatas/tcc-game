extends Control

var current_page = 0

# UI elements
var label : Label
var button : Button
var title_label : Label
var page_indicator : Label
var content_container : Control  # Will hold either VBox or HBox depending on layout
var media_display : Control  # Can be TextureRect or VideoStreamPlayer
var audio_player : AudioStreamPlayer = null

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
		"title": "Movimento e Dicas",
		"content": "Mova o personagem para cima ou para baixo usando as setas CIMA/BAIXO.\n\nVocê pode pular várias pistas se a mudança de acorde saltar graus.\n\nUse o primeiro acorde (tônica) como sua referência de altura.\n\nPense em graus relativos: se você ouvir uma mudança de I para V, mova da pista 1 para a pista 5.\n\nHá apenas uma pista correta para cada acorde em cada momento.",
		"media": "res://assets/updownkeys.png",
		"media_type": "image",
		"layout": "horizontal"
	}
]

func _ready():
	# Create and start audio player for background music
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = preload("res://assets/songs/theme.wav")
	audio_player.autoplay = true
	audio_player.volume_db = 0
	add_child(audio_player)
	audio_player.play()
	
	create_ui_elements()
	button.pressed.connect(_on_button_pressed)
	
func _input(event):
	if event.is_action_pressed("confirm"):
		_on_button_pressed()

func _on_button_pressed():
	current_page += 1
	
	if current_page < tutorial_pages.size():
		# Recreate UI for new page (since layout may change)
		for child in get_children():
			# Don't remove the audio player
			if child != audio_player:
				child.queue_free()
		create_ui_elements()
	else:
		# Tutorial finished, stop audio and go to pre-scale dialog
		if audio_player:
			audio_player.stop()
		get_tree().change_scene_to_file("res://scenes/pre_scale_dialog.tscn")

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
		button.text = "Próximo"
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
