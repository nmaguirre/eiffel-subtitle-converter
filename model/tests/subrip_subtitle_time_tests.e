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


end -- class SUBRIP_SUBTITLE_ITEM_TESTS


