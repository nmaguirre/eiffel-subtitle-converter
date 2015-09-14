note
	description: "[
		Eiffel tests for class SUBRIP_SUBTITLE_ITEM.
	]"
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"
	testing: "type/manual"

class
	SUBRIP_SUBTITLE_ITEM_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines

	test_make_valid_no_text
		--constructor make sets correctly
	note
			testing : "covers/{SUBRIP_SUBTITLE_ITEM}.make"
	local
		start_time: SUBRIP_SUBTITLE_TIME
		stop_time: SUBRIP_SUBTITLE_TIME
		item: SUBRIP_SUBTITLE_ITEM
	do
		create start_time.make_with_values(1,0,0,0)
		create stop_time.make_with_values (2,0,0,0)
		create item.make (start_time,stop_time)
		assert ("no text", item.text.count = 0)
	end

	test_make_invalid_no_text
		--constructor make breaks on invalid frames
	note
		testing : "covers/{SUBRIP_SUBTITLE_ITEM}.make"
	local
		start_time: SUBRIP_SUBTITLE_TIME
		stop_time: SUBRIP_SUBTITLE_TIME
		item: SUBRIP_SUBTITLE_ITEM
		rescued: BOOLEAN
		pass: BOOLEAN
	do
		create start_time.make_with_values(2,0,0,0)
		create stop_time.make_with_values (1,0,0,0)
		if (not rescued) then
			create item.make (start_time,stop_time)
			pass := True
		end
		assert ("make broke", not pass)
		rescue
		if (not rescued) then
			rescued := True
			retry
		end
	end


	test_adjust_start_time_valid
			-- method adjust_start_time sets start time correctly
		note
			testing : "covers/{SUBRIP_SUBTITLE_ITEM}.adjust_start_time"
		local
			item: SUBRIP_SUBTITLE_ITEM
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			new_start_time: SUBRIP_SUBTITLE_TIME
		do
			create start_time.make
			create stop_time.make_with_values (0, 0, 5, 0)
			create item.make(start_time, stop_time)
			create new_start_time.make_with_values (0, 0, 1, 0)
			item.adjust_start_time(new_start_time)
			assert ("start time was set successfully", item.start_time.seconds = 1)
		end

	test_adjust_start_time_not_valid
			-- method adjust_start_time sets start time and it breaks when the item's precondition is violated
		note
			testing : "covers/{SUBRIP_SUBTITLE_ITEM}.adjust_start_time"
		local
			item: SUBRIP_SUBTITLE_ITEM
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			new_start_time: SUBRIP_SUBTITLE_TIME
			exception: BOOLEAN
			pass: BOOLEAN
		do
			create start_time.make
			create stop_time.make_with_values (0, 0, 5, 0)
			create item.make(start_time, stop_time)
			create new_start_time.make_with_values (0, 0, 6, 0)
			if (not exception) then
				item.adjust_start_time(new_start_time)
				pass := True
			end
				assert ("the new start time was not seted", not pass)
		rescue
			if (not exception) then
				exception := True
				retry
			end
		end


	test_adjust_stop_time_valid
			-- method adjust_stop_time sets stop time correctly
		note
			testing : "covers/{SUBRIP_SUBTITLE_ITEM}.adjust_stop_time"
		local
			item: SUBRIP_SUBTITLE_ITEM
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			new_stop_time: SUBRIP_SUBTITLE_TIME
		do
			create start_time.make
			create stop_time.make_with_values (0, 0, 5, 0)
			create item.make(start_time, stop_time)
			create new_stop_time.make_with_values (0, 0, 6, 0)
			item.adjust_stop_time(new_stop_time)
			assert ("stop time was set successfully", item.stop_time.seconds = 6)
		end

	test_adjust_stop_time_not_valid
			-- method adjust_stop_time sets stop time and it breaks when the item's precondition is violated
		note
			testing : "covers/{SUBRIP_SUBTITLE_ITEM}.adjust_stop_time"
		local
			item: SUBRIP_SUBTITLE_ITEM
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			new_stop_time: SUBRIP_SUBTITLE_TIME
			exception: BOOLEAN
			pass: BOOLEAN
		do
			create start_time.make
			create stop_time.make_with_values (0, 0, 5, 0)
			create item.make(start_time, stop_time)
			create new_stop_time.make_with_values (0, 0, -1, 0)
			if (not exception) then
				item.adjust_stop_time(new_stop_time)
				pass := True
			end
				assert ("the new stop time was not seted", not pass)
		rescue
			if (not exception) then
				exception := True
				retry
			end
		end

end-- class SUBRIP_SUBTITLE_ITEM_TESTS

