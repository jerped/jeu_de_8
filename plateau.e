note
	description: "Le plateau du jeu, incluant le paquet, l'image de fond et les cartes des joueurs"
	author: "Jérémi Pedneault"
	date: "12-02-2015"

class
	PLATEAU

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			image_De_Fond := create {GAME_SURFACE_IMG_FILE}.make ("./ressources/images/background.png")
			image_carte_endos := create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("./ressources/images/endo.png")
			image_curseur := create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("./ressources/images/selection.png")
			create une_chandelle.make
		end

feature -- Attributs

	image_de_fond: GAME_SURFACE
			-- image du fond du jeu

	image_carte_endos: GAME_SURFACE
			-- image d'endos des cartes

	image_curseur: GAME_SURFACE
			-- image pour indiquer quelle carte est actuellement selectionnee

	une_chandelle:CHANDELLE
			-- La chandelle affichéede chaque coté de l'écran

feature -- Operations

	afficher_carte_joueur_principal (a_controlleur_jeu: GAME_LIB_CONTROLLER; a_joueur: JOUEUR)
			-- Affiche les {CARTE} pour le {JOUEUR} principal de l'application
		local
			i: INTEGER
			l_x_debut, l_y_debut: INTEGER
			l_decallage: INTEGER
			l_numero_carte_curseur: INTEGER
		do
			if a_joueur.carte_possedees.readable then
				l_numero_carte_curseur := a_joueur.carte_possedees.item.numero
			end
			l_x_debut := (image_de_fond.width // 2) - ((a_joueur.carte_possedees.count*image_carte_endos.width) //2)
			l_y_debut := 725
			l_decallage := (a_joueur.carte_possedees.count // 2) + 1
			from
				i := 1
			until
				i > a_joueur.carte_possedees.count
			loop
				a_controlleur_jeu.screen_surface.draw_surface (a_joueur.carte_possedees.at (i).image, l_x_debut, l_y_debut)
				if a_joueur.carte_possedees.at (i).numero = l_numero_carte_curseur then
					a_controlleur_jeu.screen_surface.draw_surface (image_curseur, l_x_debut, l_y_debut)
				end
				l_x_debut := l_x_debut + (a_joueur.carte_possedees.at (i).image.width - l_decallage)
				i := i + 1
			end
		end

	afficher_carte_autre_joueur (a_controlleur_jeu: GAME_LIB_CONTROLLER; a_joueurs: ARRAYED_LIST [JOUEUR])
			-- Affiche les {CARTE} pour le {JOUEUR} secondaire de l'application
		local
			i, j: INTEGER
			l_x_debut, l_y_debut: INTEGER
			l_decallage: INTEGER
		do
			from
				i := 2
			until
				i > a_joueurs.count
			loop
				l_x_debut := (image_de_fond.width // 2) - ((a_joueurs.at (i).carte_possedees.count*image_carte_endos.width) //2)
				l_y_debut := 70
				l_decallage := (a_joueurs.at (i).carte_possedees.count // 2) + 1
				from
					j := 1
				until
					j > a_joueurs.at (i).carte_possedees.count
				loop
					a_controlleur_jeu.screen_surface.draw_surface (image_carte_endos, l_x_debut, l_y_debut)
					l_x_debut := l_x_debut + (image_carte_endos.width - l_decallage)
					j := j + 1
				end
				i := i + 1
			end
		end

	afficher_carte_centre (a_controlleur_jeu: GAME_LIB_CONTROLLER; image_carte: GAME_SURFACE)
			-- affichage des cartes au centre du plateau de jeu
		do
			a_controlleur_jeu.screen_surface.draw_surface (image_carte_endos, 315, 380)
			a_controlleur_jeu.screen_surface.draw_surface (image_carte, 415, 380)
		end

	afficher_chandelle(a_controlleur_jeu:GAME_LIB_CONTROLLER)
			-- Affichage des chandelles de chaque cotédu plateau de jeu
		do
			a_controlleur_jeu.screen_surface.draw_surface (une_chandelle.image_affichee, 20, 425)
			a_controlleur_jeu.screen_surface.draw_surface (une_chandelle.image_affichee, 795, 425)
		end

end
