note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_018
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{ENGIN_DE_SON}.jouer_effet"
		local
			v_5: ENGIN_DE_JEU
			v_6: detachable ANY
			v_9: ENGIN_DE_SON
		do
			execute_safe (agent: ENGIN_DE_JEU
				do
					create {ENGIN_DE_JEU} Result.make
				end)
			check attached {ENGIN_DE_JEU} last_object as l_ot1 then
				v_5 := l_ot1
			end
			execute_safe (agent v_5.controlleur_texte)
			v_6 := last_object
			execute_safe (agent v_5.engin_sonore)
			check attached {ENGIN_DE_SON} last_object as l_ot2 then
				v_9 := l_ot2
			end

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_9.jouer_effet)
		end

end

