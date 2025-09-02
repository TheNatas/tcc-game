class_name Song

var level: int
var chords: Array[Chord]
var tone: String
var instrument: String

func _init(_level: int, _tone: String, _instrument: String, _chords: Array[Chord]):
	level = _level
	tone = _tone
	instrument = _instrument
	chords = _chords

func str() -> String:
	return JSON.stringify({
		"level": level,
		"tone": tone,
		"instrument": instrument,
		"chords": chords
	})
