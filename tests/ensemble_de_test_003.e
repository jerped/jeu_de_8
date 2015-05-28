note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_003
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{FENETRE}.afficher_fenetre_jeu"
		local
			v_1: detachable ANY
			v_4: FENETRE
			v_11: GAME_LIB_CONTROLLER
		do
			v_1 := Void
			execute_safe (agent (a_arg1: NONE): FENETRE
				do
					create {FENETRE} Result.make_fenetre_principale (a_arg1)
				end (Void))
			check attached {FENETRE} last_object as l_ot1 then
				v_4 := l_ot1
			end
			execute_safe (agent v_4.set_image_affichee_plateau)
			execute_safe (agent: GAME_LIB_CONTROLLER
				do
					create {GAME_LIB_CONTROLLER} Result.make
				end)
			check attached {GAME_LIB_CONTROLLER} last_object as l_ot2 then
				v_11 := l_ot2
			end

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_4.afficher_fenetre_jeu (v_11))
		end

end

