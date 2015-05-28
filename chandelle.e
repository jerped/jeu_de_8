note
	description: "Classe représentant les chandelles du jeu"
	author: "Jérémi Pedneault"
	date: "12-02-2015"


class
	CHANDELLE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			image1 := create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("./ressources/images/chandelle/chandelle1.png")
			image2 := create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("./ressources/images/chandelle/chandelle2.png")
			image3 := create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("./ressources/images/chandelle/chandelle3.png")
			image_affichee:= image1
		end

feature -- images affichable

	image1: GAME_SURFACE
			-- la premiere image de l'animation

	image2: GAME_SURFACE
			-- la 2e image de l'animation

	image3: GAME_SURFACE
			-- la 3e image de l'animation

	image_affichee: GAME_SURFACE assign set_image_affichee
			-- l'image affichée à l'écran

feature {NONE} -- Assigners

	set_image_affichee(une_image:GAME_SURFACE)
			-- Assigne l'image à afficher pour l'animation de la chandelle
		do
			image_affichee:= une_image
		end


end
