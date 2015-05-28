note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_001
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{ARRAYED_LIST}.make"
		local
			v_2: INTEGER_32
			v_3: ARRAYED_LIST [INTEGER_32]
		do
			v_2 := {INTEGER_32} -4

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent (a_arg1: INTEGER_32): ARRAYED_LIST [INTEGER_32]
				do
					create {ARRAYED_LIST [INTEGER_32]} Result.make (a_arg1)
				end (v_2))
			check attached {ARRAYED_LIST [INTEGER_32]} last_object as l_ot1 then
				v_3 := l_ot1
			end
		end

end

