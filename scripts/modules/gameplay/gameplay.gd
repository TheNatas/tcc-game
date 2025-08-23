extends Node2D

var TIME_TO_WAIT_FOR_PLAYER_REACTION = 5.0 if Globals.current_level == 0 else 3.0 if Globals.current_level == 1 else 2.0
const MAX_NUMBER_OF_NOTES_SWITCHES_PER_LEVEL = 2
const MIN_RIGHT_NOTES_PERCENT_TO_ADVANCE = 70

var player_current_degree := Globals.STARTING_DEGREE

@onready var dialog_box = $Feedback
@onready var game_world = $GameWorld
@onready var sound = $sound
@onready var levels_data = preload("res://scripts/modules/levels/levels.gd").new()

func _ready():
	print("current level: ", Globals.current_level)
	start_next_level()

func start_next_level():
	Levels.notes_switches_on_current_level = 0
	Levels.right_notes_on_current_level = 0

func highlight_degree(degree_index: int, color_to_paint: Color) -> void:
	var degree_color_node = get_tree().get_first_node_in_group("degree" + str(degree_index) + "/ColorRect")
	degree_color_node.color = color_to_paint
	await get_tree().create_timer(3).timeout
	degree_color_node.color = Color(1, 1, 1, 0.196)
	
func finish_level() -> void:
	var right_notes_percent = (float(Levels.right_notes_on_current_level) / MAX_NUMBER_OF_NOTES_SWITCHES_PER_LEVEL) * 100
	print("right_notes_percent: ", right_notes_percent)
	await get_tree().create_timer(2.0).timeout
	game_world.visible = false
	sound.playing = false
	if (right_notes_percent >= MIN_RIGHT_NOTES_PERCENT_TO_ADVANCE):
		Globals.current_level += 1
		if Globals.current_level >= levels_data.levels.size():
			get_tree().change_scene_to_file("res://scenes/game_finished.tscn")
			return
		else:
			get_tree().change_scene_to_file("res://scenes/context.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/failed_level.tscn")
	
	var level = levels_data.levels[Globals.current_level]
	dialog_box.start_dialog(level["dialog"])

func _on_sound_playing_degree_changed(current_playing_degree: int) -> void:
	Levels.notes_switches_on_current_level += 1
	if Levels.notes_switches_on_current_level == MAX_NUMBER_OF_NOTES_SWITCHES_PER_LEVEL:
		await get_tree().create_timer(TIME_TO_WAIT_FOR_PLAYER_REACTION).timeout
		finish_level()
		return
	await get_tree().create_timer(TIME_TO_WAIT_FOR_PLAYER_REACTION).timeout
	var player = get_tree().get_first_node_in_group("player")
	player_current_degree = player.current_degree
	var text_balloon = player.get_node("TextBalloon")
	text_balloon.visible = true
	var label = text_balloon.get_node("Label")
	if current_playing_degree == player_current_degree:
		Levels.right_notes_on_current_level += 1
		#label.text = "Bom trabalho!"
	else:
		#label.text = "Grau errado, chefe"
		highlight_degree(player_current_degree, Color(1,0,0))
		highlight_degree(current_playing_degree, Color(0,1,0))
	await get_tree().create_timer(3).timeout
	text_balloon.visible = false
