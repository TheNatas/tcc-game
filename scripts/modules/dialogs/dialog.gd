# used for the Feedback node (not currently working, but the unhandled input logic could be reused in context.gd)
extends Control

signal dialog_finished

var dialog_lines = []
var current_line = 0

@onready var label = $Label

func start_dialog(lines: Array):
	dialog_lines = lines
	current_line = 0
	label.text = dialog_lines[current_line]
	show()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		current_line += 1
		if current_line >= dialog_lines.size():
			hide()
			emit_signal("dialog_finished")
		else:
			label.text = dialog_lines[current_line]
