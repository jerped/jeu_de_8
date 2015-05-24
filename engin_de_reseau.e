note
	description: "Summary description for {ENGIN_DE_RESEAU}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
			make_thread
			est_connecte := False
		end

feature {NONE} -- Attributs locaux

	serveur_socket: NETWORK_STREAM_SOCKET
			-- {SOCKET} du serveur pour l'application serveur

	serveur_client_socket: NETWORK_STREAM_SOCKET
			-- {SOCKET} du client pour l'application serveur

	client_socket: NETWORK_STREAM_SOCKET
			-- {SOCKET} du client pour l'application client

feature -- Attributs

	est_connecte: BOOLEAN
			-- pour savoir si l'application s'est connectée au serveur ou au client

	est_serveur: BOOLEAN
			-- pour savoir si l'application est le serveur ou non

feature -- Operations

	creer_serveur
			-- crée le `serveur_socket' du serveur
		do
			create serveur_socket.make_server_by_port (25565)
		end

	execute
			-- démarre un nouveau thread pour le serveur qui attend une connexion.
			-- une fois connecté, crée le `serveur_client_socket' du serveur
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

	creer_client (une_adresse_ip: STRING_32)
			-- crée le `client_socket' pour l'application client.
			-- Reçoit `une_adrese_ip' qui représente l'adresse du serveur.
		local
			l_factory_adresse: INET_ADDRESS_FACTORY
			l_adresse: INET_ADDRESS
		do
			create l_factory_adresse
			l_adresse := l_factory_adresse.create_from_name (une_adresse_ip)
			create client_socket.make_client_by_address_and_port (l_adresse, 25565)
			client_socket.connect
			if client_socket.is_connected then
				est_connecte := True
				est_serveur := False
			end
		end

	recevoir_paquet_carte: ARRAYED_LIST [INTEGER]
			-- Le client qui reçoit la liste pour créer un paquet de carte.
			-- Retourne une liste contenant les id des cartes
		local
			l_liste_id_carte: ARRAYED_LIST [INTEGER]
		do
			create l_liste_id_carte.make (54)
			from
			until
				l_liste_id_carte.count = 54
			loop
				client_socket.read_integer
				l_liste_id_carte.extend (client_socket.last_integer)
			end
			result := l_liste_id_carte
		end

	envoyer_paquet_carte (une_liste_id_carte: ARRAYED_LIST [INTEGER])
			-- Le serveur qui envoie la liste des id des cartes au client
			-- Reçoit `une_liste_id_carte' qui contient les id de chaque cartes.
		do
			from
				une_liste_id_carte.start
			until
				une_liste_id_carte.islast
			loop
				serveur_client_socket.put_integer (une_liste_id_carte.item)
				une_liste_id_carte.forth
			end
		end

	envoyer_carte (a_id_carte: INTEGER)
			-- gère l'envoie d'une carte entre les joueurs.
			-- reçoit l'id de la carte jouée lors du tour précédent.
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

	recevoir_carte: INTEGER
			-- gère la réception d'une carte entre les joueurs.
			-- Retourne l'id de la carte jouée lors du tour précédent.
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			if est_serveur then
				l_socket := serveur_client_socket
			else
				l_socket := client_socket
			end
			l_socket.read_integer
			result := l_socket.last_integer
		end

end
