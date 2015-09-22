note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	CONVERTER_LOGIC_TEST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_is_ready_to_convert_valid
		do
			assert ("is_valid_to_convert correct", True)
		end

	test_is_ready_to_convert_invalid
		do
			assert ("is_valid_to_convert correct", False)
		end

end


