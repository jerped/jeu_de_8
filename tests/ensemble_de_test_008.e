note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_008
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{APPLICATION}.make"
		local
			v_1: detachable ANY
			v_2: INTEGER_32
			v_3: ARRAYED_LIST [INTEGER_32]
			v_4: FENETRE
			v_5: CHANDELLE
			v_6: GAME_SURFACE_IMG_FILE
			v_7: INTEGER_32
			v_8: CARTE_BASE
			v_9: ECRAN_JEU
			v_10: detachable ANY
			v_11: GAME_LIB_CONTROLLER
			v_12: ENGIN_DE_RESEAU
			v_13: detachable ANY
			v_14: PLATEAU
			v_15: INTEGER_32
			v_16: JOKER
			v_17: INTEGER_32
			v_18: CARTE_1
			v_19: INTEGER_32
			v_20: ENGIN_DE_RESEAU
			v_21: BOOLEAN
			v_22: ARRAYED_LIST [INTEGER_32]
			v_23: ENGIN_DE_RESEAU
			v_24: INTEGER_32
			v_25: ARRAYED_LIST [INTEGER_32]
			v_26: FENETRE
			v_27: detachable ANY
			v_28: GAME_SURFACE_IMG_FILE
			v_29: INTEGER_32
			v_30: CARTE_BASE
			v_31: ENGIN_DE_JEU
			v_32: FENETRE
			v_33: PLATEAU
			v_34: INTEGER_32
			v_35: INTEGER_32
			v_36: CARTE_11
			v_37: GAME_SURFACE_IMG_FILE
			v_38: NATURAL_64
			v_39: BOOLEAN
			v_40: APPLICATION
		do
			v_1 := Void
			v_2 := {INTEGER_32} -4
			execute_safe (agent (a_arg1: INTEGER_32): ARRAYED_LIST [INTEGER_32]
				do
					create {ARRAYED_LIST [INTEGER_32]} Result.make (a_arg1)
				end (v_2))
			check attached {ARRAYED_LIST [INTEGER_32]} last_object as l_ot1 then
				v_3 := l_ot1
			end
			execute_safe (agent (a_arg1: NONE): FENETRE
				do
					create {FENETRE} Result.make_fenetre_principale (a_arg1)
				end (Void))
			check attached {FENETRE} last_object as l_ot2 then
				v_4 := l_ot2
			end
			execute_safe (agent v_4.set_image_affichee_plateau)
			execute_safe (agent: CHANDELLE
				do
					create {CHANDELLE} Result.make
				end)
			check attached {CHANDELLE} last_object as l_ot3 then
				v_5 := l_ot3
			end
			execute_safe (agent v_5.image2)
			check attached {GAME_SURFACE_IMG_FILE} last_object as l_ot4 then
				v_6 := l_ot4
			end
			v_7 := {INTEGER_32} -4
			execute_safe (agent (a_arg1: INTEGER_32): CARTE_BASE
				do
					create {CARTE_BASE} Result.make (a_arg1)
				end (v_7))
			check attached {CARTE_BASE} last_object as l_ot5 then
				v_8 := l_ot5
			end
			execute_safe (agent (a_arg1: NONE): ECRAN_JEU
				do
					create {ECRAN_JEU} Result.make (a_arg1)
				end (Void))
			check attached {ECRAN_JEU} last_object as l_ot6 then
				v_9 := l_ot6
			end
			execute_safe (agent v_9.joueurs)
			v_10 := last_object
			execute_safe (agent: GAME_LIB_CONTROLLER
				do
					create {GAME_LIB_CONTROLLER} Result.make
				end)
			check attached {GAME_LIB_CONTROLLER} last_object as l_ot7 then
				v_11 := l_ot7
			end
			execute_safe (agent v_4.afficher_fenetre_jeu (v_11))
			execute_safe (agent: ENGIN_DE_RESEAU
				do
					create {ENGIN_DE_RESEAU} Result.make
				end)
			check attached {ENGIN_DE_RESEAU} last_object as l_ot8 then
				v_12 := l_ot8
			end
			execute_safe (agent v_12.recevoir_nombre)
			execute_safe (agent v_12.liste_carte)
			v_13 := last_object
			execute_safe (agent: PLATEAU
				do
					create {PLATEAU} Result.make
				end)
			check attached {PLATEAU} last_object as l_ot9 then
				v_14 := l_ot9
			end
			execute_safe (agent v_14.afficher_chandelle (v_11))
			v_15 := {INTEGER_32} -1
			execute_safe (agent (a_arg1: INTEGER_32): JOKER
				do
					create {JOKER} Result.make (a_arg1)
				end (v_15))
			check attached {JOKER} last_object as l_ot10 then
				v_16 := l_ot10
			end
			v_17 := {INTEGER_32} 8
			execute_safe (agent (a_arg1: INTEGER_32): CARTE_1
				do
					create {CARTE_1} Result.make (a_arg1)
				end (v_17))
			check attached {CARTE_1} last_object as l_ot11 then
				v_18 := l_ot11
			end
			execute_safe (agent v_18.numero)
			check attached {INTEGER_32} last_integer_32 as l_ot12 then
				v_19 := l_ot12
			end
			execute_safe (agent: ENGIN_DE_RESEAU
				do
					create {ENGIN_DE_RESEAU} Result.make
				end)
			check attached {ENGIN_DE_RESEAU} last_object as l_ot13 then
				v_20 := l_ot13
			end
			execute_safe (agent v_20.est_serveur)
			check attached {BOOLEAN} last_boolean as l_ot14 then
				v_21 := l_ot14
			end
			execute_safe (agent (a_arg1: NONE): ARRAYED_LIST [INTEGER_32]
				do
					create {ARRAYED_LIST [INTEGER_32]} Result.make_from_array (a_arg1)
				end (Void))
			check attached {ARRAYED_LIST [INTEGER_32]} last_object as l_ot15 then
				v_22 := l_ot15
			end
			execute_safe (agent: ENGIN_DE_RESEAU
				do
					create {ENGIN_DE_RESEAU} Result.make
				end)
			check attached {ENGIN_DE_RESEAU} last_object as l_ot16 then
				v_23 := l_ot16
			end
			v_24 := {INTEGER_32} 7
			execute_safe (agent (a_arg1: INTEGER_32): ARRAYED_LIST [INTEGER_32]
				do
					create {ARRAYED_LIST [INTEGER_32]} Result.make_filled (a_arg1)
				end (v_24))
			check attached {ARRAYED_LIST [INTEGER_32]} last_object as l_ot17 then
				v_25 := l_ot17
			end
			execute_safe (agent v_23.envoyer_paquet_carte (v_25))
			execute_safe (agent v_12.launch)
			execute_safe (agent v_20.execute)
			execute_safe (agent (a_arg1: NONE): FENETRE
				do
					create {FENETRE} Result.make_fenetre_principale (a_arg1)
				end (Void))
			check attached {FENETRE} last_object as l_ot18 then
				v_26 := l_ot18
			end
			execute_safe (agent v_26.image_affichee)
			v_27 := last_object
			execute_safe (agent v_5.image3)
			check attached {GAME_SURFACE_IMG_FILE} last_object as l_ot19 then
				v_28 := l_ot19
			end
			v_29 := {INTEGER_32} -1
			execute_safe (agent (a_arg1: INTEGER_32): CARTE_BASE
				do
					create {CARTE_BASE} Result.make (a_arg1)
				end (v_29))
			check attached {CARTE_BASE} last_object as l_ot20 then
				v_30 := l_ot20
			end
			execute_safe (agent: ENGIN_DE_JEU
				do
					create {ENGIN_DE_JEU} Result.make
				end)
			check attached {ENGIN_DE_JEU} last_object as l_ot21 then
				v_31 := l_ot21
			end
			execute_safe (agent v_31.on_quit)
			execute_safe (agent (a_arg1: GAME_LIB_CONTROLLER): FENETRE
				do
					create {FENETRE} Result.make_fenetre_principale (a_arg1)
				end (v_11))
			check attached {FENETRE} last_object as l_ot22 then
				v_32 := l_ot22
			end
			execute_safe (agent v_32.plateau_de_jeu)
			check attached {PLATEAU} last_object as l_ot23 then
				v_33 := l_ot23
			end
			execute_safe (agent v_12.un_numero_carte_recu)
			check attached {INTEGER_32} last_integer_32 as l_ot24 then
				v_34 := l_ot24
			end
			v_35 := {INTEGER_32} 4
			execute_safe (agent (a_arg1: INTEGER_32): CARTE_11
				do
					create {CARTE_11} Result.make (a_arg1)
				end (v_35))
			check attached {CARTE_11} last_object as l_ot25 then
				v_36 := l_ot25
			end
			execute_safe (agent v_36.image)
			check attached {GAME_SURFACE_IMG_FILE} last_object as l_ot26 then
				v_37 := l_ot26
			end
			v_38 := {NATURAL_64} 129
			execute_safe (agent v_23.join_with_timeout (v_38))
			check attached {BOOLEAN} last_boolean as l_ot27 then
				v_39 := l_ot27
			end

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent: APPLICATION
				do
					create {APPLICATION} Result.make
				end)
			check attached {APPLICATION} last_object as l_ot28 then
				v_40 := l_ot28
			end
		end

end

