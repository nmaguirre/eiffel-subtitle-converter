note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	MICRODVD_SUBTITLE_ITEM_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines

	test_make_valid_frames_no_text
			-- constructor make sets no text
		note
			testing:  "covers/{MICRODVD_SUBTITLE_ITEM}.make"
		local
			item: MICRODVD_SUBTITLE_ITEM
		do
			create item.make(0,1)
			assert ("no text", item.text.count = 0)
		end

	test_make_valid_frames_start_frame_set
			-- constructor make sets start frame correctly
		note
			testing:  "covers/{MICRODVD_SUBTITLE_ITEM}.make"
		local
			item: MICRODVD_SUBTITLE_ITEM
		do
			create item.make(0,1)
			assert ("start frame set", item.start_frame = 0)
		end

	test_make_valid_frames_stop_frame_set
			-- constructor make sets stop frame correctly
		note
			testing:  "covers/{MICRODVD_SUBTITLE_ITEM}.make"
		local
			item: MICRODVD_SUBTITLE_ITEM
		do
			create item.make(0,1)
			assert ("stop frame set", item.stop_frame = 1)
		end

	test_make_invalid_frames
			--  constructor make breaks on invalid frames
		note
			testing:  "covers/{MICRODVD_SUBTITLE_ITEM}.make"
		local
			item: MICRODVD_SUBTITLE_ITEM
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			if (not rescued) then
				create item.make (1,0)
				passed := True
			end
			assert ("make broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end


end


