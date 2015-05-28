note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_015
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{STRING_8}.make_from_c_pointer"
		local
			v_6: POINTER
			v_7: STRING_8
		do
			v_6 := default_pointer

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent (a_arg1: POINTER): STRING_8
				do
					create {STRING_8} Result.make_from_c_pointer (a_arg1)
				end (v_6))
			check attached {STRING_8} last_object as l_ot1 then
				v_7 := l_ot1
			end
		end

end

