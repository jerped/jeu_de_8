note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_007
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{ENGIN_DE_RESEAU}.envoyer_paquet_carte"
		local
			v_23: ENGIN_DE_RESEAU
			v_24: INTEGER_32
			v_25: ARRAYED_LIST [INTEGER_32]
		do
			execute_safe (agent: ENGIN_DE_RESEAU
				do
					create {ENGIN_DE_RESEAU} Result.make
				end)
			check attached {ENGIN_DE_RESEAU} last_object as l_ot1 then
				v_23 := l_ot1
			end
			v_24 := {INTEGER_32} 7
			execute_safe (agent (a_arg1: INTEGER_32): ARRAYED_LIST [INTEGER_32]
				do
					create {ARRAYED_LIST [INTEGER_32]} Result.make_filled (a_arg1)
				end (v_24))
			check attached {ARRAYED_LIST [INTEGER_32]} last_object as l_ot2 then
				v_25 := l_ot2
			end

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_23.envoyer_paquet_carte (v_25))
		end

end

