note
	description: "Le jeu lui-même"
	author: "Jérémi Pedneault"
	date: "12-02-2015"

class
	ECRAN_JEU

create
	make

feature {NONE} -- Initialization

	make (a_engin_jeu: ENGIN_DE_JEU)
			-- Initialization for `Current'.
			-- Reçoit un argument de type {ENGIN_DE_JEU}
		local
			l_joueur: JOUEUR
		do
			if a_engin_jeu /= Void then
				set_engin_jeu (a_engin_jeu)
				create l_joueur.make
				create joueurs.make (2)
				joueurs.extend (l_joueur)
				create l_joueur.make
				joueurs.extend (l_joueur)
				if engin_jeu.engin_reseau.est_serveur then
					create les_paquets_carte.make (engin_jeu.controlleur_jeu)
					engin_jeu.engin_reseau.envoyer_paquet_carte (les_paquets_carte.numeros_cartes_a_creer)
					les_paquets_carte.placer_carte_centre
					les_paquets_carte.donner_carte_debut (joueurs)
					doit_attendre := True
				else
					engin_jeu.engin_reseau.recevoir_paquet_carte
					create les_paquets_carte.make_avec_liste (engin_jeu.engin_reseau.liste_carte)
					les_paquets_carte.placer_carte_centre
					les_paquets_carte.donner_carte_debut (joueurs)
					joueurs.start -- pour mettre le joueur client comme joueur principal.
					joueurs.swap (2)
				end
				joueurs.first.carte_possedees.start
				engin_jeu.controlleur_jeu.clear_event_controller
				engin_jeu.engin_sonore.set_sound (engin_jeu.controlleur_jeu)
				create font_gros.make ("./ressources/arial.ttf", 30)
			end
		end

feature {NONE} -- Attribut local

	engin_jeu: ENGIN_DE_JEU
			-- l'{ENGIN_DE_JEU} qui gère les event et autres.

	doit_jouer_carte: BOOLEAN
			-- Si le jeu doit jouer la carte ou non

	doit_attendre: BOOLEAN
			--Indique si le joueur doit attendre son tour ou non

	une_action: STRING
			-- représente l'action effectuée par l'autre joueur à la fin de son tour

	doit_quitter: BOOLEAN
			-- Représente si le joueur veut quitter ou non

	doit_piger: BOOLEAN
			-- Représente si le joueur veut piger une carte ou non

	font_gros: GAME_FONT
			-- La police pour les textes de grande taille

	a_gagne: BOOLEAN
			-- Si le joueur a gagné ou non

feature -- Attributs

	les_paquets_carte: PAQUET_CARTE
			-- un paquet de carte.

	joueurs: ARRAYED_LIST [JOUEUR]
			-- la liste des joueurs connectés.

feature -- Démarrage du jeu

	run_game
			-- Démarrage du jeu
		do
			engin_jeu.fenetre_principale.set_image_affichee_plateau
			engin_jeu.fenetre_principale.afficher_fenetre_jeu (engin_jeu.controlleur_jeu)
			engin_jeu.controlleur_jeu.event_controller.on_iteration.extend (agent update_ecran_jeu)
			engin_jeu.controlleur_jeu.event_controller.on_iteration.extend (agent veut_jouer_carte)
			engin_jeu.controlleur_jeu.event_controller.on_iteration.extend (agent veut_piger)
			engin_jeu.controlleur_jeu.event_controller.on_iteration.extend (agent attendre_tour)
			engin_jeu.controlleur_jeu.event_controller.on_iteration.extend (agent veut_quitter)
			engin_jeu.controlleur_jeu.event_controller.on_iteration.extend (agent animer_chandelle)
			engin_jeu.controlleur_jeu.event_controller.on_iteration.extend (agent verification_gagnant)
			engin_jeu.controlleur_jeu.event_controller.on_key_down.extend (agent on_key_down(?))
			engin_jeu.controlleur_jeu.event_controller.on_quit_signal.extend (agent quitter)
			engin_jeu.controlleur_jeu.flip_screen
			engin_jeu.controlleur_jeu.launch
		end

feature {NONE} -- Action a chaque itération

	update_ecran_jeu
			-- Boucle principale du jeu
		do
			engin_jeu.fenetre_principale.afficher_fenetre_jeu (engin_jeu.controlleur_jeu)
			engin_jeu.fenetre_principale.plateau_de_jeu.afficher_carte_joueur_principal (engin_jeu.controlleur_jeu, joueurs.first)
			engin_jeu.fenetre_principale.plateau_de_jeu.afficher_carte_autre_joueur (engin_jeu.controlleur_jeu, joueurs)
			engin_jeu.fenetre_principale.plateau_de_jeu.afficher_carte_centre (engin_jeu.controlleur_jeu, les_paquets_carte.paquet_carte_jouee.last.image)
			engin_jeu.fenetre_principale.plateau_de_jeu.afficher_chandelle (engin_jeu.controlleur_jeu)
			afficher_texte
			engin_jeu.controlleur_jeu.flip_screen
			engin_jeu.engin_sonore.mise_a_jour
		end

	on_key_down (kb_event: GAME_KEYBOARD_EVENT)
			-- Gestion des touches appuyées par le joueur
		do
			if kb_event.is_left_key then
				if not joueurs.first.carte_possedees.before then
					joueurs.first.carte_possedees.back
					engin_jeu.engin_sonore.jouer_effet
				end
			elseif kb_event.is_right_key then
				if not joueurs.first.carte_possedees.after then
					joueurs.first.carte_possedees.forth
					engin_jeu.engin_sonore.jouer_effet
				end
			elseif kb_event.is_return_key then
				doit_jouer_carte := True
			elseif kb_event.is_space_key then
				doit_piger := True
			elseif kb_event.is_escape_key then
				doit_quitter := True
			end
		end

	attendre_tour
			-- lejoueur attend que l'autre ait terminé son tour
			-- Il recoit aussi l'action effectuéepar l'autre joueur
		do
			if doit_attendre then
				engin_jeu.engin_reseau.recevoir_action
				une_action := engin_jeu.engin_reseau.une_action_recue
				doit_attendre := False
				if une_action.is_equal ("carte") then
					jouer_carte_autre
				elseif une_action.is_equal ("passe") then
				elseif une_action.is_equal ("quitter") then
					doit_quitter := True
				elseif une_action.is_equal ("a_pige") then
					piger_carte_autre_joueur (1)
				end
			end
		end

	veut_piger
			-- Surveille si le joueur veut piger ou non
			-- Redirige vers la fonction `piger_carte_principal' si oui
		do
			if doit_piger then
				piger_carte_principal (1)
			end
		end

	veut_quitter
			-- Surveille si le joueur veut quitter ou non
			-- Redirige vers la fonction `quitter' si oui
		do
			if doit_quitter then
				quitter
			end
		end

	veut_jouer_carte
			-- Surveille si le joueur veut jouer une carte ou non
			-- Redirige vers la fonction `jouer_carte_principal' si oui
		do
			if doit_jouer_carte then
				jouer_carte_principal
				doit_jouer_carte := False
			end
		end

