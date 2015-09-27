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

	test_make_valid_with_text
		--constructor make_with_text sets correctly
	note
			testing : "covers/{SUBRIP_SUBTITLE_ITEM}.make_with_text"
	local
		start_time: SUBRIP_SUBTITLE_TIME
		stop_time: SUBRIP_SUBTITLE_TIME
		item: SUBRIP_SUBTITLE_ITEM
		text: STRING
	do
		create start_time.make_with_values(1,0,0,0)
		create stop_time.make_with_values (2,0,0,0)
		text:="Subtitle"
		create item.make_with_text (start_time,stop_time,text)
		assert ("Create Subrip item with text", item.text.is_equal(text))
	end

	test_make_invalid_with_text
		--constructor make_with_text breaks on invalid frames
	note
		testing : "covers/{SUBRIP_SUBTITLE_ITEM}.make_with_text"
	local
		start_time: SUBRIP_SUBTITLE_TIME
		stop_time: SUBRIP_SUBTITLE_TIME
		item: SUBRIP_SUBTITLE_ITEM
		rescued: BOOLEAN
		pass: BOOLEAN
		text: STRING
	do
		create start_time.make_with_values(1,0,0,0)
		create stop_time.make_with_values (2,0,0,0)
		if (not rescued) then
			create item.make_with_text (start_time,stop_time,text)
			pass := True
		end
		assert ("Create Subrip with invalid text entry", not pass)
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
			create start_time.make_with_values (0, 0, 5, 0)
			create stop_time.make_with_values (0, 0, 6, 0)
			create item.make(start_time, stop_time)
			create new_stop_time.make_with_values (0, 0, 0, 0)
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


	test_valid_set_text
			-- Routine setting of the valid subtitle
		note
			testing : "covers/{SUBRIP_SUBTITLE_ITEM}.set_text"
		local
			item: SUBRIP_SUBTITLE_ITEM
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time : SUBRIP_SUBTITLE_TIME
			sub: STRING
		do

			create start_time.make
			create stop_time.make_with_values(0,10,0,0)
			create item.make(start_time,stop_time)
			sub := "Test valid Suprip Subtitle"
			item.set_text (sub)
			assert ("Text subrip subtitle set", item.text.is_equal(sub))
		end


	test_invalid_set_text
			-- Routine setting of the invalid subrip subtitle
			-- The test fail because set the text with Void is not allowed
		note
			testing : "covers/{SUBRIP_SUBTITLE_ITEM}.set_text"
		local
			item: SUBRIP_SUBTITLE_ITEM
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time : SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
			sub: STRING
		do
			create start_time.make
			create stop_time.make_with_values(0,10,0,0)
			create item.make(start_time,stop_time)

			if (not rescued) then
				item.set_text (sub)
				passed := True
			end
			assert ("set_text broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_out
		--check the correct string representation of a item
	note
			testing : "covers/{SUBRIP_SUBTITLE_ITEM}.out"
	local
		start_time: SUBRIP_SUBTITLE_TIME
		stop_time: SUBRIP_SUBTITLE_TIME
		item: SUBRIP_SUBTITLE_ITEM
		text: STRING
	do
		create start_time.make_with_values(1,2,15,322)
		create stop_time.make_with_values (1,20,54,500)
		text:="Subtitle"
		create item.make_with_text (start_time,stop_time,text)
		assert ("Make With Subtitle", item.out.is_equal (
			"[
			01:02:15,322 --> 01:20:54,500
			Subtitle

			]"
		))
	end

end-- class SUBRIP_SUBTITLE_ITEM_TESTS

