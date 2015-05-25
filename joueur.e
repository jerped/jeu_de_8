note
	description: "Classe abstraite CARTE"
	author: "Jérémi Pedneault"
	date: "12-02-2015"

class
	JOUEUR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create carte_possedees.make (54)
		end

feature -- Attributs

	carte_possedees: ARRAYED_LIST [CARTE]
			-- Liste des cartes pour le {JOUEUR}.

end
