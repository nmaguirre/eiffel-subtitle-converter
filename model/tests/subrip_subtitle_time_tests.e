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


	test_make_valid_time
			-- constructor make sets correctly
		note
			testing : "covers/{SUBRIP_SUBTITLE_TIME}.make"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make
			assert ("milliseconds default", subtitle_time.milliseconds = 0)
			assert ("seconds default", subtitle_time.seconds=0)
			assert ("minutes default", subtitle_time.minutes=0)
			assert ("hours default", subtitle_time.hours=0)
		end


	test_set_hour_valid
			-- set a hour correctly
		note
			testing:  "covers/{SUBRIP_SUBTITLE_TIME}.set_hour"
		local
			item: SUBRIP_SUBTITLE_TIME
		do
			create item.make
			item.set_hour(2)
			assert ("set_hour correct", item.hours = 2)
		end


	test_set_hour_invalid
			--set an invalid hour
		note
			testing:  "covers/{SUBRIP_SUBTITLE_TIME}.set_hour"
		local
			item: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create item.make
			if (not rescued) then
				item.set_hour(24)
				passed := True
			end
			assert ("set_hour Invalid", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end


	test_set_hour_invalid_negative_value
			-- method set_hour breaks on negative value
		note
			testing : "covers/{SUBRIP_SUBTITLE_TIME}.set_hour"

		local
			item: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN

		do
			create item.make
			if (not rescued) then
				item.set_hour(-1)
				passed := True
			end
			assert ("set_hour invalid negative value", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end


	test_set_milliseconds_valid_value
			-- method set_milliseconds sets miillisecods correctly

		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.se_milliseconds"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make
			subtitle_time.set_milliseconds(30)
			assert ("milliseconds set", subtitle_time.milliseconds = 30)
		end

	test_set_milliseconds_negative_value
			-- method set_milliseconds breaks on negative value

		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.se_milliseconds"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create subtitle_time.make
			if (not rescued) then
				subtitle_time.set_milliseconds(-5)
				passed := True
			end
			assert ("set_milliseconds broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_set_milliseconds_invalid_value
			-- method set_milliseconds breaks on invalid value

		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.se_milliseconds"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create subtitle_time.make
			if (not rescued) then
				subtitle_time.set_milliseconds(1000)
				passed := True
			end
			assert ("set_milliseconds broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

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

	test_set_minute_invalid_negative_value
			-- method set_minute breaks on negative value
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.set_minute"
		local
			item: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			if (not rescued) then
				create item.make
				item.set_minute(-10)
				passed := True
			end
			assert ("set_minute broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_set_move_forward_valid_milliseconds
			-- method move_forward sets miillisecods correctly
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.move_forward"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make
			subtitle_time.move_forward (800)
			assert ("milliseconds set", subtitle_time.milliseconds = 800)
			assert ("seconds set", subtitle_time.seconds=0)
			assert ("minutes set", subtitle_time.minutes=0)
			assert ("hours set", subtitle_time.hours=0)
		end

	test_set_move_forward_valid_seconds
			-- method move_forward sets seconds correctly
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.move_forward"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make
			subtitle_time.move_forward (1000)
			assert ("milliseconds set", subtitle_time.milliseconds = 0)
			assert ("seconds set", subtitle_time.seconds=1)
			assert ("minutes set", subtitle_time.minutes=0)
			assert ("hours set", subtitle_time.hours=0)
		end

	test_set_move_forward_valid_minutes
			-- method move_forward sets minutes correctly
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.move_forward"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make
			subtitle_time.move_forward (60000)
			assert ("milliseconds set", subtitle_time.milliseconds = 0)
			assert ("seconds set", subtitle_time.seconds=0)
			assert ("minutes set", subtitle_time.minutes=1)
			assert ("hours set", subtitle_time.hours=0)
		end

	test_set_move_forward_valid_hours
			-- method move_forward sets hours correctly
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.move_forward"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make
			subtitle_time.move_forward (3600000)
			assert ("milliseconds set", subtitle_time.milliseconds = 0)
			assert ("seconds set", subtitle_time.seconds=0)
			assert ("minutes set", subtitle_time.minutes=0)
			assert ("hours set", subtitle_time.hours=1)
		end

	test_set_move_forward_valid_time
			-- method move_forward set time correctly
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.move_forward"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make
			subtitle_time.move_forward (86398999)
			assert ("milliseconds set", subtitle_time.milliseconds = 999 )
			assert ("seconds set", subtitle_time.seconds=58)
			assert ("minutes set", subtitle_time.minutes=59)
			assert ("hours set", subtitle_time.hours=23)
		end

	test_set_move_forward_invalid_negative_value
			-- method move_forward breaks on negative value
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.move_forward"
		local
			item: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			if (not rescued) then
				create item.make
				item.move_forward (-5214)
				passed := True
			end
			assert ("move_forward broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_set_move_forward_invalid_value
			-- method move_forward breaks on big value
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.move_forward"
		local
			item: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			if (not rescued) then
				create item.make
				item.move_forward (96398999)
				passed := True
			end
			assert ("move_forward broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_set_rewind_valid_milliseconds
			-- method rewind sets miillisecods correctly
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.rewind"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make_with_values (0, 0, 0, 900)
			subtitle_time.rewind (800)
			assert ("milliseconds set", subtitle_time.milliseconds = 100)
			assert ("seconds set", subtitle_time.seconds=0)
			assert ("minutes set", subtitle_time.minutes=0)
			assert ("hours set", subtitle_time.hours=0)
		end

	test_set_rewind_valid_seconds
			-- method rewind sets seconds correctly
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.rewind"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make_with_values (0, 0, 2, 0)
			subtitle_time.rewind (1000)
			assert ("milliseconds set", subtitle_time.milliseconds = 0)
			assert ("seconds set", subtitle_time.seconds=1)
			assert ("minutes set", subtitle_time.minutes=0)
			assert ("hours set", subtitle_time.hours=0)
		end

	test_set_rewind_valid_minutes
			-- method rewind sets minutes correctly
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.rewind"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make_with_values (0, 2, 0, 0)
			subtitle_time.rewind (60000)
			assert ("milliseconds set", subtitle_time.milliseconds = 0)
			assert ("seconds set", subtitle_time.seconds=0)
			assert ("minutes set", subtitle_time.minutes=1)
			assert ("hours set", subtitle_time.hours=0)
		end

	test_set_rewind_valid_hours
			-- method rewind sets hours correctly
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.rewind"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make_with_values (2, 0, 0, 0)
			subtitle_time.rewind (3600000)
			assert ("milliseconds set", subtitle_time.milliseconds = 0)
			assert ("seconds set", subtitle_time.seconds=0)
			assert ("minutes set", subtitle_time.minutes=0)
			assert ("hours set", subtitle_time.hours=1)
		end

	test_set_rewind_valid_time
			-- method rewind set time correctly
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.rewind"
		local
			subtitle_time: SUBRIP_SUBTITLE_TIME
		do
			create subtitle_time.make_with_values (10, 59, 59, 900)
			subtitle_time.rewind (5425636)
			assert ("milliseconds set", subtitle_time.milliseconds = 264 )
			assert ("seconds set", subtitle_time.seconds=34)
			assert ("minutes set", subtitle_time.minutes=29)
			assert ("hours set", subtitle_time.hours=9)
		end

	test_set_rewind_invalid_negative_value
			-- method rewind breaks on negative value
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.rewind"
		local
			item: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			if (not rescued) then
				create item.make_with_values (1, 1, 6, 1)
				item.rewind (-5214)
				passed := True
			end
			assert ("rewind broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_set_rewind_invalid_value
			-- method rewind breaks if some value is minor of cero
		note
			testting : "covers/{SUBRIP_SUBTITLE_TIME}.rewind"
		local
			item: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			if (not rescued) then
				create item.make
				item.rewind (5621)
				passed := True
			end
			assert ("rewind broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

end -- class SUBRIP_SUBTITLE_ITEM_TESTS


