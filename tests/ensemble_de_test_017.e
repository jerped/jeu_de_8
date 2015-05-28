note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_017
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{PLATEAU}.afficher_carte_autre_joueur"
		local
			v_1: detachable ANY
			v_7: PLATEAU
			v_8: detachable ANY
		do
			v_1 := Void
			execute_safe (agent: PLATEAU
				do
					create {PLATEAU} Result.make
				end)
			check attached {PLATEAU} last_object as l_ot1 then
				v_7 := l_ot1
			end
			execute_safe (agent v_7.une_chandelle)
			v_8 := last_object

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_7.afficher_carte_autre_joueur (Void, Void))
		end

end

