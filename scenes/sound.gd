extends AudioStreamPlayer2D

@onready var gameplay_scene = get_tree().get_first_node_in_group("gameplay_scene")

signal playing_degree_changed(current_playing_degree: int)

# MIDI notes you want to cycle through (e.g., C4, D4, E4, F4, G4, A4, B4)
const chords = ['C', 'Dm', 'Em', 'F', 'G', 'Am', 'Bm7']
const SOUND_EFFECTS = {
	"C": preload("res://assets/C.wav"),
	"Dm": preload("res://assets/Dm.wav"),
	"Em": preload("res://assets/Em.wav"),
	"F": preload("res://assets/F.wav"),
	"G": preload("res://assets/G.wav"),
	"Am": preload("res://assets/Am.wav"),
	"Bm7": preload("res://assets/Bm7.wav"),
}
const STARTING_DEGREE = 3
const NOTES_SWITCH_COOLDOWN = 5
var time_since_last_play = 0.0  # Time accumulator
var current_playing_degree = STARTING_DEGREE

func _ready():
	connect("playing_degree_changed", Callable(gameplay_scene, &"_on_sound_playing_degree_changed"))
	play_sound(STARTING_DEGREE)
	
func play_sound(chord_index: int):
	var chord = chords[chord_index]
	
	if SOUND_EFFECTS.has(chord):
		stream = SOUND_EFFECTS[chord]
		play()
		emit_signal("playing_degree_changed", chord_index)
	else:
		print("Sound not found: ", chord)
	
func _process(delta):
	time_since_last_play += delta
	if time_since_last_play >= NOTES_SWITCH_COOLDOWN:
		time_since_last_play = 0.0  # Reset timer
		if randi() % 2 == 0:
			current_playing_degree = randi() % 7
			play_sound(current_playing_degree)


func _on_finished() -> void:
	play()
