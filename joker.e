note
	description : "Le Joker du paquet"
	author      : "J�r�mi Pedneault"
	date        : "12-02-2015"

class
	JOKER

inherit CARTE
	redefine
		make
	end

create
	make

feature {NONE}-- Initialization
	make(a_numero:INTEGER)
			-- Initialization for `Current'.
			-- Assigne le `numero' de la carte ainsi que son `image'
		do
			numero := a_numero
			create image.make ("./ressources/images/cartes/carte" + (a_numero).out + ".png")
		end

feature -- Operations
	effet
		-- Fais piger 5 cartes au prochain joueur
		-- Permet aussi de d�cider de la sorte suivante.
		do

		end

end
