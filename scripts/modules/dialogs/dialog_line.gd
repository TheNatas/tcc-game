class_name DialogLine

var line: String
var speaker: String
var voice_over_path: String  # Optional path to voice-over audio file

func _init(_line: String, _speaker: String, _voice_over_path: String = ""):
	line = _line
	speaker = _speaker
	voice_over_path = _voice_over_path

func has_voice_over() -> bool:
	return !voice_over_path.is_empty()

func str() -> String:
	return JSON.stringify({
		"line": line,
		"speaker": speaker,
		"voice_over_path": voice_over_path
	})
