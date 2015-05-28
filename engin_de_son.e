note
	description: "Classe pour gérer les sons du jeu"
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

feature {NONE} -- Attribut local

	musique_jeu: AUDIO_SOUND_SND_FILE
			-- fichier audio pour la musique de fond

	son_effet: AUDIO_SOUND_SND_FILE
			-- fichier audio pour l'effet sonore des cartes

	source_musicale: AUDIO_SOURCE
			-- source de la musique

	source_son: AUDIO_SOURCE
			-- source de l'effet sonore des cartes

feature -- Operations

	set_sound (a_controlleur: GAME_LIB_CONTROLLER)
			-- construit le son et le fais jouer
		do
			create musique_jeu.make ("./ressources/musique/musique1.flac")
			controlleur_son.add_source
			source_musicale := controlleur_son.last_source
			create son_effet.make ("./ressources/musique/son1.ogg")
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

	jouer_effet
			-- fais jouer l'effet sonore
		do
			if source_son.is_playing then
				source_son.stop
			end
			source_son.queue_sound (son_effet)
			source_son.play
		end

end
