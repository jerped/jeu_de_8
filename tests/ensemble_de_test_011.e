note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_011
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{ARRAYED_LIST}.make_filled"
		local
			v_15: INTEGER_32
			v_16: ARRAYED_LIST [JOUEUR]
		do
			v_15 := {INTEGER_32} -2

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent (a_arg1: INTEGER_32): ARRAYED_LIST [JOUEUR]
				do
					create {ARRAYED_LIST [JOUEUR]} Result.make_filled (a_arg1)
				end (v_15))
			check attached {ARRAYED_LIST [JOUEUR]} last_object as l_ot1 then
				v_16 := l_ot1
			end
		end

end

