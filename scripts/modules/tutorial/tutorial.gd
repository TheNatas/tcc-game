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
		"title": "Bem-vindo ao Sound Detective!",
		"content": "Uma música começa assim que o jogo inicia. Na tela, sete pistas verticais representam os sete graus da escala da tonalidade da música. Seu personagem deve ficar na pista que corresponde ao acorde que está tocando."
	},
	{
		"title": "Objetivo",
		"content": "Ajuste a posição do personagem para o grau da escala correto para cada acorde da música.\n\nO primeiro acorde é sempre a tônica (1), o 1º grau. O personagem sempre começa no grau 1 como referência."
	},
	{
		"title": "Como Funciona",
		"content": "1. Ouça: Enquanto a música toca, os acordes mudam ao longo do tempo.\n\n2. Identifique: Cada acorde corresponde a um grau da escala.\n\n3. Mova: Leve o personagem para cima ou para baixo até a pista que corresponde ao grau do acorde atual.\n\n4. Mantenha: Fique na pista correta até o acorde mudar novamente e então ajuste se necessário."
	},
	{
		"title": "Movimento e Dicas",
		"content": "Mova o personagem para cima ou para baixo usando as setas CIMA/BAIXO.\n\nVocê pode pular várias pistas se a mudança de acorde saltar graus.\n\nUse o primeiro acorde (tônica) como sua referência de altura.\n\nPense em graus relativos: se você ouvir uma mudança de I para V, mova da pista 1 para a pista 5.\n\nHá apenas uma pista correta para cada acorde em cada momento."
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
	page_indicator.text = "Página %d de %d - Pressione ENTER ou ESPAÇO para continuar" % [current_page + 1, tutorial_pages.size()]
	
	# Update button text on last page
	if current_page == tutorial_pages.size() - 1:
		button.text = "Iniciar Jogo"
	else:
		button.text = "Continuar"

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
	page_indicator.text = "Página %d de %d - Pressione ENTER ou ESPAÇO para continuar" % [current_page + 1, tutorial_pages.size()]
	page_indicator.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	page_indicator.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	page_indicator.add_theme_font_size_override("font_size", 14)
	vbox.add_child(page_indicator)

	# === 8. Continue Button ===
	button = Button.new()
	button.text = "Continuar"
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.custom_minimum_size = Vector2(150, 40)
	button.pressed.connect(_on_button_pressed)
	vbox.add_child(button)
