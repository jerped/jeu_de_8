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
			set_engin_jeu (a_engin_jeu)
			create l_joueur.make
			create joueurs.make (1)
			joueurs.extend (l_joueur)
			if engin_jeu.engin_reseau.est_serveur then
				create les_paquets_carte.make (engin_jeu.controlleur_jeu)
				engin_jeu.engin_reseau.envoyer_paquet_carte (les_paquets_carte.numeros_cartes_a_creer)
			else
				create les_paquets_carte.make_avec_liste (engin_jeu.engin_reseau.recevoir_paquet_carte)
			end
		end

feature {NONE} -- Attribut local

	engin_jeu: ENGIN_DE_JEU
			-- l'{ENGIN_DE_JEU} qui gère les event et autres.

feature -- Attributs

	les_paquets_carte: PAQUET_CARTE
			-- un paquet de carte.

	joueurs: ARRAYED_LIST [JOUEUR]
			-- la liste des joueurs connectés.

feature -- Operations

	run_game
			-- Démarrage du jeu
		local
			l_joueur: JOUEUR
		do
			engin_jeu.controlleur_jeu.clear_event_controller
			create l_joueur.make
			joueurs.extend (l_joueur)
			les_paquets_carte.placer_carte_centre (engin_jeu.controlleur_jeu)
			les_paquets_carte.donner_carte_debut (joueurs)
			engin_jeu.fenetre_principale.set_image_affichee_plateau
			engin_jeu.fenetre_principale.afficher_fenetre_jeu (engin_jeu.controlleur_jeu)
			engin_jeu.engin_sonore.set_sound (engin_jeu.controlleur_jeu)
			engin_jeu.controlleur_jeu.event_controller.on_iteration.extend (agent update_ecran_jeu)
			engin_jeu.controlleur_jeu.event_controller.on_quit_signal.extend (agent engin_jeu.on_quit)
			engin_jeu.controlleur_jeu.flip_screen
			engin_jeu.controlleur_jeu.launch
		end

	update_ecran_jeu
			-- Boucle principale du jeu
		do
			engin_jeu.fenetre_principale.plateau_de_jeu.afficher_carte_joueur_principal (engin_jeu.controlleur_jeu, joueurs.first)
			engin_jeu.fenetre_principale.plateau_de_jeu.afficher_carte_autre_joueur (engin_jeu.controlleur_jeu, joueurs)
			engin_jeu.fenetre_principale.plateau_de_jeu.afficher_carte_centre (engin_jeu.controlleur_jeu, les_paquets_carte.paquet_carte_jouee.last.image)
			engin_jeu.engin_sonore.mise_a_jour
		end

	set_engin_jeu (a_engin_jeu: ENGIN_DE_JEU)
			-- Assignation de l'atribut `engin_jeu' à partir d'un {ENGIN_DE_JEU}
		do
			engin_jeu := a_engin_jeu
		end

end
