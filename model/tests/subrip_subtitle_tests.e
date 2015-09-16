note
	description: "[
		Eiffel tests for class SUBRIP_SUBTITLE.
	]"
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"
	testing: "type/manual"

class
	SUBRIP_SUBTITLE_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines

	test_valid_flush
		-- Checks that removes all items from the subtitle
		note
			testing:  "covers/{SUBRIP_SUBTITLE_TESTS}.flush"
		local
			subrip_sub:SUBRIP_SUBTITLE
			flag: BOOLEAN
		do
			create subrip_sub.make
			subrip_sub.flush
			flag:= True
			assert ("flush correct", flag = True)
		end

end-- class SUBRIP_SUBTITLE_TESTS

