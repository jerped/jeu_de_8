note
	description: "Classe abstraite CARTE"
	author: "Jérémi Pedneault"
	date: "12-02-2015"

class
	ENGIN_DE_SON

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create controlleur_son.make
			controlleur_son.enable_sound
		end

feature -- Attributs

	controlleur_son: AUDIO_CONTROLLER
			-- le controlleur audio du jeu

feature -- Operations

	set_sound (a_controlleur: GAME_LIB_CONTROLLER)
			-- Construit le son et le fais jouer
		local
			musique_jeu: AUDIO_SOUND_SND_FILE
			source_musicale, source_son: AUDIO_SOURCE
		do
			create musique_jeu.make (".\ressources\musique\1.flac")
			controlleur_son.add_source
			source_musicale := controlleur_son.last_source
			controlleur_son.add_source
			source_son := controlleur_son.last_source
			source_musicale.queue_sound_infinite_loop (musique_jeu)
			source_musicale.play
		end

	mise_a_jour
			-- s'assure que la suite du fichier audio s'ajoute dans le buffer.
		do
			controlleur_son.update
		end

end
