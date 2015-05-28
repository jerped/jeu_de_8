note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_020
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{CARTE_11}.make"
		local
			v_5: INTEGER_32
			v_6: CARTE_11
		do
			v_5 := {INTEGER_32} 0

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent (a_arg1: INTEGER_32): CARTE_11
				do
					create {CARTE_11} Result.make (a_arg1)
				end (v_5))
			check attached {CARTE_11} last_object as l_ot1 then
				v_6 := l_ot1
			end
		end

end

