extends Control

@export var current_status = ""

var dialog_lines = {
	"positive": [
		"Boa!",
		"Isso aí!",
		"Continue assim!"
	],
	"negative": [
		"Acho que não era isso...",
		"Continue tentando!",
		"Na próxima vai dar certo!"
	]
}

# UI elements
var label : Label
var button : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_ui_elements()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_ui_elements():
	visible = false
	add_to_group("feedback")
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
	bg.z_index = -1
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
	vbox.anchor_top = 0.0
	vbox.anchor_bottom = 1.0
	vbox.set("theme_override_constants/separation", 20)
	add_child(vbox)

	# === 3. Dialog Label ===
	label = Label.new()
	label.custom_minimum_size = Vector2(300, 80)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.custom_minimum_size = Vector2(0, 80)
	vbox.add_child(label)

func _on_gameplay_feedback_status_changed(new_status: String):
	visible = true
	var rng = RandomNumberGenerator.new()
	var feedback_index = rng.randi_range(0, 2)
	var current_status_dialog_lines = dialog_lines.positive if new_status == "positive" else dialog_lines.negative
	label.text = current_status_dialog_lines[feedback_index]
	#print(current_status_dialog_lines)
	#print(label.text)
	await get_tree().create_timer(3).timeout
	visible = false