feature {NONE} -- Action demandée par les event

	animer_chandelle
			-- L'animation de la chandelle
		local
			numero_image: INTEGER
		do
			if ((engin_jeu.controlleur_jeu.get_ticks // 200) \\ 3) = 0 then
				engin_jeu.controlleur_jeu.generate_new_random
				numero_image := engin_jeu.controlleur_jeu.last_random_integer_between (1, 3)
				if numero_image = 1 then
					engin_jeu.fenetre_principale.plateau_de_jeu.une_chandelle.image_affichee := engin_jeu.fenetre_principale.plateau_de_jeu.une_chandelle.image1
				elseif numero_image = 2 then
					engin_jeu.fenetre_principale.plateau_de_jeu.une_chandelle.image_affichee := engin_jeu.fenetre_principale.plateau_de_jeu.une_chandelle.image2
				elseif numero_image = 3 then
					engin_jeu.fenetre_principale.plateau_de_jeu.une_chandelle.image_affichee := engin_jeu.fenetre_principale.plateau_de_jeu.une_chandelle.image3
				end
			end
		end

	afficher_texte
			-- Affichage du texte à l'écran
		local
			l_texte_attente: STRING_32
			l_texte_gagne: STRING_32
			l_couleur_texte: GAME_COLOR
			l_zone_texte: GAME_SURFACE
		do
			create l_couleur_texte.make_rgb (50, 220, 0)
			if a_gagne then
				l_texte_gagne := "Vous avez gagné!!!"
				l_zone_texte := create {GAME_SURFACE_TEXT}.make_blended (l_texte_gagne, font_gros, l_couleur_texte)
				engin_jeu.controlleur_jeu.screen_surface.draw_surface (l_zone_texte, 80, 425)
			elseif doit_attendre then
				l_texte_attente := "Attente de la fin du tour de l'autre joueur"
				l_zone_texte := create {GAME_SURFACE_TEXT}.make_blended (l_texte_attente, font_gros, l_couleur_texte)
				engin_jeu.controlleur_jeu.screen_surface.draw_surface (l_zone_texte, 80, 425)
			end
		end

	verification_gagnant
			-- Vérifie si le joueur a gagné
		do
			if joueurs.first.carte_possedees.count = 0 then
				a_gagne := True
			end
		end

	jouer_carte_principal
			-- Les actions à effectuer quand le joueur veut jouer une carte
		local
			l_carte_jouee: CARTE
		do
			if joueurs.first.carte_possedees.readable then
				l_carte_jouee := joueurs.first.carte_possedees.item
				if l_carte_jouee.sorte.is_equal (les_paquets_carte.sorte_a_jouer) or l_carte_jouee.sorte.is_equal ("joker") or l_carte_jouee.valeur = 8 or l_carte_jouee.valeur = les_paquets_carte.paquet_carte_jouee.last.valeur then
					joueurs.first.carte_possedees.remove
					les_paquets_carte.paquet_carte_jouee.extend (l_carte_jouee)
					les_paquets_carte.sorte_a_jouer := l_carte_jouee.sorte
					update_ecran_jeu
					doit_attendre := True
					engin_jeu.engin_reseau.envoyer_action ("carte%N")
					engin_jeu.engin_reseau.envoyer_carte (l_carte_jouee.numero)
				end
			end
		end

	piger_carte_principal (nbr_carte: INTEGER)
			-- Prend une carte du paquet central et la met dans la main du joueur principal.
			-- Reçoit en argument le nombre de cartes à piger
		require
			nombre_de_carte_a_piger_non_valide: nbr_carte >= 0 or nbr_carte <= 54
		local
			l_envoyer: BOOLEAN
			i: INTEGER
		do
			from
				i := 0
			until
				i >= nbr_carte
			loop
				les_paquets_carte.selectioner_carte
				if joueurs.first.carte_possedees.last /= les_paquets_carte.carte_selectionner then
					joueurs.first.carte_possedees.extend (les_paquets_carte.carte_selectionner)
					l_envoyer := True
				else
					l_envoyer := False
				end
				i := +1
			end
			update_ecran_jeu
			if l_envoyer then
				doit_attendre := True
				doit_piger := False
				engin_jeu.engin_reseau.envoyer_action ("a_pige%N")
			end
		end

	piger_carte_autre_joueur (nbr_carte: INTEGER)
			-- Prend une carte du paquet central et la met dans la main du joueur.
			-- Reçoit en argument le nombre de cartes à piger
		require
			nombre_de_carte_a_piger_non_valide: nbr_carte >= 0 or nbr_carte <= 54
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i >= nbr_carte
			loop
				les_paquets_carte.selectioner_carte
				if joueurs.first.carte_possedees.last /= les_paquets_carte.carte_selectionner then
					joueurs.last.carte_possedees.extend (les_paquets_carte.carte_selectionner)
				end
				i := +1
			end
			une_action := ""
			update_ecran_jeu
		end

	jouer_carte_autre
			-- Les actions à effectuer quand l'autre joueur a joué une carte
		local
			l_id_carte_jouee: INTEGER
			l_carte_jouee: CARTE
			l_trouve: BOOLEAN
		do
			engin_jeu.engin_reseau.recevoir_carte
			l_id_carte_jouee := engin_jeu.engin_reseau.un_numero_carte_recu
			joueurs.last.carte_possedees.start
			from
			until
				joueurs.last.carte_possedees.islast or l_trouve
			loop
				if joueurs.last.carte_possedees.item.numero = l_id_carte_jouee then
					l_carte_jouee := joueurs.last.carte_possedees.item
					joueurs.last.carte_possedees.remove
					les_paquets_carte.paquet_carte_jouee.extend (l_carte_jouee)
					les_paquets_carte.sorte_a_jouer := l_carte_jouee.sorte
					l_carte_jouee.effet (engin_jeu)
					update_ecran_jeu
					l_trouve := True
				end
				joueurs.last.carte_possedees.forth
			end
			une_action := ""
		end

	quitter
			-- Quand le joueur veut quitter le jeu, que ce soit en appuyant sur Echap ou sur le X
		do
			engin_jeu.engin_reseau.envoyer_action ("quitter")
			engin_jeu.controlleur_jeu.clear_event_controller
			engin_jeu.controlleur_jeu.stop
		end

feature -- Assignateurs

	set_engin_jeu (a_engin_jeu: ENGIN_DE_JEU)
			-- Assignation de l'atribut `engin_jeu' à partir d'un {ENGIN_DE_JEU}
		do
			engin_jeu := a_engin_jeu;
		end

end
