extends Node2D

const STARTING_DEGREE = 3

var current_level = 0

var SONGS : Array[Song] = [
	# ----------------
	# Beginner (level 0) – slow, simple chords
	# ----------------
	Song.new(0, [
		Chord.new("C", 8),
		Chord.new("G", 8),
		Chord.new("Am", 8),
		Chord.new("F", 8),
		Chord.new("C", 8),
		Chord.new("F", 8),
		Chord.new("G", 8),
		Chord.new("C", 8),
	]), # ~72s

	Song.new(0, [
		Chord.new("C", 12),
		Chord.new("Am", 12),
		Chord.new("F", 12),
		Chord.new("G", 12),
		Chord.new("C", 12),
	]), # ~60s

	Song.new(0, [
		Chord.new("C", 10),
		Chord.new("F", 10),
		Chord.new("C", 10),
		Chord.new("G", 10),
		Chord.new("Am", 10),
		Chord.new("F", 10),
		Chord.new("C", 10),
		Chord.new("G", 10),
		Chord.new("C", 10),
	]), # ~90s

	# ----------------
	# Intermediate (level 1) – faster changes, more chords
	# ----------------
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
	]), # ~90s

	Song.new(1, [
		Chord.new("Am", 8),
		Chord.new("F", 8),
		Chord.new("C", 8),
		Chord.new("G", 8),
		Chord.new("Em", 8),
		Chord.new("F", 8),
		Chord.new("C", 8),
		Chord.new("G", 8),
		Chord.new("Am", 8),
		Chord.new("F", 8),
		Chord.new("C", 8),
	]), # ~88s

	Song.new(1, [
		Chord.new("C", 5),
		Chord.new("Am", 5),
		Chord.new("F", 5),
		Chord.new("G", 5),
		Chord.new("C", 5),
		Chord.new("F", 5),
		Chord.new("Dm", 5),
		Chord.new("G", 5),
		Chord.new("Em", 5),
		Chord.new("Am", 5),
		Chord.new("F", 5),
		Chord.new("G", 5),
		Chord.new("C", 5),
	]), # ~65s

	# ----------------
	# Advanced (level 2) – more variety, quicker tempo
	# ----------------
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
	]), # ~100s

	Song.new(2, [
		Chord.new("Em", 6),
		Chord.new("C", 6),
		Chord.new("G", 6),
		Chord.new("D", 6),
		Chord.new("Am", 6),
		Chord.new("F", 6),
		Chord.new("C", 6),
		Chord.new("G", 6),
		Chord.new("Em", 6),
		Chord.new("Am", 6),
		Chord.new("F", 6),
		Chord.new("G", 6),
		Chord.new("C", 6),
	]), # ~78s

	Song.new(2, [
		Chord.new("Am", 5),
		Chord.new("C", 5),
		Chord.new("F", 5),
		Chord.new("G", 5),
		Chord.new("Em", 5),
		Chord.new("Am", 5),
		Chord.new("F", 5),
		Chord.new("C", 5),
		Chord.new("G", 5),
		Chord.new("Dm", 5),
		Chord.new("G", 5),
		Chord.new("C", 5),
		Chord.new("Am", 5),
		Chord.new("F", 5),
		Chord.new("C", 5),
		Chord.new("G", 5),
		Chord.new("C", 5),
	]), # ~85s
]
