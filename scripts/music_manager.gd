extends Node

var music_player: AudioStreamPlayer = null

func _ready() -> void:
	# Create the music player
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	# Load the theme music
	var theme_music = load("res://assets/songs/theme.wav")
	music_player.stream = theme_music
	
	# Connect the finished signal to loop the music
	music_player.connect("finished", Callable(self, "_on_music_finished"))


func play_menu_music() -> void:
	if music_player and not music_player.playing:
		music_player.play()


func stop_menu_music() -> void:
	if music_player and music_player.playing:
		music_player.stop()


func _on_music_finished() -> void:
	# Restart the music when it finishes to create a loop
	if music_player:
		music_player.play()
