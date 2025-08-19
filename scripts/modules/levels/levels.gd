extends Node

# List of level configurations
var levels := [
	{
		"dialog": [
			"Bem-vindo ao jogo!",
			"Neste nível, identifique corretamente o grau musical.",
			"Prepare-se!"
		],
	},
	{
		"dialog": [
			"Muito bem no nível anterior!",
			"Agora os graus ficarão mais difíceis.",
			"Boa sorte!"
		],
	},
	{
		"dialog": [
			"Último desafio!",
			"Acerte o máximo que conseguir.",
			"Você consegue!"
		],
	}
]

var levels_textures = [
	'res://assets/ChatGPT Image 4 de ago. de 2025, 19_27_56.png',
	'res://assets/ChatGPT Image 4 de ago. de 2025, 19_34_58.png',
	'res://assets/ChatGPT Image 4 de ago. de 2025, 19_45_58.png'
]

var notes_switches_on_current_level = 0
var right_notes_on_current_level = 0
