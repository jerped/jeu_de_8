note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_016
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{ECRAN_TITRE}.on_key_down"
		local
			v_2: ENGIN_DE_RESEAU
			v_3: detachable ANY
			v_10: ENGIN_DE_JEU
			v_11: ECRAN_TITRE
		do
			execute_safe (agent: ENGIN_DE_RESEAU
				do
					create {ENGIN_DE_RESEAU} Result.make
				end)
			check attached {ENGIN_DE_RESEAU} last_object as l_ot1 then
				v_2 := l_ot1
			end
			execute_safe (agent v_2.attendre_client)
			execute_safe (agent v_2.la_nouvelle_sorte)
			v_3 := last_object
			execute_safe (agent: ENGIN_DE_JEU
				do
					create {ENGIN_DE_JEU} Result.make
				end)
			check attached {ENGIN_DE_JEU} last_object as l_ot2 then
				v_10 := l_ot2
			end
			execute_safe (agent (a_arg1: ENGIN_DE_JEU): ECRAN_TITRE
				do
					create {ECRAN_TITRE} Result.make (a_arg1)
				end (v_10))
			check attached {ECRAN_TITRE} last_object as l_ot3 then
				v_11 := l_ot3
			end

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_11.on_key_down (Void))
		end

end

