note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_022
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{PAQUET_CARTE}.make_avec_liste"
		local
			v_1: detachable ANY
			v_14: PAQUET_CARTE
		do
			v_1 := Void

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent (a_arg1: NONE): PAQUET_CARTE
				do
					create {PAQUET_CARTE} Result.make_avec_liste (a_arg1)
				end (Void))
			check attached {PAQUET_CARTE} last_object as l_ot1 then
				v_14 := l_ot1
			end
		end

end

