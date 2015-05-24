note
	description : "Le plateau du jeu, incluant le paquet, l'image de fond et les cartes des joueurs"
	author      : "Jérémi Pedneault"
	date        : "12-02-2015"

class
	PLATEAU

create
	make

feature {NONE}-- Initialization
	make
			-- Initialization for `Current'.
		do
			create image_De_Fond.make ("./ressources/images/background.png")
			create image_carte_endos.make ("./ressources/images/endo.png")
		end

feature -- Attributs
	image_de_fond:GAME_SURFACE_IMG_FILE
			-- image du fond du jeu
	image_carte_endos:GAME_SURFACE_IMG_FILE
			-- image d'endos des cartes

feature -- Operations
	afficher_carte_joueur_principal(a_controlleur_jeu:GAME_LIB_CONTROLLER; a_joueur:JOUEUR)
		-- Affiche les {CARTE} pour le {JOUEUR} principal de l'application
		local
			i:INTEGER
			l_x_debut, l_y_debut:INTEGER
			l_decallage:INTEGER
		do
			l_x_debut:=(image_de_fond.width // 2) - 300 - ((a_joueur.carte_possedees.count \\ 2) * (a_joueur.carte_possedees.count \\ 2))
			l_y_debut:=725
			l_decallage:= (a_joueur.carte_possedees.count \\ 2) + 1
			from
				i:=1
			until
				i>=a_joueur.carte_possedees.count
			loop
				a_controlleur_jeu.screen_surface.draw_surface (a_joueur.carte_possedees.at (i).image, l_x_debut, l_y_debut)
				l_x_debut := l_x_debut + (a_joueur.carte_possedees.at (i).image.width // l_decallage)
				i:= i+1
			end
		end

	afficher_carte_autre_joueur(a_controlleur_jeu:GAME_LIB_CONTROLLER; a_joueurs:ARRAYED_LIST[JOUEUR])
		-- Affiche les {CARTE} pour le {JOUEUR} secondaire de l'application
		local
			i, j:INTEGER
			l_x_debut, l_y_debut:INTEGER
			l_decallage:INTEGER
		do
			from
				i := 2
			until
				i > a_joueurs.count
			loop

				l_x_debut := (image_de_fond.width // 2) - 300 - ((a_joueurs.at (i).carte_possedees.count \\ 2) * (a_joueurs.at (i).carte_possedees.count \\ 2))
				l_y_debut := 125
				l_decallage := (a_joueurs.at (i).carte_possedees.count \\ 2) + 1

				from
					j:=1
				until
					j > a_joueurs.at (i).carte_possedees.count
				loop
					a_controlleur_jeu.screen_surface.draw_surface (image_carte_endos, l_x_debut, l_y_debut)
					l_x_debut := l_x_debut + (image_carte_endos.width // l_decallage)
					j := j + 1
				end

				i := i + 1

			end
		end

end
