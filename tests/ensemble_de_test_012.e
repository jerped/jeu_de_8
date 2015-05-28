note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_012
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{ENGIN_DE_JEU}.make"
		local
			v_1: detachable ANY
			v_2: INTEGER_32
			v_3: CARTE_1
			v_4: PLATEAU
			v_5: INTEGER_32
			v_6: INTEGER_32
			v_7: INTEGER_32
			v_8: BOOLEAN
			v_9: GAME_SURFACE
			v_10: GAME_SURFACE_IMG_FILE
			v_11: PLATEAU
			v_12: GAME_SURFACE_IMG_FILE
			v_13: INTEGER_32
			v_14: CARTE_1
			v_15: INTEGER_32
			v_16: ARRAYED_LIST [JOUEUR]
			v_17: ENGIN_DE_SON
			v_18: AUDIO_CONTROLLER
			v_19: ENGIN_DE_JEU
		do
			v_1 := Void
			v_2 := {INTEGER_32} -2
			execute_safe (agent (a_arg1: INTEGER_32): CARTE_1
				do
					create {CARTE_1} Result.make (a_arg1)
				end (v_2))
			check attached {CARTE_1} last_object as l_ot1 then
				v_3 := l_ot1
			end
			execute_safe (agent: PLATEAU
				do
					create {PLATEAU} Result.make
				end)
			check attached {PLATEAU} last_object as l_ot2 then
				v_4 := l_ot2
			end
			v_5 := {INTEGER_32} -1
			v_6 := {INTEGER_32} -2
			v_7 := {INTEGER_32} 6
			v_8 := True
			execute_safe (agent (a_arg1: INTEGER_32; a_arg2: INTEGER_32; a_arg3: INTEGER_32; a_arg4: BOOLEAN): GAME_SURFACE
				do
					create {GAME_SURFACE} Result.make_with_bit_per_pixel (a_arg1, a_arg2, a_arg3, a_arg4)
				end (v_5, v_6, v_7, v_8))
			check attached {GAME_SURFACE} last_object as l_ot3 then
				v_9 := l_ot3
			end
			execute_safe (agent v_4.afficher_carte_centre (Void, v_9))
			execute_safe (agent v_4.image_curseur)
			check attached {GAME_SURFACE_IMG_FILE} last_object as l_ot4 then
				v_10 := l_ot4
			end
			execute_safe (agent: PLATEAU
				do
					create {PLATEAU} Result.make
				end)
			check attached {PLATEAU} last_object as l_ot5 then
				v_11 := l_ot5
			end
			execute_safe (agent v_11.image_carte_endos)
			check attached {GAME_SURFACE_IMG_FILE} last_object as l_ot6 then
				v_12 := l_ot6
			end
			v_13 := {INTEGER_32} -5
			execute_safe (agent (a_arg1: INTEGER_32): CARTE_1
				do
					create {CARTE_1} Result.make (a_arg1)
				end (v_13))
			check attached {CARTE_1} last_object as l_ot7 then
				v_14 := l_ot7
			end
			execute_safe (agent v_11.afficher_carte_joueur_principal (Void, Void))
			v_15 := {INTEGER_32} -2
			execute_safe (agent (a_arg1: INTEGER_32): ARRAYED_LIST [JOUEUR]
				do
					create {ARRAYED_LIST [JOUEUR]} Result.make_filled (a_arg1)
				end (v_15))
			check attached {ARRAYED_LIST [JOUEUR]} last_object as l_ot8 then
				v_16 := l_ot8
			end
			execute_safe (agent: ENGIN_DE_SON
				do
					create {ENGIN_DE_SON} Result.make
				end)
			check attached {ENGIN_DE_SON} last_object as l_ot9 then
				v_17 := l_ot9
			end
			execute_safe (agent v_17.controlleur_son)
			check attached {AUDIO_CONTROLLER} last_object as l_ot10 then
				v_18 := l_ot10
			end

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent: ENGIN_DE_JEU
				do
					create {ENGIN_DE_JEU} Result.make
				end)
			check attached {ENGIN_DE_JEU} last_object as l_ot11 then
				v_19 := l_ot11
			end
		end

end

