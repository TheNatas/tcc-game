class_name DialogLine

var line: String
var speaker: String

func _init(_line: String, _speaker: String):
	line = _line
	speaker = _speaker

func str() -> String:
	return JSON.stringify({
		"line": line,
		"speaker": speaker
	})
