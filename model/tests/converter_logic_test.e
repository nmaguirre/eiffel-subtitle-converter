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
		local
			passed: BOOLEAN
			converter : CONVERTER_LOGIC
			subtitle: MICRODVD_SUBTITLE
		do
			create converter.make
			create subtitle.make
			subtitle.add_subtitle_item(1,2,"texto")
			passed := (converter.source /= Void)
			assert ("is_ready_to_convert correct", passed = True)
		end

	test_is_ready_to_convert_invalid
		local
			passed: BOOLEAN
			converter: CONVERTER_LOGIC
		do
			create converter.make
			passed := (converter.source /= Void)
			assert ("is_ready_to_convert correct", passed = False)
		end

end


