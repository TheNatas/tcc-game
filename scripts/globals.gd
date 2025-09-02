extends Node2D

const STARTING_DEGREE = 3

var current_level = 0

var SONGS : Array[Song] = [
	# ----------------
	# Beginner (level 0) – slow, simple chords
	# ----------------
	Song.new(0, "C", "piano", [
		Chord.new(1, 8),
		Chord.new(5, 8),
		Chord.new(6, 8),
		Chord.new(4, 8),
		Chord.new(1, 8),
		Chord.new(4, 8),
		Chord.new(5, 8),
		Chord.new(1, 8),
	]), # ~72s

	Song.new(0, "C", "piano", [
		Chord.new(1, 12),
		Chord.new(6, 12),
		Chord.new(4, 12),
		Chord.new(5, 12),
		Chord.new(1, 12),
	]), # ~60s

	Song.new(0, "C", "piano", [
		Chord.new(1, 10),
		Chord.new(4, 10),
		Chord.new(1, 10),
		Chord.new(5, 10),
		Chord.new(6, 10),
		Chord.new(4, 10),
		Chord.new(1, 10),
		Chord.new(5, 10),
		Chord.new(1, 10),
	]), # ~90s

	# ----------------
	# Intermediate (level 1) – faster changes, more chords
	# ----------------
	Song.new(1, "G", "guitar", [
		Chord.new(1, 6),
		Chord.new(2, 6),
		Chord.new(5, 6),
		Chord.new(1, 6),
		Chord.new(6, 6),
		Chord.new(4, 6),
		Chord.new(5, 6),
		Chord.new(3, 6),
		Chord.new(6, 6),
		Chord.new(2, 6),
		Chord.new(5, 6),
		Chord.new(1, 6),
		Chord.new(1, 6),
		Chord.new(4, 6),
		Chord.new(5, 6),
		Chord.new(1, 6),
	]), # ~96s

	Song.new(1, "G", "guitar", [
		Chord.new(1, 8),
		Chord.new(6, 8),
		Chord.new(4, 8),
		Chord.new(1, 8),
		Chord.new(5, 8),
		Chord.new(3, 8),
		Chord.new(4, 8),
		Chord.new(1, 8),
		Chord.new(5, 8),
		Chord.new(6, 8),
		Chord.new(4, 8),
		Chord.new(1, 8),
	]), # ~96s

	Song.new(1, "G", "guitar", [
		Chord.new(1, 5),
		Chord.new(6, 5),
		Chord.new(4, 5),
		Chord.new(5, 5),
		Chord.new(1, 5),
		Chord.new(4, 5),
		Chord.new(2, 5),
		Chord.new(5, 5),
		Chord.new(3, 5),
		Chord.new(6, 5),
		Chord.new(4, 5),
		Chord.new(5, 5),
		Chord.new(1, 5),
	]), # ~65s

	# ----------------
	# Advanced (level 2) – more variety, quicker tempo
	# ----------------
	Song.new(2, "D", "eletric_guitar", [
		Chord.new(1, 4),
		Chord.new(6, 4),
		Chord.new(4, 4),
		Chord.new(1, 4),
		Chord.new(5, 4),
		Chord.new(3, 4),
		Chord.new(6, 4),
		Chord.new(4, 4),
		Chord.new(1, 4),
		Chord.new(5, 4),
		Chord.new(2, 4),
		Chord.new(5, 4),
		Chord.new(1, 4),
		Chord.new(6, 4),
		Chord.new(4, 4),
		Chord.new(1, 4),
		Chord.new(5, 4),
		Chord.new(3, 4),
		Chord.new(6, 4),
		Chord.new(4, 4),
		Chord.new(1, 4),
		Chord.new(5, 4),
		Chord.new(1, 4),
		Chord.new(4, 4),
		Chord.new(5, 4),
		Chord.new(1, 4),
	]), # ~104s

	Song.new(2, "D", "eletric_guitar", [
		Chord.new(1, 6),
		Chord.new(3, 6),
		Chord.new(1, 6),
		Chord.new(5, 6),
		Chord.new(2, 6),
		Chord.new(6, 6),
		Chord.new(4, 6),
		Chord.new(1, 6),
		Chord.new(5, 6),
		Chord.new(3, 6),
		Chord.new(6, 6),
		Chord.new(4, 6),
		Chord.new(5, 6),
		Chord.new(1, 6),
	]), # ~84s

	Song.new(2, "D", "eletric_guitar", [
		Chord.new(1, 5),
		Chord.new(6, 5),
		Chord.new(1, 5),
		Chord.new(4, 5),
		Chord.new(5, 5),
		Chord.new(3, 5),
		Chord.new(6, 5),
		Chord.new(4, 5),
		Chord.new(1, 5),
		Chord.new(5, 5),
		Chord.new(2, 5),
		Chord.new(5, 5),
		Chord.new(1, 5),
		Chord.new(6, 5),
		Chord.new(4, 5),
		Chord.new(1, 5),
		Chord.new(5, 5),
		Chord.new(1, 5),
	]), # ~90s
]
