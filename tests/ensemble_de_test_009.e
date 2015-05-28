note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	ENSEMBLE_DE_TEST_009
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{PLATEAU}.afficher_carte_centre"
		local
			v_1: detachable ANY
			v_4: PLATEAU
			v_5: INTEGER_32
			v_6: INTEGER_32
			v_7: INTEGER_32
			v_8: BOOLEAN
			v_9: GAME_SURFACE
		do
			v_1 := Void
			execute_safe (agent: PLATEAU
				do
					create {PLATEAU} Result.make
				end)
			check attached {PLATEAU} last_object as l_ot1 then
				v_4 := l_ot1
			end
			v_5 := {INTEGER_32} -1
			v_6 := {INTEGER_32} -2
			v_7 := {INTEGER_32} 6
			v_8 := True
			execute_safe (agent (a_arg1: INTEGER_32; a_arg2: INTEGER_32; a_arg3: INTEGER_32; a_arg4: BOOLEAN): GAME_SURFACE
				do
					create {GAME_SURFACE} Result.make_with_bit_per_pixel (a_arg1, a_arg2, a_arg3, a_arg4)
				end (v_5, v_6, v_7, v_8))
			check attached {GAME_SURFACE} last_object as l_ot2 then
				v_9 := l_ot2
			end

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_4.afficher_carte_centre (Void, v_9))
		end

end

