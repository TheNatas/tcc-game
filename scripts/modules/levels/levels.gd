extends Node

const number_of_levels = 3
const TEST_VOICE_OVER = "res://assets/songs/theme.wav"  # Temporary test audio
const DETETIVE_SONORA_MINIATURE = "res://assets/dialog miniatures/dialog_detetive_sonora.png"
const MINISTRA_ARMAS_MINIATURE = "res://assets/dialog miniatures/dialog_ministra_armas.png"
const CRIMINOSO_MINIATURE = "res://assets/dialog miniatures/dialog_criminoso.png"

var first_level_dialogs : Array[DialogLine] = [
	#DialogLine.new("O ano é 2035.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Como era de se esperar, as coisas não melhoraram.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Pelo contrário: pioraram.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("As máquinas ficaram mais inteligentes, sim.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Porém os humanos... *hmphf*", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("E o crime apenas aumentou, evidentemente.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Agora mesmo, recebi uma missão que apenas eu posso cumprir.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Um criminoso internacional furtou uma aeronave militar indetectável para os meios tradicionais.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("*hmphf* Ainda bem que eu não sou nada tradicional...", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	
	DialogLine.new("*trtrtrtrtrtrim*", "", TEST_VOICE_OVER),
	DialogLine.new("Quem fala?", "Desconhecido", TEST_VOICE_OVER),
	DialogLine.new("Detetive Sonora? Estou ligando para atualizá-lo sobre a sua missão. Aquela acerca do furto de uma aeronave militar indetectável.", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Indetectável para vocês...", "Detetive Sonora", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Certo... nós confirmamos o que o senhor disse. A nave roubada realmente deixa rastros sonoros, o senhor estava certo.", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Evidentemente...", "Detetive Sonora", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	DialogLine.new("E quanto aos equipamentos que pedi?", "Detetive Sonora", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Conseguimos eles todos, senhor: um avião silencioso, um headphone muito alto e um charuto cubano.", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("O último era realmente necessário, senhor?", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Não me questione, secretário.", "Detetive Sonora", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Sim, senhor.", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("É... O senhor tem certeza que irá rastreá-lo? Os sons parecem indecifráveis para nós!", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Não se preocupe com isso... É como música para meus ouvidos.", "Detetive Sonora", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Certo, então... O senhor é a única pessoa capaz de fazer isso.", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Estamos todos contando com você, senhor!", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE)
]

var second_level_dialogs : Array[DialogLine] = [
	#DialogLine.new("É um sentimento estranho continuar nessas missões...", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Como era de se esperar, as coisas não melhoraram.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Pelo contrário, pioraram.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("As máquinas ficaram mais inteligentes, sim.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Porém os humanos... *hmphf*", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("E o crime apenas aumentou, evidentemente.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Agora mesmo, recebi uma missão que apenas eu posso cumprir.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Um criminoso internacional furtou uma aeronave militar indetectável para os meios tradicionais.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("*hmphf* Ainda bem que eu não sou nada tradicional...", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	
	DialogLine.new("*trtrtrtrtrtrim*", "", TEST_VOICE_OVER),
	DialogLine.new("Detetive? Incrível! O senhor conseguiu rastreá-lo!", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Aparentemente ele fez uma parada e por isso os sinais pararam.", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Mas ao que tudo indica... Ele continuará o trajeto durante a noite.", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Ainda precisaremos das suas habilidades, detetive!", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Por favor, continue reportando os seus movimentos para que nós possamos encontrá-lo. Se continuarmos assim, até amanhã poderemos pegá-lo!", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Nos vemos quando houver novidades, senhor!", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
]

var third_level_dialogs : Array[DialogLine] = [
	#DialogLine.new("O ano é 2035.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Como era de se esperar, as coisas não melhoraram.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Pelo contrário, pioraram.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("As máquinas ficaram mais inteligentes, sim.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Porém os humanos... *hmphf*", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("E o crime apenas aumentou, evidentemente.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Agora mesmo, recebi uma missão que apenas eu posso cumprir.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("Um criminoso internacional furtou uma aeronave militar indetectável para os meios tradicionais.", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	#DialogLine.new("*hmphf* Ainda bem que eu não sou nada tradicional...", "unknown", TEST_VOICE_OVER, DETETIVE_SONORA_MINIATURE),
	
	DialogLine.new("*trtrtrtrtrtrim*", "", TEST_VOICE_OVER),
	DialogLine.new("Bom trabalho, detetive!", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Fizemos um grande progresso graças aos seus esforços.", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Estamos quase lá! Nossos homens estão prontos para capturar o criminoso. Com a sua interpretação dos sinais, o alcançaremos hoje mesmo!", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Continue o bom trabalho, senhor! Nunca estivemos tão perto!", "Secretário", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE)
]

# List of level configurations
var levels = [
	 first_level_dialogs,
	second_level_dialogs,
	third_level_dialogs,
]

var levels_textures = [
	'res://assets/ChatGPT Image 4 de ago. de 2025, 19_27_56.png',
	'res://assets/ChatGPT Image 4 de ago. de 2025, 19_34_58.png',
	'res://assets/ChatGPT Image 4 de ago. de 2025, 19_45_58.png'
]

var notes_switches_on_current_level = 0
var right_notes_on_current_level = 0
