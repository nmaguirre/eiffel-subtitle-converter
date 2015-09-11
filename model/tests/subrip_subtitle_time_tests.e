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

create
	default_create

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

end -- class SUBRIP_SUBTITLE_ITEM_TESTS
