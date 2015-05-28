note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_019
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{ENGIN_DE_SON}.make"
		local
			v_1: detachable ANY
			v_2: INTEGER_32
			v_3: JOKER
			v_4: INTEGER_32
			v_5: ENGIN_DE_JEU
			v_6: GAME_TEXT_CONTROLLER
			v_7: PLATEAU
			v_8: CHANDELLE
			v_9: ENGIN_DE_SON
			v_10: INTEGER_32
			v_11: CARTE_1
			v_12: ENGIN_DE_RESEAU
			v_13: BOOLEAN
			v_14: ENGIN_DE_SON
		do
			v_1 := Void
			v_2 := {INTEGER_32} 1
			execute_safe (agent (a_arg1: INTEGER_32): JOKER
				do
					create {JOKER} Result.make (a_arg1)
				end (v_2))
			check attached {JOKER} last_object as l_ot1 then
				v_3 := l_ot1
			end
			execute_safe (agent v_3.valeur)
			check attached {INTEGER_32} last_integer_32 as l_ot2 then
				v_4 := l_ot2
			end
			execute_safe (agent: ENGIN_DE_JEU
				do
					create {ENGIN_DE_JEU} Result.make
				end)
			check attached {ENGIN_DE_JEU} last_object as l_ot3 then
				v_5 := l_ot3
			end
			execute_safe (agent v_5.controlleur_texte)
			check attached {GAME_TEXT_CONTROLLER} last_object as l_ot4 then
				v_6 := l_ot4
			end
			execute_safe (agent: PLATEAU
				do
					create {PLATEAU} Result.make
				end)
			check attached {PLATEAU} last_object as l_ot5 then
				v_7 := l_ot5
			end
			execute_safe (agent v_7.une_chandelle)
			check attached {CHANDELLE} last_object as l_ot6 then
				v_8 := l_ot6
			end
			execute_safe (agent v_5.engin_sonore)
			check attached {ENGIN_DE_SON} last_object as l_ot7 then
				v_9 := l_ot7
			end
			v_10 := {INTEGER_32} -4
			execute_safe (agent (a_arg1: INTEGER_32): CARTE_1
				do
					create {CARTE_1} Result.make (a_arg1)
				end (v_10))
			check attached {CARTE_1} last_object as l_ot8 then
				v_11 := l_ot8
			end
			execute_safe (agent v_7.afficher_carte_autre_joueur (Void, Void))
			execute_safe (agent: ENGIN_DE_RESEAU
				do
					create {ENGIN_DE_RESEAU} Result.make
				end)
			check attached {ENGIN_DE_RESEAU} last_object as l_ot9 then
				v_12 := l_ot9
			end
			execute_safe (agent v_12.est_connecte)
			check attached {BOOLEAN} last_boolean as l_ot10 then
				v_13 := l_ot10
			end
			execute_safe (agent v_9.jouer_effet)

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent: ENGIN_DE_SON
				do
					create {ENGIN_DE_SON} Result.make
				end)
			check attached {ENGIN_DE_SON} last_object as l_ot11 then
				v_14 := l_ot11
			end
		end

end

