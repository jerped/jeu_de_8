note
	description: "Classe abstraite CARTE"
	author: "J�r�mi Pedneault"
	date: "12-02-2015"

class
	FENETRE

create
	make_fenetre_principale

feature {NONE} -- Initialization

	make_fenetre_principale (a_controller: GAME_LIB_CONTROLLER)
			-- Initialization for `Current'.
		do
			a_controller.create_screen_surface (850, 850, 16, true, true, false, true, false)
			a_controller.set_window_caption ("8 de Cartes", "8")
			create plateau_de_jeu.make
		end

feature -- Attributs

	plateau_de_jeu: PLATEAU
			-- le plateau du jeu

	image_affichee: GAME_SURFACE_IMG_FILE
			-- l'image � afficher sur la fen�tre de jeu

feature -- Operations

	set_image_affichee_avec_lien (a_lien_image: STRING)
			-- Construit l'image � afficher � partir d'un chemin de fichier
		do
			create image_affichee.make (a_lien_image)
		end

	set_image_affichee_plateau
			-- Assigne l'image de fond du plateau � l'image affich�e de la fen�tre
		do
			image_affichee := plateau_de_jeu.image_de_fond
		end

	afficher_fenetre_jeu (a_controller: GAME_LIB_CONTROLLER)
			-- Cr�e la GAME_SURFACE associ�e � partir de l'image � afficher.
			-- Re�oit en param�tre un GAME_LIB_CONTROLLER pour ce faire.
		do
			a_controller.screen_surface.draw_surface (image_affichee, 0, 0)
		end

end
