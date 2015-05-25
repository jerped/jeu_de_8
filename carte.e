note
	description: "Classe abstraite CARTE"
	author: "J�r�mi Pedneault"
	date: "12-02-2015"

deferred class
	CARTE

feature {NONE} -- Initialization

	make (a_numero: INTEGER)
			-- Initialization for `Current'.
			-- Assignation de `numero'
		do
			numero := a_numero
			attribuer_variable
		end

feature -- Attributs

	numero: INTEGER
			-- numero de la carte. De 1 � 54

	valeur: INTEGER
			-- valeur de la carte. De 1 � 13

	sorte: STRING
			-- sorte de la carte. "Carr�", "Tr�fle", "Coeur", "Pique"

	image: GAME_SURFACE_IMG_FILE
			-- image repr�sentant la carte

feature -- Operations

	attribuer_variable
			-- cr�ation des cartes selon leur `numero'. Attribut la sorte et l'image de celles-ci
		do
			valeur := ((numero - 3) \\ 13) + 1
			create image.make ("./ressources/images/cartes/carte" + (numero).out + ".png")
			if ((numero - 3) / 13).floor = 0 then
				sorte := "Coeur"
			elseif ((numero - 3) / 13).floor = 1 then
				sorte := "Pique"
			elseif ((numero - 3) / 13).floor = 2 then
				sorte := "Carreaux"
			elseif ((numero - 3) / 13).floor = 3 then
				sorte := "Tr�fle"
			end
		end

	effet
			-- L'effet des cartes, chang� selon le type de celle-ci. Ne fais rien pour les cartes de bases.
		deferred
		end

end
