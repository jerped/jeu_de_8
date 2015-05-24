note
	description : "Classe abstraite CARTE"
	author      : "Jérémi Pedneault"
	date        : "12-02-2015"

class
	ENGIN_DE_JEU

create
	make

feature {NONE}-- Initialization
	make
			-- Initialization for `Current'.
		do
			create controlleur_jeu.make
			create controlleur_image.make
			create controlleur_texte.make
			create engin_sonore.make
			create engin_reseau.make

			controlleur_jeu.enable_video
			controlleur_texte.enable_text
			controlleur_image.enable_image (true, false, false)

			create fenetre_principale.make_fenetre_principale (controlleur_jeu)
		end

feature -- Attributs
	controlleur_jeu: GAME_LIB_CONTROLLER
		-- le controlleur des event du jeu
	controlleur_image: GAME_IMG_CONTROLLER
		-- le controlleur des images du jeu
	controlleur_texte: GAME_TEXT_CONTROLLER
		-- le controlleur des textes du jeu
	engin_sonore:ENGIN_DE_SON
		-- le gestionnaire de sons pour le jeu
	engin_reseau:ENGIN_DE_RESEAU
		-- le gestionnaire de réseau pour le jeu
	adresse_ip:STRING_32=""
		-- l'adresse IP de l'opposant
	fenetre_principale: FENETRE
		-- la fenêtre de travail pour le jeu

feature -- Operations
	on_quit
		do
			controlleur_jeu.stop
		end

end
