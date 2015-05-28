note
	description: "Écran titre du jeu"
	author: "Jérémi Pedneault"
	date: "12-02-2015"

class
	ECRAN_TITRE

create
	make

feature {NONE} -- Initialization

	make (a_engin_jeu: ENGIN_DE_JEU)
			-- Initialization for `Current'.
		do
			if a_engin_jeu /= Void then
				set_engin_jeu (a_engin_jeu)
				create liste_boutons.make (3)
				liste_boutons.extend (1)
				liste_boutons.extend (2)
				create font_normal.make ("./ressources/arial.ttf", 18)
				create font_gros.make ("./ressources/arial.ttf", 30)
			end
		end

feature -- Attribut

	doit_demarrer_jeu:BOOLEAN
			-- si le jeu doit démarrer

feature {NONE} -- Attribut local

	engin_jeu: ENGIN_DE_JEU
			-- l'{ENGIN_DE_JEU} qui gère les event et autres.

	doit_rejoindre: BOOLEAN
			-- si l'option de l'Adresse IP doit apparaître

	doit_attendre_connexion: BOOLEAN
			-- si le jeu doit attendre une connexion

	liste_boutons: ARRAYED_LIST [INTEGER]
			-- une liste pour pouvoir changer de boutons

	font_normal: GAME_FONT
			-- la police pour les textes de taille normale

	font_gros: GAME_FONT
			-- La police pour les textes de grande taille

feature -- Operations

	run_ecran_titre
			-- Gestion de l'écran titre et du démarrage du jeu
		do
			engin_jeu.fenetre_principale.set_image_affichee_avec_lien ("./ressources/images/Loading.png")
			engin_jeu.fenetre_principale.afficher_fenetre_jeu (engin_jeu.controlleur_jeu)
			engin_jeu.controlleur_jeu.event_controller.on_quit_signal.extend (agent engin_jeu.on_quit)
			engin_jeu.controlleur_jeu.event_controller.enable_keyboard_unicode
			engin_jeu.controlleur_jeu.event_controller.on_key_down.extend (agent on_key_down(?))
			engin_jeu.controlleur_jeu.event_controller.on_iteration.extend (agent update_ecran_titre)
			engin_jeu.controlleur_jeu.event_controller.on_iteration.extend (agent attendre_connexion)
			engin_jeu.controlleur_jeu.launch
		end

	on_key_down (kb_event: GAME_KEYBOARD_EVENT)
			-- Gestion des touches. Redirige dans les bonnes fonctions selon la touche appuyée dans `kb_event'.
		do
			if not doit_attendre_connexion then
				if kb_event.is_down_key then
					if not liste_boutons.after then
						liste_boutons.forth
					end
				elseif kb_event.is_up_key then
					if not liste_boutons.before then
						liste_boutons.back
					end
				elseif kb_event.is_return_key or kb_event.is_kp_enter_key then
					if liste_boutons.index = 0 then -- Héberger une partie
						doit_attendre_connexion := True
					elseif liste_boutons.index = 1 then -- Rejoindre une partie
						doit_rejoindre := True
						liste_boutons.extend (2)
					elseif liste_boutons.index = 2 then -- Entrer l'adresse IP et rejoindre
						if is_ip_valide then
							creer_client
						end
					end
				elseif liste_boutons.index = 2 then -- Redirige vers l'entrée des lettres au clavier
					inscrire_ip (kb_event.character)
				end
				update_ecran_titre
			end
		end

	creer_client
			-- Crée l'application et la connecte au serveur.
		do
			engin_jeu.engin_reseau.creer_client (engin_jeu.adresse_ip)
			engin_jeu.controlleur_jeu.clear_event_controller
			engin_jeu.controlleur_jeu.stop
			doit_demarrer_jeu := True
		end

	attendre_connexion
			-- Si l'utilisateur décide d'héberger une partie, démarre le serveur et le met en attente.
		do
			if doit_attendre_connexion then
				demarrer_serveur
			end
		end

	demarrer_serveur
			-- Démarre le serveur tout en s'assurant de vider l'event controller pour ne pas faire planter le logiciel
		do
			engin_jeu.engin_reseau.creer_serveur
			engin_jeu.engin_reseau.doit_attendre_client:=True
			engin_jeu.engin_reseau.launch
			engin_jeu.controlleur_jeu.clear_event_controller
			engin_jeu.controlleur_jeu.event_controller.on_quit_signal.extend (agent engin_jeu.on_quit)
			engin_jeu.controlleur_jeu.event_controller.on_iteration.extend (agent surveiller_connexion)
			engin_jeu.controlleur_jeu.launch
			engin_jeu.engin_reseau.join
		end

	surveiller_connexion
			-- s'assure de fermer le processus une fois la connexion établie
		do
			if engin_jeu.engin_reseau.est_connecte then
				engin_jeu.engin_reseau.yield
				engin_jeu.controlleur_jeu.clear_event_controller
				engin_jeu.controlleur_jeu.stop
				doit_demarrer_jeu := True
			end
		end

	is_ip_valide: BOOLEAN
			-- Vérification du format de l'adresse IP entrée pas l'utilisateur.
			-- retourne `True' si elle est valide, `False' dans le cas contraire.
		local
			l_regEx: RX_PCRE_MATCHER
		do
			create l_regex.make
			l_regex.compile ("^([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])$")
				-- Règle {REGEX} provient du site http://www.mkyong.com/regular-expressions/how-to-validate-ip-address-with-regular-expression/
			if l_regex.is_compiled then
				l_regex.match (engin_jeu.adresse_ip)
				if l_regex.has_matched then
					result := true
				else
					result := false
				end
			end
		end

	inscrire_ip (a_character: CHARACTER_32)
			-- Gestion des touches du clavier numérique uniquement lors de l'entrée
			-- de l'adresse IP à partir d'un {CHARACTER_32}
		do
			if a_character = '%B' then
				engin_jeu.adresse_ip.remove_tail (1)
			else
				if a_character /= '%U' and a_character.is_digit or a_character = '.' or a_character = ':' then
					engin_jeu.adresse_ip.append_character (a_character)
				end
			end
		end

	update_ecran_titre
			-- À chaque boucle de l'application, réafiche toutes les {GAME_SURFACE}
			-- de l'écran titre
		local
			l_texte_start: STRING_32
			l_texte_titre: STRING_32
			l_texte_multiplayer: STRING_32
			l_texte_adresse_ip: STRING_32
			l_texte_attente: STRING_32
			l_couleur_texte_start: GAME_COLOR
			l_couleur_texte_ip: GAME_COLOR
			l_couleur_texte_multiplayer: GAME_COLOR
			l_couleur_texte_titre: GAME_COLOR
			l_couleur_texte_attente: GAME_COLOR
			l_zone_texte_start: GAME_SURFACE
			l_zone_texte_titre: GAME_SURFACE
			l_zone_texte_multiplayer: GAME_SURFACE
			l_zone_texte_ip: GAME_SURFACE
			l_zone_texte_attente: GAME_SURFACE
		do
				-- Création des couleurs du texte.
			create l_couleur_texte_titre.make_rgb (255, 255, 255)
			create l_couleur_texte_start.make_rgb (255, 255, 255)
			create l_couleur_texte_ip.make_rgb (255, 255, 255)
			create l_couleur_texte_multiplayer.make_rgb (255, 255, 255)
			create l_couleur_texte_attente.make_rgb (50, 220, 0)

				-- Affichage de l'emplacement de la sélection dans le menu.
				-- Change la couleur du texte selon l'emplacement.
			if liste_boutons.index = 0 then
				l_couleur_texte_start.blue := 0
				l_couleur_texte_start.red := 200
				l_couleur_texte_start.green := 0
			elseif liste_boutons.index = 1 then
				l_couleur_texte_multiplayer.blue := 0
				l_couleur_texte_multiplayer.red := 200
				l_couleur_texte_multiplayer.green := 0
			elseif liste_boutons.index = 2 then
				l_couleur_texte_ip.blue := 0
				l_couleur_texte_ip.red := 200
				l_couleur_texte_ip.green := 0
			end
			l_texte_attente := "Attente de la connexion de l'opposant"
			l_texte_titre := "Jeu de 8 en 1 vs 1"
			l_texte_multiplayer := "Rejoindre un opposant"
			l_texte_start := "Héberger une partie"
			l_texte_adresse_ip := "Adresse IP de l'opposant: "
			l_texte_adresse_ip.append (engin_jeu.adresse_ip)
			engin_jeu.fenetre_principale.afficher_fenetre_jeu (engin_jeu.controlleur_jeu)
			l_zone_texte_titre:= create {GAME_SURFACE_TEXT}.make_blended (l_texte_titre, font_gros, l_couleur_texte_titre)
			l_zone_texte_start:= create {GAME_SURFACE_TEXT}.make_blended (l_texte_start, font_normal, l_couleur_texte_start)
			l_zone_texte_ip:= create {GAME_SURFACE_TEXT}.make_blended (l_texte_adresse_ip, font_normal, l_couleur_texte_ip)
			l_zone_texte_multiplayer:= create {GAME_SURFACE_TEXT}.make_blended (l_texte_multiplayer, font_normal, l_couleur_texte_multiplayer)
			l_zone_texte_attente:= create {GAME_SURFACE_TEXT}.make_blended (l_texte_attente, font_gros, l_couleur_texte_attente)
			engin_jeu.controlleur_jeu.screen_surface.draw_surface (l_zone_texte_multiplayer, 125, 200)
			engin_jeu.controlleur_jeu.screen_surface.draw_surface (l_zone_texte_start, 125, 150)
			engin_jeu.controlleur_jeu.screen_surface.draw_surface (l_zone_texte_titre, 300, 100)
			if doit_attendre_connexion then
				engin_jeu.controlleur_jeu.screen_surface.draw_surface (l_zone_texte_attente, 200, 400)
			end
			if doit_rejoindre = TRUE then -- Ajoute le texte pour l'adresse IP si le joueur a fais rejoindre une partie.
				engin_jeu.controlleur_jeu.screen_surface.draw_surface (l_zone_texte_ip, 135, 250)
			end
			engin_jeu.controlleur_jeu.flip_screen
		end

	set_engin_jeu (a_engin_jeu: ENGIN_DE_JEU)
			-- Assignement de l'`engin_jeu' avec la valeur `a_engin_jeu'.
		do
			engin_jeu := a_engin_jeu
		end

end
