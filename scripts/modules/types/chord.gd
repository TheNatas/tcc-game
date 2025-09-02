class_name Chord

var chord: int
var duration: int

func _init(_chord: int, _duration: int):
	chord = _chord
	duration = _duration

func str() -> String:
	return JSON.stringify({
		"chord": chord,
		"duration": duration,
	})
