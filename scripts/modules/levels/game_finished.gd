extends Control

var dialog_lines : Array[DialogLine] = [
	DialogLine.new("Conseguimos! Finalmente!", "Secretário"),
	DialogLine.new("É o fim da linha, senhor bandido. Pegamos você.", "Secretário"),
	DialogLine.new("Mas que droga! Essa joça não deveria ser indetectável?", "Criminoso"),
	DialogLine.new("Talvez para nós... mas certamente não para o detetive Sonora.", "Secretário"),
	DialogLine.new("Foi um exímio trabalho, detetive. Não conseguiríamos sem você.", "Secretário"),
	DialogLine.new("Evidentemente...", "Detetive Sonora"),
	DialogLine.new("Então... isso quita as minhas dívidas com vocês?", "Detetive Sonora"),
	DialogLine.new("Com certeza. Considere-se um homem livre agora.", "Secretário"),
	DialogLine.new("Perfeito.", "Detetive Sonora"),
	DialogLine.new("Sendo assim, nos veremos em... Bom, eu sinceramente não gostaria de revê-lo, na verdade.", "Detetive Sonora"),
	DialogLine.new("*hmphf* Isso é compreensível.", "Secretário"),
	DialogLine.new("Bom descanso, detetive.", "Secretário"),
	DialogLine.new("Obrigado. E bom trabalho para você.", "Detetive Sonora"),
	DialogLine.new("Ei, você ainda vai pagar por isso, detetive!", "Criminoso"),
	DialogLine.new("Cobre de outro, amigão. Estou de férias agora.", "Detetive Sonora"),
]

var extra_dialog_lines : Array[DialogLine] = [
	DialogLine.new("*trtrtrtrtrtrim*", ""),
	DialogLine.new("E aí? Quando que cê vai me tirar daqui?", "Criminoso"),
	DialogLine.new("Em breve. Preciso resolver umas coisas primeiro.", "Detetive Sonora"),
	DialogLine.new("Resolver? A única coisa que você precisa resolver é a minha saída daqui!", "Criminoso"),
	DialogLine.new("Silêncio! Você esqueceu quem está no comando aqui? Já não basta eu ter que te caçar por causa dos seus descuidos?", "Detetive Sonora"),
	DialogLine.new("*hmphf* Eu fiz o que podia, mas eles perceberam...", "Criminoso"),
	DialogLine.new("Eu sei. De qualquer forma, você foi pago. Sua família já recebeu o dinheiro.", "Detetive Sonora"),
	DialogLine.new("Receberam? ...Certo. Obrigado, senhor Sonora", "Criminoso"),
	DialogLine.new("Por nada. Mas ainda precisarei de você. Em breve.", "Detetive Sonora"),
	DialogLine.new("Ce-certo... Aguardarei pelo senhor então", "Criminoso"),
	
	DialogLine.new("...", "Detetive Sonora"),
	DialogLine.new("Bom... hora de voltar ao trabalho.", "Detetive Sonora"),
]

var current_line = 0

# UI elements
var label : Label
var button : Button

func _ready():
	create_ui_elements()
	button.pressed.connect(_on_button_pressed)
	
func _input(event):
	if event.is_action_pressed("ui_accept"): # "ui_accept" is Enter/Space by default
		_on_button_pressed()

func _on_button_pressed():
	current_line += 1
	if current_line < dialog_lines.size():
		var line_obj = dialog_lines[current_line]
		label.text = line_obj.speaker + ": " + line_obj.line if !line_obj.speaker.is_empty() else line_obj.line
	else:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

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

	# === 3. Dialog Label ===
	label = Label.new()
	var line_obj = dialog_lines[current_line]
	label.text = line_obj.speaker + ": " + line_obj.line if !line_obj.speaker.is_empty() else line_obj.line
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.custom_minimum_size = Vector2(0, 80)
	vbox.add_child(label)

	# === 4. Continue Button ===
	button = Button.new()
	button.text = "Continuar"
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.custom_minimum_size = Vector2(150, 40)
	button.pressed.connect(_on_button_pressed)
	vbox.add_child(button)
