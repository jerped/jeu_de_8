note
	description: "Classe abstraite CARTE"
	author: "Jérémi Pedneault"
	date: "12-02-2015"

deferred class
	CARTE

feature {NONE} -- Initialization

	make (a_numero: INTEGER)
			-- Initialization for `Current'.
			-- Assignation de `numero'
		require
			numero_trop_grand: a_numero <= 54
			numero_trop_petit: a_numero >= 0
		do
			numero := a_numero
			attribuer_variable
		end

feature -- Attributs

	numero: INTEGER
			-- numero de la carte. De 1 à 54

	valeur: INTEGER
			-- valeur de la carte. De 1 à 13

	sorte: STRING
			-- sorte de la carte. "Carré", "Trèfle", "Coeur", "Pique"

	image: GAME_SURFACE
			-- image représentant la carte

feature -- Operations

	attribuer_variable
			-- création des cartes selon leur `numero'. Attribut la sorte et l'image de celles-ci
		do
			valeur := ((numero - 3) \\ 13) + 1
			image := create {GAME_SURFACE_IMG_FILE}.make_with_alpha ("./ressources/images/cartes/carte" + (numero).out + ".png")
			if ((numero - 3) / 13).floor = 0 then
				sorte := "Coeur"
			elseif ((numero - 3) / 13).floor = 1 then
				sorte := "Pique"
			elseif ((numero - 3) / 13).floor = 2 then
				sorte := "Carreaux"
			elseif ((numero - 3) / 13).floor = 3 then
				sorte := "Trèfle"
			end
		ensure
			valeur_non_valide: valeur <= 13 or valeur >= 1
		end

	effet(un_engin_jeu:ENGIN_DE_JEU)
			-- L'effet des cartes, changé selon le type de celle-ci. Ne fais rien pour les cartes de bases.
		deferred
		end

end
