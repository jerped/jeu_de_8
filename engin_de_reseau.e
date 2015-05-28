note
	description: "Classe pour g�rer le r�seau du jeu"
	author: "J�r�mi Pedneault"
	date: "12-02-2015"


class
	ENGIN_DE_RESEAU

inherit

	THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			activer_thread
			est_connecte := False
		end

feature {NONE} -- Attributs locaux

	port: INTEGER = 25565
			-- port de connexion entre le serveur et le client

	serveur_socket: NETWORK_STREAM_SOCKET
			-- {SOCKET} du serveur pour l'application serveur

	serveur_client_socket: NETWORK_STREAM_SOCKET
			-- {SOCKET} du client pour l'application serveur

	client_socket: NETWORK_STREAM_SOCKET
			-- {SOCKET} du client pour l'application client

feature -- Attributs

	est_connecte: BOOLEAN
			-- pour savoir si l'application s'est connect�e au serveur ou au client

	est_serveur: BOOLEAN
			-- pour savoir si l'application est le serveur ou non

	liste_carte: ARRAYED_LIST [INTEGER]
			-- la liste des id des cartes recue du serveur par le client

	un_numero_carte_recu: INTEGER
			-- un id d'une carte

	un_numero: INTEGER
			-- Repr�sente le nombre de fois que le joueur doit piger.

	la_nouvelle_sorte: STRING
			-- Repr�sente la nouvelle sorte chang�e par l'autre joueur.

	une_action_recue: STRING
			-- l'action effectu�e par l'autre joueur.
			-- Valeurs possibles:  "a_pige", "jouee_carte", "passe", "quitter", "doit_piger"

	doit_attendre_client:BOOLEAN assign set_devoir_attendre
			-- Repr�sente si le serveur doit attendre une connexion d'un client ou non

feature -- Operations

	activer_thread
			-- cr�e le {THREAD} n�cessaire � la routine `execute'
		do
			make_thread
		end

	creer_serveur
			-- cr�e le `serveur_socket' du serveur
		do
			create serveur_socket.make_server_by_port (port)
		end

	execute
			-- d�marre un nouveau thread pour le serveur qui attend une connexion.
			-- une fois connect�, cr�e le `serveur_client_socket' du serveur
		do
			if doit_attendre_client then
				attendre_client
			end
		end

	attendre_client
			-- Mise en �coute du serveur pour attendre la connexion d'un client
			-- Cr�ation du `serveur_client_socket' pour le client du serveur
		do
			from
			until
				est_connecte
			loop
				serveur_socket.listen (1)
				serveur_socket.accept
				serveur_client_socket := serveur_socket.accepted
				if serveur_client_socket /= Void then
					est_connecte := True
					est_serveur := True
				end
			end
		end

	creer_client (a_adresse_ip: STRING_32)
			-- cr�e le `client_socket' pour l'application client.
			-- Re�oit `une_adrese_ip' qui repr�sente l'adresse du serveur.
		local
			l_factory_adresse: INET_ADDRESS_FACTORY
			l_adresse: INET_ADDRESS
		do
			create l_factory_adresse
			l_adresse := l_factory_adresse.create_from_name (a_adresse_ip)
			create client_socket.make_client_by_address_and_port (l_adresse, port)
			client_socket.connect
			if client_socket.is_connected then
				est_connecte := True
				est_serveur := False
			end
		end

	recevoir_paquet_carte
			-- Le client qui re�oit la liste pour cr�er un paquet de carte.
			-- Retourne une liste contenant les id des cartes
		do
			create liste_carte.make (54)
			from
			until
				liste_carte.count = 54
			loop
				client_socket.read_integer
				liste_carte.extend (client_socket.last_integer)
			end
		end

	envoyer_paquet_carte (a_liste_id_carte: ARRAYED_LIST [INTEGER])
			-- Le serveur qui envoie la liste des id des cartes au client
			-- Re�oit `une_liste_id_carte' qui contient les id de chaque cartes.
		do
			from
				a_liste_id_carte.start
			until
				a_liste_id_carte.after
			loop
				serveur_client_socket.put_integer (a_liste_id_carte.item)
				a_liste_id_carte.forth
			end
		end

	envoyer_carte (a_id_carte: INTEGER)
			-- g�re l'envoie d'une carte entre les joueurs.
			-- re�oit l'id de la carte jou�e lors du tour pr�c�dent.
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			if est_serveur then
				l_socket := serveur_client_socket
			else
				l_socket := client_socket
			end
			l_socket.put_integer (a_id_carte)
		end

	recevoir_carte
			-- G�re la r�ception d'une carte entre les joueurs.
			-- Retourne l'id de la carte jou�e lors du tour pr�c�dent.
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			if est_serveur then
				l_socket := serveur_client_socket
			else
				l_socket := client_socket
			end
			l_socket.read_integer
			un_numero_carte_recu := l_socket.last_integer
		end

	envoyer_action (a_action_faite: STRING)
			-- Envoie de l'action effectu�e par l'autre joueur.
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			if est_serveur then
				l_socket := serveur_client_socket
			else
				l_socket := client_socket
			end
			l_socket.put_string (a_action_faite)
		end

	recevoir_action
			-- R�ception de l'action ex�cut�e par l'autre joueur.
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			if est_serveur then
				l_socket := serveur_client_socket
			else
				l_socket := client_socket
			end
			l_socket.read_line
			une_action_recue := l_socket.last_string
		end

	envoyer_nombre(a_nombre:INTEGER)
			-- Envoie d'un nomdre � l'autre joueur
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			if est_serveur then
				l_socket := serveur_client_socket
			else
				l_socket := client_socket
			end
			l_socket.put_integer (a_nombre)
		end

	recevoir_nombre
			-- R�ception d'un nombre de l'autre joueur
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			if est_serveur then
				l_socket := serveur_client_socket
			else
				l_socket := client_socket
			end
			l_socket.read_integer
			un_numero := l_socket.last_integer
		end

	envoyer_sorte (a_sorte: STRING)
			-- Envoie de l'action effectu�e par l'autre joueur.
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			if est_serveur then
				l_socket := serveur_client_socket
			else
				l_socket := client_socket
			end
			l_socket.put_string (a_sorte)
		end

	recevoir_sorte
			-- R�ception de l'action ex�cut�e par l'autre joueur.
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			if est_serveur then
				l_socket := serveur_client_socket
			else
				l_socket := client_socket
			end
			l_socket.read_line
			la_nouvelle_sorte := l_socket.last_string
		end

feature {NONE} -- Assigneurs

	set_devoir_attendre(a_attente:BOOLEAN)
			-- Assigne si le serveur doit attendre la connexion d'un client ou non
			-- � la variable `doit_attendre_client'
			-- Re�oit
		do
			doit_attendre_client:=a_attente
		end

	invariant -- V�rification des attributs
		numero_invalide: un_numero <= 54 and un_numero >= 0
		numero_invalide: un_numero_carte_recu <= 54 and un_numero_carte_recu >= 0
end
