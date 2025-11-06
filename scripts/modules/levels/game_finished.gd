extends Control

const DETETIVE_SONORA_MINIATURE = "res://assets/dialog miniatures/dialog_detetive_sonora.png"
const MINISTRA_ARMAS_MINIATURE = "res://assets/dialog miniatures/dialog_ministra_armas.png"
const CRIMINOSO_MINIATURE = "res://assets/dialog miniatures/dialog_criminoso.png"

var dialog_lines : Array[DialogLine] = [
	DialogLine.new("Conseguimos! Finalmente!", "Ministra de Armas", "res://assets/voice overs/voice overs full - Conseguimos! Finalmente.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("É o fim da linha pra você, amigão. Te pegamos.", "Ministra de Armas", "res://assets/voice overs/voice overs full - É o fim da linha pra você, amigão! Te pegamos.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Mas que droga! Essa joça não devia ser indetectável?", "Criminoso", "res://assets/voice overs/voice overs full - mas que droga! essa joça não devia ser indetectável_.wav", CRIMINOSO_MINIATURE),
	DialogLine.new("Talvez para nós... mas certamente não para o detetive Sonora.", "Ministra de Armas", "res://assets/voice overs/voice overs full - Talvez para nós. Mas certamente não para o detetive sonora.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Foi um exímio trabalho, detetive.", "Ministra de Armas", "res://assets/voice overs/Foi-um-exímio-trabalho_-detetive.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Não conseguiríamos sem o senhor.", "Ministra de Armas", "res://assets/voice overs/voice overs full - Não conseguiríamos sem o senhor.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Evidentemente...", "Detetive Sonora", "res://assets/voice overs/voice overs full - Evidentemente(2).wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Bom, então... Acredito que isso quita as minhas dívidas com vocês.", "Detetive Sonora", "res://assets/voice overs/Acredito-que-isso-quita-minhas-dívidas-com-vocês.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Com certeza. Considere-se um homem livre agora.", "Ministra de Armas", "res://assets/voice overs/voice overs full - Com certeza. Considere-se um homem livre agora.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Perfeito.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Perfeito.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Bom, sendo assim, nos veremos em... Bom, sinceramente eu não pretendo revê-la.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Bom, sendo assim, nos veremos em... bom, eu nao pretendo revela.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("*hmphf* Isso é compreensível.", "Ministra de Armas", "res://assets/voice overs/voice overs full - Hmpfh! Isso é compreensível.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Bom descanso, detetive.", "Ministra de Armas", "res://assets/voice overs/voice overs full - Bom descanso, detetive.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Agradeço.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Agradeço.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Ei, você ainda vai pagar por isso, detetive!", "Criminoso", "res://assets/voice overs/voice overs full - ei! você ainda vai pagar por isso, detetive!.wav", CRIMINOSO_MINIATURE),
	DialogLine.new("Somente a ministra de Armas pode me chamar de \"você\", \"amigão\".", "Detetive Sonora", "res://assets/voice overs/voice overs full - Somente a ministra de armas pode.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Finalmente…", "Ministra de Armas", "res://assets/voice overs/voice overs full - Ah... Finalmente.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("E cobre de outro. Eu vou entrar em férias agora.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Cobre de outro, eu vou entrar em ferias agoa.wav", DETETIVE_SONORA_MINIATURE),
]

var extra_dialog_lines : Array[DialogLine] = [
	DialogLine.new("*trtrtrtrtrtrim*", "", "res://assets/sfx/Efeito Sonoro Grátis_ Telefone Antigo.mp3"),
	DialogLine.new("E aí? Quando que cê vai me tirar daqui?", "Criminoso", "", CRIMINOSO_MINIATURE),
	DialogLine.new("Em breve. Preciso resolver umas coisas primeiro.", "Detetive Sonora", "", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Resolver? A única coisa que você precisa resolver é a minha saída daqui!", "Criminoso", "", CRIMINOSO_MINIATURE),
	DialogLine.new("Silêncio! Você esqueceu quem está no comando aqui? Já não basta eu ter que te caçar por causa dos seus descuidos?", "Detetive Sonora", "", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("*hmphf* Eu fiz o que podia, mas eles perceberam...", "Criminoso", "", CRIMINOSO_MINIATURE),
	DialogLine.new("Eu sei. De qualquer forma, você foi pago. Sua família já recebeu o dinheiro.", "Detetive Sonora", "", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Receberam? ...Certo. Obrigado, senhor Sonora", "Criminoso", "", CRIMINOSO_MINIATURE),
	DialogLine.new("Por nada. Mas ainda precisarei de você. Em breve.", "Detetive Sonora", "", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Ce-certo... Aguardarei pelo senhor então", "Criminoso", "", CRIMINOSO_MINIATURE),
	
	DialogLine.new("...", "Detetive Sonora", "", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Bom... hora de voltar ao trabalho.", "Detetive Sonora", "", DETETIVE_SONORA_MINIATURE),
]

var current_line = 0

# UI elements
var label : Label
var button : Button
var miniature_texture_rect : TextureRect  # For character portrait

# Audio player for voice-over
var audio_player : AudioStreamPlayer

func _ready():
	create_ui_elements()
	button.pressed.connect(_on_button_pressed)
	
	# Create audio player for voice-over
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	
	# Play voice-over for the first line if available
	play_voice_over(dialog_lines[current_line])
	
func _input(event):
	if event.is_action_pressed("confirm"):
		_on_button_pressed()

func _on_button_pressed():
	# Stop any currently playing voice-over
	if audio_player.playing:
		audio_player.stop()
	
	current_line += 1
	if current_line < dialog_lines.size():
		var line_obj = dialog_lines[current_line]
		label.text = line_obj.speaker + ": " + line_obj.line if !line_obj.speaker.is_empty() else line_obj.line
		# Update miniature image
		update_miniature(line_obj)
		# Play voice-over if available
		play_voice_over(line_obj)
	else:
		get_tree().change_scene_to_file("res://scenes/credits.tscn")

func update_miniature(line_obj: DialogLine):
	if line_obj.has_miniature():
		var texture = load(line_obj.miniature_image_path)
		if texture:
			miniature_texture_rect.texture = texture
			miniature_texture_rect.visible = true
	else:
		miniature_texture_rect.visible = false

func play_voice_over(line_obj: DialogLine):
	if line_obj.has_voice_over():
		var audio_stream = load(line_obj.voice_over_path)
		if audio_stream:
			audio_player.stream = audio_stream
			audio_player.play()

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

	# === 2. VBox at the Bottom ===
	var vbox = VBoxContainer.new()
	vbox.anchor_left = 0.0
	vbox.anchor_right = 1.0
	vbox.anchor_top = 1.0
	vbox.anchor_bottom = 1.0
	vbox.offset_left = 40
	vbox.offset_right = -40
	vbox.offset_top = -180
	vbox.offset_bottom = -20
	vbox.set("theme_override_constants/separation", 20)
	add_child(vbox)

	# === 2.5. HBox for Miniature and Dialog ===
	var hbox = HBoxContainer.new()
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	hbox.set("theme_override_constants/separation", 15)
	vbox.add_child(hbox)

	# === 2.6. Miniature Image ===
	miniature_texture_rect = TextureRect.new()
	miniature_texture_rect.custom_minimum_size = Vector2(80, 80)
	miniature_texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	miniature_texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	miniature_texture_rect.visible = false  # Hidden by default
	var line_obj = dialog_lines[current_line]
	if line_obj.has_miniature():
		var texture = load(line_obj.miniature_image_path)
		if texture:
			miniature_texture_rect.texture = texture
			miniature_texture_rect.visible = true
	hbox.add_child(miniature_texture_rect)

	# === 3. Dialog Label ===
	label = Label.new()
	label.text = line_obj.speaker + ": " + line_obj.line if !line_obj.speaker.is_empty() else line_obj.line
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.custom_minimum_size = Vector2(0, 80)
	hbox.add_child(label)

	# === 4. Continue Button ===
	button = Button.new()
	button.text = "Continuar"
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.custom_minimum_size = Vector2(150, 40)
	button.pressed.connect(_on_button_pressed)
	vbox.add_child(button)
