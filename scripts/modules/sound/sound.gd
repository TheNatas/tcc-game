extends AudioStreamPlayer

@onready var gameplay_scene = get_tree().get_first_node_in_group("gameplay_scene")

signal playing_degree_changed(current_playing_degree: int)
signal song_finished()

const SOUNDS = {
	"piano": {
		"C": preload("res://assets/piano/C.wav"),
		"Dm": preload("res://assets/piano/Dm.wav"),
		"Em": preload("res://assets/piano/Em.wav"),
		"F": preload("res://assets/piano/F.wav"),
		"G": preload("res://assets/piano/G.wav"),
		"Am": preload("res://assets/piano/Am.wav"),
		"Bm": preload("res://assets/piano/Bm.wav"),
	},
	"guitar": {
		"G": preload("res://assets/guitar/G.wav"),
		"Am": preload("res://assets/guitar/Am.wav"),
		"Bm": preload("res://assets/guitar/Bm.wav"),
		"C": preload("res://assets/guitar/C.wav"),
		"D": preload("res://assets/guitar/D.wav"),
		"Em": preload("res://assets/guitar/Em.wav"),
		"F#m": preload("res://assets/guitar/F#m.wav"),
	},
	"eletric_guitar": {
		"D": preload("res://assets/eguitar/D.wav"),
		"Em": preload("res://assets/eguitar/Em.wav"),
		"F#m": preload("res://assets/eguitar/F#m.wav"),
		"G": preload("res://assets/eguitar/G.wav"),
		"A": preload("res://assets/eguitar/A.wav"),
		"Bm": preload("res://assets/eguitar/Bm.wav"),
		"C#m": preload("res://assets/eguitar/C#m.wav"),
	}
}
const tone_mapper = {
	"C": {
		1: "C",
		2: "Dm",
		3: "Em",
		4: "F",
		5: "G",
		6: "Am",
		7: "Bm",
	},
	"G": {
		1: "G",
		2: "Am",
		3: "Bm",
		4: "C",
		5: "D",
		6: "Em",
		7: "F#m",
	},
	"D": {
		1: "D",
		2: "Em",
		3: "F#m",
		4: "G",
		5: "A",
		6: "Bm",
		7: "C#m",
	},
}

const STARTING_DEGREE = 0
const NOTES_SWITCH_COOLDOWN = 5
var time_since_last_play = 0.0  # Time accumulator
#var current_playing_degree = STARTING_DEGREE

var current_chord # in the format: { "chord": int, "duration": int }
var current_chord_playing_for = 0 # how much the current_chord is been played for
var current_song : Song
var current_chord_index_in_the_song = 0

func _ready():
	connect("playing_degree_changed", Callable(gameplay_scene, &"_on_sound_playing_degree_changed"))
	
	#future implementation: randomize songs filtering by current level
	#var rng = RandomNumberGenerator.new()
	#var song_index = rng.randi_range(0, SONGS.size())
	#var current_song = Globals.SONGS[Globals.current_level]
	var songs_of_current_level = Globals.SONGS.filter(func(s): return s.level == Globals.current_level)
	var selected_song = songs_of_current_level.pick_random()
	start_song(selected_song)
	
func start_song(song: Song):
	var first_chord = song.chords[0];
	current_song = song
	play_chord(first_chord)
	current_chord_index_in_the_song = 0;
	
func play_chord(chord_obj: Chord):
	var chord_index = chord_obj.chord - 1 # chord_obj.chord is 1 indexed
	
	current_chord = chord_obj
	current_chord_playing_for = 0
	
	if SOUNDS.has(current_song.instrument) && SOUNDS[current_song.instrument].has(tone_mapper[current_song.tone][chord_obj.chord]):
		stream = SOUNDS[current_song.instrument][tone_mapper[current_song.tone][chord_obj.chord]]
		print("playing chord: ", chord_obj.str())
		play()
		emit_signal("playing_degree_changed", chord_index)
	else:
		print("Sound not found: ", chord_obj.chord)
		
func get_next_chord_in_song(song: Song, current_chord_index_in_song: int):
	var next_chord = song.chords[current_chord_index_in_song + 1]
	return next_chord;
	
func update_chord_in_song():
	# Check if we've reached the end of the song
	if current_chord_index_in_the_song >= current_song.chords.size() - 1:
		emit_signal("song_finished")
		return
	
	var next_chord = get_next_chord_in_song(current_song, current_chord_index_in_the_song)
	play_chord(next_chord)
	current_chord_index_in_the_song += 1
	
func _process(delta):
	time_since_last_play += delta
	if time_since_last_play >= current_chord.duration:
		time_since_last_play = 0.0  # Reset timer
		update_chord_in_song()

func _on_finished() -> void:
	play()
