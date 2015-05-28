note
	description: "Classe pour gérer les paquet de carte du jeu"
	author: "Jérémi Pedneault"
	date: "12-02-2015"

class
	PAQUET_CARTE

create
	make, make_avec_liste

feature {NONE} -- Initialization

	make (a_controlleur_jeu: GAME_LIB_CONTROLLER)
			-- Initialization for `Current'.
			-- Crée aussi les paquets de cartes du jeu
		do
			if a_controlleur_jeu /= Void then
				creer_ordre_carte (a_controlleur_jeu)
				creer_cartes
			end
		end

	make_avec_liste (un_numeros_cartes_a_creer: ARRAYED_LIST [INTEGER])
			-- Initialization for `Current'.
			-- Crée les paquet de carte à partir d'une liste d'ID
		require
			nombre_de_carte_invalide: un_numeros_cartes_a_creer.count <= 54 and un_numeros_cartes_a_creer.count >= 0
		do
			if un_numeros_cartes_a_creer /= Void then
				set_numeros_cartes_a_creer (un_numeros_cartes_a_creer)
				creer_cartes
			end
		end

feature -- Attributs

	sorte_a_jouer: STRING assign set_sorte_a_jouer
			-- Quelle sorte de carte il est possible de jouer

	carte_selectionner: CARTE
			-- La {CARTE} qui est sélectionnée sur le premier

	un_paquet: ARRAYED_LIST [CARTE]
			-- Le paquet principal. Celui construit au départ. Contient 54 {CARTE}

	paquet_central: ARRAYED_LIST [CARTE]
			-- Le paquet central. Celui où les {JOUEUR} pigent les {CARTE}

	paquet_carte_jouee: ARRAYED_LIST [CARTE]
			-- Le paquet des {CARTE} jouée.

	numeros_cartes_a_creer: ARRAYED_LIST [INTEGER]
			-- Liste des `numero' de carte. Contient 54 éléments

feature -- Operations

	donner_carte_debut (a_liste_joueurs: ARRAYED_LIST [JOUEUR])
			-- Distribution des cartes au début du jeu
			-- Reçoit en paramètre une liste contenant des objets de type JOUEUR
		local
			i: INTEGER_8
			j: INTEGER
		do
			from
				i := 0
			until
				i >= 8
			loop
				from
					j := 1
				until
					j > a_liste_joueurs.count
				loop
					selectioner_carte
					a_liste_joueurs.at (j).carte_possedees.extend (carte_selectionner)
					j := j + 1
				end
				i := i + 1
			end
			selectioner_carte
			paquet_carte_jouee.extend (carte_selectionner)
			sorte_a_jouer := carte_selectionner.sorte
		end

	selectioner_carte
			-- Sélectionne une carte dans le paquet et l'assigne à la variable carte_selectionner
		do
			if paquet_central.count = 1 then
				from
					paquet_carte_jouee.start
				until
					paquet_carte_jouee.islast
				loop
					if not paquet_carte_jouee.islast then
						paquet_central.extend (paquet_carte_jouee.item)
						paquet_carte_jouee.forth
					end
				end
			end
			if  paquet_central.count > 1 then
				paquet_central.start
				carte_selectionner := paquet_central.item
				paquet_central.remove
			end
		end

	placer_carte_centre
			-- Crée le paquet central et lui fournit le paquet créé au début du jeu
			-- reçoit en paramètre un GAME_LIB_CONTROLLER
		do
			create paquet_carte_jouee.make (54)
			create paquet_central.make (54)
			paquet_central.copy (un_paquet)
		end

	creer_ordre_carte (a_controlleur_jeu: GAME_LIB_CONTROLLER)
			-- Crée une ARRAYED_LIST contenant les id des cartes de façon aléatoire
			-- reçoit en paramètre un GAME_LIB_CONTROLLER
		local
			i: INTEGER
			numero_carte: INTEGER
		do
			create numeros_cartes_a_creer.make (54)
			from
				i := 0
			until
				i >= 54
			loop
				a_controlleur_jeu.generate_new_random
				numero_carte := a_controlleur_jeu.last_random_integer_between (1, 54)
				if not numeros_cartes_a_creer.has (numero_carte) then
					numeros_cartes_a_creer.extend (numero_carte)
					i := i + 1
				end
			end
		end

	creer_cartes
			-- Crée une ARRAYED_LIST contenant des objets de type CARTE à partir de la liste d'id locale.
		local
			i: INTEGER
			l_carte_base: CARTE_BASE
			l_carte_1: CARTE_1
			l_carte_2: CARTE_2
			l_carte_8: CARTE_8
			l_carte_10: CARTE_10
			l_carte_11: CARTE_11
			l_joker: JOKER
		do
			create un_paquet.make (54)
			from
				i := 1
			until
				i = numeros_cartes_a_creer.count + 1
			loop
				if numeros_cartes_a_creer.at (i) <= 2 then
					create l_joker.make (numeros_cartes_a_creer.at (i))
					un_paquet.extend (l_joker)
				elseif ((numeros_cartes_a_creer.at (i) - 3) \\ 13) + 1 = 1 then
					create l_carte_1.make (numeros_cartes_a_creer.at (i))
					un_paquet.extend (l_carte_1)
				elseif ((numeros_cartes_a_creer.at (i) - 3) \\ 13) + 1 = 2 then
					create l_carte_2.make (numeros_cartes_a_creer.at (i))
					un_paquet.extend (l_carte_2)
				elseif ((numeros_cartes_a_creer.at (i) - 3) \\ 13) + 1 = 8 then
					create l_carte_8.make (numeros_cartes_a_creer.at (i))
					un_paquet.extend (l_carte_8)
				elseif ((numeros_cartes_a_creer.at (i) - 3) \\ 13) + 1 = 10 then
					create l_carte_10.make (numeros_cartes_a_creer.at (i))
					un_paquet.extend (l_carte_10)
				elseif ((numeros_cartes_a_creer.at (i) - 3) \\ 13) + 1 = 11 then
					create l_carte_11.make (numeros_cartes_a_creer.at (i))
					un_paquet.extend (l_carte_11)
				else
					create l_carte_base.make (numeros_cartes_a_creer.at (i))
					un_paquet.extend (l_carte_base)
				end
				i := i + 1
			end
		end

feature {NONE} -- Assigneurs

	set_numeros_cartes_a_creer (un_numeros_cartes_a_creer: ARRAYED_LIST [INTEGER])
		do
			numeros_cartes_a_creer := un_numeros_cartes_a_creer
		end

	set_sorte_a_jouer(une_sorte:STRING)
		do
			sorte_a_jouer:=une_sorte
		end

end
