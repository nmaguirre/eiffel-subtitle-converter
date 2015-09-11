note
	description: "[
		Eiffel tests for class SUBRIP_SUBTITLE_TIME.
	]"
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"
	testing: "type/manual"

class
	SUBRIP_SUBTITLE_TIME_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines


	test_set_minute_valid
			-- set a minute correctly
		note
			testing:  "covers/{SUBRIP_SUBTITLE_TIME}.set_minute"
		local
			item: SUBRIP_SUBTITLE_TIME
		do
			create item.make
			item.set_minute(10)
			assert ("set_minute correct", item.minutes = 10)
		end


	test_set_minute_invalid
			--  set_minute breaks on invalid number
		note
			testing:  "covers/{SUBRIP_SUBTITLE_TIME}.set_minute"
		local
			item: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			if (not rescued) then
				create item.make
				item.set_minute(70)
				passed := True
			end
			assert ("set_minute broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

end -- class SUBRIP_SUBTITLE_ITEM_TESTS


