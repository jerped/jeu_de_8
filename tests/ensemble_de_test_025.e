note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_025
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{PAQUET_CARTE}.creer_ordre_carte"
		local
			v_1: detachable ANY
			v_2: GAME_LIB_CONTROLLER
			v_3: PAQUET_CARTE
			v_4: detachable ANY
		do
			v_1 := Void
			execute_safe (agent: GAME_LIB_CONTROLLER
				do
					create {GAME_LIB_CONTROLLER} Result.make
				end)
			check attached {GAME_LIB_CONTROLLER} last_object as l_ot1 then
				v_2 := l_ot1
			end
			execute_safe (agent (a_arg1: GAME_LIB_CONTROLLER): PAQUET_CARTE
				do
					create {PAQUET_CARTE} Result.make (a_arg1)
				end (v_2))
			check attached {PAQUET_CARTE} last_object as l_ot2 then
				v_3 := l_ot2
			end
			execute_safe (agent v_3.paquet_central)
			v_4 := last_object

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_3.creer_ordre_carte (Void))
		end

end

