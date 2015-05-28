note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_023
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{ENGIN_DE_RESEAU}.creer_client"
		local
			v_1: detachable ANY
			v_15: ENGIN_DE_RESEAU
		do
			v_1 := Void
			execute_safe (agent: ENGIN_DE_RESEAU
				do
					create {ENGIN_DE_RESEAU} Result.make
				end)
			check attached {ENGIN_DE_RESEAU} last_object as l_ot1 then
				v_15 := l_ot1
			end

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_15.creer_client (Void))
		end

end

