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

const STARTING_DEGREE = 3
const NOTES_SWITCH_COOLDOWN = 5
var time_since_last_play = 0.0  # Time accumulator
var current_playing_degree = STARTING_DEGREE

var current_chord # in the format: { "chord": string, "duration": int }
var current_chord_playing_for = 0 # how much the current_chord is been played for
var current_song : Song
var current_chord_index_in_the_song = 0

func _ready():
	connect("playing_degree_changed", Callable(gameplay_scene, &"_on_sound_playing_degree_changed"))
	
	#future implementation: randomize songs filtering by current level
	#var rng = RandomNumberGenerator.new()
	#var song_index = rng.randi_range(0, SONGS.size())
	var current_song = Globals.SONGS[Globals.current_level]
	start_song(current_song)
	
func start_song(song: Song):
	var first_chord = song.chords[0];
	play_chord(first_chord)
	current_song = song
	current_chord_index_in_the_song = 0;
	
func play_chord(chord_obj: Chord):
	var chord_index = chords.find(chord_obj.chord)
	
	current_chord = chord_obj
	current_chord_playing_for = 0
	
	if SOUNDS.has(chord_obj.chord):
		stream = SOUNDS[chord_obj.chord]
		play()
		emit_signal("playing_degree_changed", chord_index)
	else:
		print("Sound not found: ", chord_obj.chord)
		
func get_next_chord_in_song(song: Song, current_chord_index_in_song: int):
	var next_chord = song.chords[current_chord_index_in_song + 1]
	return next_chord;
	
func _process(delta):
	time_since_last_play += delta
	if time_since_last_play >= current_chord.duration:
		time_since_last_play = 0.0  # Reset timer
		var next_chord = get_next_chord_in_song(current_song, current_chord_index_in_the_song)
		current_playing_degree = chords.find(next_chord.chord)
		play_chord(next_chord)

func _on_finished() -> void:
	play()
