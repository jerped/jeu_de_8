note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_006
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{ARRAYED_LIST}.make_from_array"
		local
			v_1: detachable ANY
			v_22: ARRAYED_LIST [INTEGER_32]
		do
			v_1 := Void

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent (a_arg1: NONE): ARRAYED_LIST [INTEGER_32]
				do
					create {ARRAYED_LIST [INTEGER_32]} Result.make_from_array (a_arg1)
				end (Void))
			check attached {ARRAYED_LIST [INTEGER_32]} last_object as l_ot1 then
				v_22 := l_ot1
			end
		end

end

