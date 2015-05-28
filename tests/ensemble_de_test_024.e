note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_024
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{ECRAN_JEU}.make"
		local
			v_2: ENGIN_DE_JEU
			v_3: ECRAN_JEU
		do
			execute_safe (agent: ENGIN_DE_JEU
				do
					create {ENGIN_DE_JEU} Result.make
				end)
			check attached {ENGIN_DE_JEU} last_object as l_ot1 then
				v_2 := l_ot1
			end

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent (a_arg1: ENGIN_DE_JEU): ECRAN_JEU
				do
					create {ECRAN_JEU} Result.make (a_arg1)
				end (v_2))
			check attached {ECRAN_JEU} last_object as l_ot2 then
				v_3 := l_ot2
			end
		end

end

