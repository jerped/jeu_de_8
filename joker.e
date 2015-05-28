note
	description: "Le Joker du paquet"
	author: "Jérémi Pedneault"
	date: "12-02-2015"

class
	JOKER

inherit

	CARTE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_numero: INTEGER)
			-- Initialization for `Current'.
			-- Assigne le `numero' de la carte ainsi que son `image'
		do
			numero := a_numero
			image := create {GAME_SURFACE_IMG_FILE}.make_with_alpha("./ressources/images/cartes/carte" + (a_numero).out + ".png")
			valeur := 0
			sorte := "joker"
		end

feature -- Operations

	effet(un_engin_jeu:ENGIN_DE_JEU)
			-- Fais piger 5 cartes au prochain joueur
			-- Permet aussi de décider de la sorte suivante.
		do
		end

end
