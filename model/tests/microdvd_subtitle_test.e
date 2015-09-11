note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	MICRODVD_SUBTITLE_TEST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_repOk_valid_representation
			-- create a valid sequence and evaluate it with repOk
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.repOK"
		local
			item: MICRODVD_SUBTITLE
		do
			create item.make
			item.add_subtitle_item(0,100,"text 1")
			item.add_subtitle_item(101,200,"text 2")
			assert ("Subtitle representation is ok", item.repOk)
		end

end


