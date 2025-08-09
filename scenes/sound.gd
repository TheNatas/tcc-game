extends AudioStreamPlayer2D

@onready var gameplay_scene = get_tree().get_first_node_in_group("gameplay_scene")

signal playing_degree_changed(current_playing_degree: int)

const chords = ['C', 'Dm', 'Em', 'F', 'G', 'Am', 'Bm7']
const SOUNDS = {
	"C": preload("res://assets/C.wav"),
	"Dm": preload("res://assets/Dm.wav"),
	"Em": preload("res://assets/Em.wav"),
	"F": preload("res://assets/F.wav"),
	"G": preload("res://assets/G.wav"),
	"Am": preload("res://assets/Am.wav"),
	"Bm7": preload("res://assets/Bm7.wav"),
}
const SONGS = [
	{
		"level": 0, # Beginner: slow, simple chords
		"chords": [
			{ "chord": "C",  "duration": 8 },
			{ "chord": "G",  "duration": 8 },
			{ "chord": "Am", "duration": 8 },
			{ "chord": "F",  "duration": 8 },
			{ "chord": "C",  "duration": 8 },
			{ "chord": "F",  "duration": 8 },
			{ "chord": "C",  "duration": 8 },
			{ "chord": "G",  "duration": 8 },
			{ "chord": "C",  "duration": 8 }
		] # Total: 72s
	},
	{
		"level": 1, # Intermediate: faster changes, more chords
		"chords": [
			{ "chord": "Dm", "duration": 6 },
			{ "chord": "G",  "duration": 6 },
			{ "chord": "C",  "duration": 6 },
			{ "chord": "Am", "duration": 6 },
			{ "chord": "F",  "duration": 6 },
			{ "chord": "G",  "duration": 6 },
			{ "chord": "Em", "duration": 6 },
			{ "chord": "Am", "duration": 6 },
			{ "chord": "Dm", "duration": 6 },
			{ "chord": "G",  "duration": 6 },
			{ "chord": "C",  "duration": 6 },
			{ "chord": "C",  "duration": 6 },
			{ "chord": "F",  "duration": 6 },
			{ "chord": "G",  "duration": 6 },
			{ "chord": "C",  "duration": 6 }
		] # Total: 90s
	},
	{
		"level": 2, # Advanced: more variety, faster tempo
		"chords": [
			{ "chord": "Am", "duration": 4 },
			{ "chord": "F",  "duration": 4 },
			{ "chord": "C",  "duration": 4 },
			{ "chord": "G",  "duration": 4 },
			{ "chord": "Em", "duration": 4 },
			{ "chord": "Am", "duration": 4 },
			{ "chord": "F",  "duration": 4 },
			{ "chord": "C",  "duration": 4 },
			{ "chord": "G",  "duration": 4 },
			{ "chord": "Dm", "duration": 4 },
			{ "chord": "G",  "duration": 4 },
			{ "chord": "C",  "duration": 4 },
			{ "chord": "Am", "duration": 4 },
			{ "chord": "F",  "duration": 4 },
			{ "chord": "C",  "duration": 4 },
			{ "chord": "G",  "duration": 4 },
			{ "chord": "Em", "duration": 4 },
			{ "chord": "Am", "duration": 4 },
			{ "chord": "F",  "duration": 4 },
			{ "chord": "C",  "duration": 4 },
			{ "chord": "G",  "duration": 4 },
			{ "chord": "C",  "duration": 4 },
			{ "chord": "F",  "duration": 4 },
			{ "chord": "G",  "duration": 4 },
			{ "chord": "C",  "duration": 4 }
		] # Total: 100s
	}
]

const STARTING_DEGREE = 3
const NOTES_SWITCH_COOLDOWN = 5
var time_since_last_play = 0.0  # Time accumulator
var current_playing_degree = STARTING_DEGREE

func _ready():
	connect("playing_degree_changed", Callable(gameplay_scene, &"_on_sound_playing_degree_changed"))
	
	#future implementation: randomize songs filtering by current level
	#var rng = RandomNumberGenerator.new()
	#var song_index = rng.randi_range(0, SONGS.size())
	start_song(0)
	
func start_song(song_index: int):
	play_chord(SONGS[song_index].chords[0])
	
func play_chord(chord_index: int):
	var chord = chords[chord_index]
	
	if SOUNDS.has(chord):
		stream = SOUNDS[chord]
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
			play_chord(current_playing_degree)
			
	


func _on_finished() -> void:
	play()
