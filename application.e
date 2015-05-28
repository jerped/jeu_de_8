note
	titre: "Mon projet de session dans le cadre du cour de programmation Objet"
	type: "Jeu de Carte 8 en 1 contre 1"
	description: "Classe racine de l'application."
	author: "Jérémi Pedneault"
	date: "12-02-2015"
	correcteur: "Présenté à monsieur Louis Marchand"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			l_ecran_titre: ECRAN_TITRE
			l_ecran_jeu: ECRAN_JEU
			l_engin_de_jeu: ENGIN_DE_JEU
		do
			create l_engin_de_jeu.make
			create l_ecran_titre.make (l_engin_de_jeu)    	-- Démarrage de l'écran titre
			l_ecran_titre.run_ecran_titre
			if l_ecran_titre.doit_demarrer_jeu then
				create l_ecran_jeu.make (l_engin_de_jeu)	-- Démarrage du jeu, si demandé dans l'écran titre
				l_ecran_jeu.run_game
			end
			l_engin_de_jeu.controlleur_image.quit_library
			l_engin_de_jeu.controlleur_jeu.quit_library
			l_engin_de_jeu.controlleur_texte.quit_library
			l_engin_de_jeu.engin_sonore.controlleur_son.quit_library
		end

end
