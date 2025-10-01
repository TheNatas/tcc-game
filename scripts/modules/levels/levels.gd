extends Node

const number_of_levels = 3

var first_level_dialogs : Array[DialogLine] = [
	#DialogLine.new("O ano é 2035.", "unknown"),
	#DialogLine.new("Como era de se esperar, as coisas não melhoraram.", "unknown"),
	#DialogLine.new("Pelo contrário: pioraram.", "unknown"),
	#DialogLine.new("As máquinas ficaram mais inteligentes, sim.", "unknown"),
	#DialogLine.new("Porém os humanos... *hmphf*", "unknown"),
	#DialogLine.new("E o crime apenas aumentou, evidentemente.", "unknown"),
	#DialogLine.new("Agora mesmo, recebi uma missão que apenas eu posso cumprir.", "unknown"),
	#DialogLine.new("Um criminoso internacional furtou uma aeronave militar indetectável para os meios tradicionais.", "unknown"),
	#DialogLine.new("*hmphf* Ainda bem que eu não sou nada tradicional...", "unknown"),
	
	DialogLine.new("*trtrtrtrtrtrim*", ""),
	DialogLine.new("Quem fala?", "unknown"),
	DialogLine.new("Detetive Sonora? Estou ligando para atualizá-lo sobre a sua missão. Aquela acerca do furto de uma aeronave militar indetectável.", "Secretário"),
	DialogLine.new("Indetectável para vocês...", "Detetive Sonora"),
	DialogLine.new("Certo... nós confirmamos o que o senhor disse. A nave roubada realmente deixa rastros sonoros, o senhor estava certo.", "Secretário"),
	DialogLine.new("Evidentemente...", "Detetive Sonora"),
	DialogLine.new("E quanto aos equipamentos que pedi?", "Detetive Sonora"),
	DialogLine.new("Conseguimos eles todos, senhor: um avião silencioso, um headphone muito alto e um charuto cubano.", "Secretário"),
	DialogLine.new("O último era realmente necessário, senhor?", "Secretário"),
	DialogLine.new("Não me questione, secretário.", "Detetive Sonora"),
	DialogLine.new("Sim, senhor.", "Secretário"),
	DialogLine.new("É... O senhor tem certeza que irá rastreá-lo? Os sons parecem indecifráveis para nós!", "Secretário"),
	DialogLine.new("Não se preocupe com isso... É como música para meus ouvidos.", "Detetive Sonora"),
	DialogLine.new("Certo, então... O senhor é a única pessoa capaz de fazer isso.", "Secretário"),
	DialogLine.new("Estamos todos contando com você, senhor!", "Secretário")
]

var second_level_dialogs : Array[DialogLine] = [
	#DialogLine.new("É um sentimento estranho continuar nessas missões...", "unknown"),
	#DialogLine.new("Como era de se esperar, as coisas não melhoraram.", "unknown"),
	#DialogLine.new("Pelo contrário, pioraram.", "unknown"),
	#DialogLine.new("As máquinas ficaram mais inteligentes, sim.", "unknown"),
	#DialogLine.new("Porém os humanos... *hmphf*", "unknown"),
	#DialogLine.new("E o crime apenas aumentou, evidentemente.", "unknown"),
	#DialogLine.new("Agora mesmo, recebi uma missão que apenas eu posso cumprir.", "unknown"),
	#DialogLine.new("Um criminoso internacional furtou uma aeronave militar indetectável para os meios tradicionais.", "unknown"),
	#DialogLine.new("*hmphf* Ainda bem que eu não sou nada tradicional...", "unknown"),
	
	DialogLine.new("*trtrtrtrtrtrim*", ""),
	DialogLine.new("Detetive? Incrível! O senhor conseguiu rastreá-lo!", "Secretário"),
	DialogLine.new("Aparentemente ele fez uma parada e por isso os sinais pararam.", "Secretário"),
	DialogLine.new("Mas ao que tudo indica... Ele continuará o trajeto durante a noite.", "Secretário"),
	DialogLine.new("Ainda precisaremos das suas habilidades, detetive!", "Secretário"),
	DialogLine.new("Por favor, continue reportando os seus movimentos para que nós possamos encontrá-lo. Se continuarmos assim, até amanhã poderemos pegá-lo!", "Secretário"),
	DialogLine.new("Nos vemos quando houver novidades, senhor!", "Secretário"),
]

var third_level_dialogs : Array[DialogLine] = [
	#DialogLine.new("O ano é 2035.", "unknown"),
	#DialogLine.new("Como era de se esperar, as coisas não melhoraram.", "unknown"),
	#DialogLine.new("Pelo contrário, pioraram.", "unknown"),
	#DialogLine.new("As máquinas ficaram mais inteligentes, sim.", "unknown"),
	#DialogLine.new("Porém os humanos... *hmphf*", "unknown"),
	#DialogLine.new("E o crime apenas aumentou, evidentemente.", "unknown"),
	#DialogLine.new("Agora mesmo, recebi uma missão que apenas eu posso cumprir.", "unknown"),
	#DialogLine.new("Um criminoso internacional furtou uma aeronave militar indetectável para os meios tradicionais.", "unknown"),
	#DialogLine.new("*hmphf* Ainda bem que eu não sou nada tradicional...", "unknown"),
	
	DialogLine.new("*trtrtrtrtrtrim*", ""),
	DialogLine.new("Bom trabalho, detetive!", "Secretário"),
	DialogLine.new("Fizemos um grande progresso graças aos seus esforços.", "Secretário"),
	DialogLine.new("Estamos quase lá! Nossos homens estão prontos para capturar o criminoso. Com a sua interpretação dos sinais, o alcançaremos hoje mesmo!", "Secretário"),
	DialogLine.new("Continue o bom trabalho, senhor! Nunca estivemos tão perto!", "Secretário")
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
