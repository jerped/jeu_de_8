note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_005
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{PLATEAU}.afficher_chandelle"
		local
			v_11: GAME_LIB_CONTROLLER
			v_14: PLATEAU
		do
			execute_safe (agent: GAME_LIB_CONTROLLER
				do
					create {GAME_LIB_CONTROLLER} Result.make
				end)
			check attached {GAME_LIB_CONTROLLER} last_object as l_ot1 then
				v_11 := l_ot1
			end
			execute_safe (agent: PLATEAU
				do
					create {PLATEAU} Result.make
				end)
			check attached {PLATEAU} last_object as l_ot2 then
				v_14 := l_ot2
			end

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_14.afficher_chandelle (v_11))
		end

end

