extends Node2D

const STARTING_DEGREE = 3

var current_level = 0

var SONGS : Array[Song] = [
	# Beginner: slow, simple chords
	Song.new(0, [
		Chord.new("C", 8),
		Chord.new("G", 8),
		Chord.new("Am", 8),
		Chord.new("F", 8),
		Chord.new("C", 8),
		Chord.new("F", 8),
		Chord.new("G", 8),
		Chord.new("C", 8)
	]), # Total: 72s
	
	# Intermediate: faster changes, more chords
	Song.new(1, [
		Chord.new("Dm", 6),
		Chord.new("G", 6),
		Chord.new("C", 6),
		Chord.new("Am", 6),
		Chord.new("F", 6),
		Chord.new("G", 6),
		Chord.new("Em", 6),
		Chord.new("Am", 6),
		Chord.new("Dm", 6),
		Chord.new("G", 6),
		Chord.new("C", 6),
		Chord.new("C", 6),
		Chord.new("F", 6),
		Chord.new("G", 6),
		Chord.new("C", 6),
	]), # Total: 90s

	# Advanced: more variety, faster tempo
	Song.new(2, [
		Chord.new("Am", 4),
		Chord.new("F", 4),
		Chord.new("C", 4),
		Chord.new("G", 4),
		Chord.new("Em", 4),
		Chord.new("Am", 4),
		Chord.new("F", 4),
		Chord.new("C", 4),
		Chord.new("G", 4),
		Chord.new("Dm", 4),
		Chord.new("G", 4),
		Chord.new("C", 4),
		Chord.new("Am", 4),
		Chord.new("F", 4),
		Chord.new("C", 4),
		Chord.new("G", 4),
		Chord.new("Em", 4),
		Chord.new("Am", 4),
		Chord.new("F", 4),
		Chord.new("C", 4),
		Chord.new("G", 4),
		Chord.new("C", 4),
		Chord.new("F", 4),
		Chord.new("G", 4),
		Chord.new("C", 4),
	]), # Total: 100s
]
