extends Node

const number_of_levels = 3
const TEST_VOICE_OVER = "res://assets/songs/theme.wav"  # Temporary test audio
const DETETIVE_SONORA_MINIATURE = "res://assets/dialog miniatures/dialog_detetive_sonora.png"
const MINISTRA_ARMAS_MINIATURE = "res://assets/dialog miniatures/dialog_ministra_armas.png"
const CRIMINOSO_MINIATURE = "res://assets/dialog miniatures/dialog_criminoso.png"

var first_level_dialogs : Array[DialogLine] = [
	DialogLine.new("*trtrtrtrtrtrim*", "", TEST_VOICE_OVER),
	DialogLine.new("Quem fala?", "Detetive Sonora", "res://assets/voice overs/voice overs full - Quem fala_.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Detetive Sonora? Sou Victória de Armas, ministra de defesa.", "Ministra de Armas", "res://assets/voice overs/voice overs full - detetive sonora_ sou de armas. estou ligando para atualizá-lo sobre a sua missão.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Estou ligando para te atualizar sobre a sua missão.", "Ministra de Armas", "res://assets/voice overs/voice overs full - estou ligando para te atualizar.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Aquela acerca do furto de uma aeronave militar indetectável.", "Ministra de Armas", "res://assets/voice overs/voice overs full - aquela acerca do furto de uma aeronave militar indetectável.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Então a senhora é a ministra de Armas?", "Detetive Sonora", "res://assets/voice overs/voice overs full - Então a senhora que é a ministra de arma.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("...De defesa.", "Ministra de Armas", "res://assets/voice overs/voice overs full - de defesa.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Nós confirmamos o que o senhor disse.", "Ministra de Armas", "res://assets/voice overs/voice overs full - nós confirmamos o que o senhor disse.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("A nave roubada realmente deixa rastros sonoros, o senhor estava certo.", "Ministra de Armas", "res://assets/voice overs/voice overs full - a nave realmente deixa rastros sonoros, o senhor estava certo.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Evidentemente...", "Detetive Sonora", "res://assets/voice overs/voice overs full - Evidentemente.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("E quanto aos equipamentos que pedi?", "Detetive Sonora", "res://assets/voice overs/voice overs full - E enquanto aos equipamentos que lhe pedi_.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Conseguimos todos.", "Ministra de Armas", "res://assets/voice overs/voice overs full - consegui todos.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Um avião silencioso, um fone de ouvido muito alto e um charuto cubano.", "Ministra de Armas", "res://assets/voice overs/voice overs full - um avião silencioso, um fone de ouvido muito alto e um charuto cubano.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("O último era realmente necessário?", "Ministra de Armas", "res://assets/voice overs/voice overs full - o último é realmente necessário_.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Não questione meus métodos, ministra.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Não questione meus métodos, ministra.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Certo…", "Ministra de Armas", "res://assets/voice overs/voice overs full - certo....wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Você tem certeza que irá rastreá-lo? Os sons parecem indecifráveis para a gente", "Ministra de Armas", "res://assets/voice overs/voice overs full - você tem certeza que irá rastreá-lo_ os sons parecem indetectáveis para a gente.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Não me chame de você.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Não me chame de você.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Ok.", "Ministra de Armas", "res://assets/voice overs/voice overs full - certo...(2).wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("E não se preocupe com isso... É como música para meus ouvidos.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Não se preocupe com isso, é como música para os meus ouvidos.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Certo, então... O senhor é a única pessoa capaz de fazer isso.", "Ministra de Armas", "res://assets/voice overs/voice overs full - o senhor é a única pessoa capaz de fazer isso. estamos contando com você, detetive.wav", MINISTRA_ARMAS_MINIATURE),
	# DialogLine.new("Estamos todos contando com o senhor, detetive", "Ministra de Armas", TEST_VOICE_OVER, MINISTRA_ARMAS_MINIATURE)
]

var second_level_dialogs : Array[DialogLine] = [
	DialogLine.new("*trtrtrtrtrtrim*", "", TEST_VOICE_OVER),
	DialogLine.new("Detetive? Incrível! O senhor conseguiu rastreá-lo!", "Ministra de Armas", "res://assets/voice overs/voice overs full - Detetive_ Incrível! O senhor conseguiu rastreá-lo!.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Como fez isso? Tratamos o senhor como um super-herói por aqui.", "Ministra de Armas", "res://assets/voice overs/voice overs full - Como fez isso_ Tratamos o senhor como um super-herói por aqui..wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("*hmpfh* Não é nada místico, ministra de Armas…", "Detetive Sonora", "res://assets/voice overs/voice overs full - Hmpfh! Não é nada místico, dona ministra.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Você já deve saber que participei da construção deste avião, correto?", "Detetive Sonora", "res://assets/voice overs/voice overs full - Suponho que já saiba que particpei da construção dete avião, estou correto.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Correto, mas nenhum dos outros conse-", "Ministra de Armas", "res://assets/voice overs/voice overs full - Correto, mas nenhum dos outros conse-.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Não me interrompa.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Não me interrompa.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Mas você que pergun-", "Ministra de Armas", "res://assets/voice overs/voice overs full - Mas você que pergun-.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Nem me chame de você.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Já falei pra não me chamar de você.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("...Certo.", "Ministra de Armas", "res://assets/voice overs/voice overs full - ...Certo..wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Conheço essa aeronave como a palma da minha mão. Consigo até mesmo distinguir a vibração emitida pelos motores a depender do seu tempo de funcionamento.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Consigo até mesmo distinguir o som dos motores a epender do seu tempo de funcionamento.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("E é a partir dessa informação que consigo identificar os deslocamentos que o avião faz relativos ao som original do motor.", "Detetive Sonora", "res://assets/voice overs/voice overs full - E é a partir dessa informaçao que conigo ide.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Fascinante…", "Ministra de Armas", "res://assets/voice overs/voice overs full - Fascinante…Mas como o senhor consegue ouvir o som do motor daquele avião_ .wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Mas como o senhor consegue ouvir o som do motor daquele avião? É graças a uma super audição nível Super-Homem?", "Ministra de Armas", "res://assets/voice overs/voice overs full - É graças a uma super audição nível Super-Homem_.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("O avião possui um logger sonoro que foi instalado para que os mecânicos pudessem identificar problemas à distância.", "Detetive Sonora", "res://assets/voice overs/voice overs full - O avião possui um logger sonoro, foi instalado para que.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Hã? E como é que EU não sabia dessa informação?", "Ministra de Armas", "res://assets/voice overs/voice overs full - Hã_ E como é que EU não sabia dessa informação_.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("...", "Detetive Sonora", "", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Eu sou um detetive. Essa pergunta me ofende.", "Detetive Sonora", "res://assets/voice overs/voice overs full - essa pergunta me ofende.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("... É claro.", "Ministra de Armas", "res://assets/voice overs/voice overs full - ... É claro.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Bom… Aparentemente ele fez uma parada e por isso os sinais pararam.", "Ministra de Armas", "res://assets/voice overs/voice overs full - Bom… Aparentemente ele fez uma parada e por isso os sinais pararam.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Mas ao que tudo indica... Ele continuará o trajeto durante a noite.", "Ministra de Armas", "res://assets/voice overs/voice overs full - Mas ao que tudo indica... Ele continuará o trajeto durante a noite.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Ainda precisaremos das suas habilidades, detetive!", "Ministra de Armas", "res://assets/voice overs/voice overs full - Ainda precisaremos das suas habilidades, detetive!.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Por favor, continue reportando os seus movimentos para que nós possamos encontrá-lo. Se continuarmos assim, até amanhã poderemos pegá-lo!", "Ministra de Armas", "res://assets/voice overs/voice overs full - Se continuarmos assim, até amanhã poderemos pegá-lo!.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Nos vemos quando houver novidades!", "Ministra de Armas", "res://assets/voice overs/voice overs full - Nos vemos quando houver novidades!.wav", MINISTRA_ARMAS_MINIATURE),
]

var third_level_dialogs : Array[DialogLine] = [
	DialogLine.new("*trtrtrtrtrtrim*", "", TEST_VOICE_OVER),
	DialogLine.new("Bom trabalho, detetive!", "Ministra de Armas", "res://assets/voice overs/voice overs full - Bom trabalho, detetive!.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("A lua estava linda hoje, parecia até que estava vendo ela várias e várias vezes…", "Ministra de Armas", "res://assets/voice overs/voice overs full - A lua estava linda hoje! Parecia até que eu estava vendo ela várias e várias vezes....wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Eu não saberia dizer. Eu sou cego.", "Detetive Sonora", "res://assets/voice overs/voice overs full - De qualquer forma, não saberia lhe informar. Sou cego.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("...", "Ministra de Armas", "", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("VOCÊ É CEGO?", "Ministra de Armas", "res://assets/voice overs/voice overs full - VOCÊ É CEGO_!.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Não me chame de \"você\".", "Detetive Sonora", "res://assets/voice overs/voice overs full - Já lhe informei_ Não me chame de você.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Desculpa! Mas como assim o senhor é cego?! Demos um avião para o senhor pilotar!", "Ministra de Armas", "res://assets/voice overs/voice overs full - Demos um avião para o senhor pilotar.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Isso é bem capacitista da sua parte.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Isso soa muito intolerante vino de sua pessoa.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Você sabe que os aviões de hoje em dia praticamente se pilotam sozinhos, né?", "Detetive Sonora", "res://assets/voice overs/voice overs full - Você ja deve saber que os avioes de hoje em dia.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Primeiramente não me chame de \"você\"", "Ministra de Armas", "res://assets/voice overs/voice overs full - Primeiramente... não me chame de você.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("E segundamente: Mesmo assim! Deve ter algum momento em que é preciso enxergar alguma coisa.", "Ministra de Armas", "res://assets/voice overs/voice overs full - Segundamente... mesmo assim! Deve existir algum momento em que é preciso enxergar alguma coisa.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Ainda não conheci esse momento. De qualquer forma, pode-se dizer que a minha audição compensa a falta de vista.", "Detetive Sonora", "res://assets/voice overs/voice overs full - De qualquer forma, digo que minha audiçao compensa.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Super poderes?", "Ministra de Armas", "res://assets/voice overs/voice overs full - Super poderes_.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Não. Audição relativa.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Negativo. Audição relativ.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Eu até tenho um cão-guia, mas às vezes sou eu quem preciso guiá-lo.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Eu até tenho cao guia, mas as vezes sou eu quem preciso auxilialo.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Eu acho bem difícil acreditar nisso.", "Ministra de Armas", "res://assets/voice overs/voice overs full - Eu acho bem difícil acreditar nisso.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Uma vez ele estava para ser atacado e não percebeu. Felizmente eu pude identificar a raiva do outro cachorro pela mudança de graus diferente entre os latidos e peguei ele no colo.", "Detetive Sonora", "res://assets/voice overs/voice overs full - Felizmente pude identificar a raiva do outro cao apenas analisando a freqe.wav", DETETIVE_SONORA_MINIATURE),
	DialogLine.new("Tá, eu acho que é melhor pararmos com a conversa fiada para não perder o foco…", "Ministra de Armas", "res://assets/voice overs/voice overs full - Tá... eu acho melhor parar com a conversa fiada para não perder o foco.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Estamos quase lá! Nossos homens estão prontos para capturar o criminoso. Com a sua interpretação dos sinais, o alcançaremos hoje mesmo!", "Ministra de Armas", "res://assets/voice overs/voice overs full - Com a sua interpretação dos sinais o alcançaremos hoje memo.wav", MINISTRA_ARMAS_MINIATURE),
	DialogLine.new("Continue o bom trabalho, senhor! Nunca estivemos tão perto!", "Ministra de Armas", "res://assets/voice overs/voice overs full - Continue o bom trabalho senhor! Nunca estivemos tão perto.wav", MINISTRA_ARMAS_MINIATURE)
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
