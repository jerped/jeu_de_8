note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_010
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{PLATEAU}.afficher_carte_joueur_principal"
		local
			v_1: detachable ANY
			v_11: PLATEAU
			v_12: detachable ANY
		do
			v_1 := Void
			execute_safe (agent: PLATEAU
				do
					create {PLATEAU} Result.make
				end)
			check attached {PLATEAU} last_object as l_ot1 then
				v_11 := l_ot1
			end
			execute_safe (agent v_11.image_carte_endos)
			v_12 := last_object

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_11.afficher_carte_joueur_principal (Void, Void))
		end

end

