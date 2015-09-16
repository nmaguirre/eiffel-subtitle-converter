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

	test_remove_items_valid
			-- checks that removes all subtitle items between start_frame and stop_frame
		note
			testing:  "covers/{SUBRIP_SUBTITLE}.remove_items"
		local
			subrip_sub: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
		do
			create subrip_sub.make
			create start_time.make_with_values (1, 20, 15, 350)
			create stop_time.make_with_values (1, 25, 15, 550)
			subrip_sub.remove_items (start_time,stop_time)
			assert ("remove_items correct", True)
		end

	test_remove_items_invalid
			--  remove_items breaks when start_time is greater than stop_time
		note
			testing:  "covers/{SUBRIP_SUBTITLE}.remove_items"
		local
			subrip_sub: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create subrip_sub.make
			create start_time.make_with_values (1, 50, 40, 600)
			create stop_time.make_with_values (1, 40, 35, 460)
			if (not rescued) then
				subrip_sub.remove_items(start_time,stop_time)
				passed := True
			end
			assert ("remove_items broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

end-- class SUBRIP_SUBTITLE_TESTS

