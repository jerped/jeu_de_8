note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_014
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{ECRAN_TITRE}.surveiller_connexion"
		local
			v_1: detachable ANY
			v_4: ECRAN_TITRE
		do
			v_1 := Void
			execute_safe (agent (a_arg1: NONE): ECRAN_TITRE
				do
					create {ECRAN_TITRE} Result.make (a_arg1)
				end (Void))
			check attached {ECRAN_TITRE} last_object as l_ot1 then
				v_4 := l_ot1
			end

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_4.surveiller_connexion)
		end

end

