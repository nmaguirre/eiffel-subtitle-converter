note
	description: "[
		Eiffel tests for class MICRODVD_SUBTITLE_ITEM.
	]"
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"
	testing: "type/manual"

class
	MICRODVD_SUBTITLE_ITEM_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines

	test_make_from_string
		note
			testing:  "covers/{MICRODVD_SUBTITLE_ITEM}.make_from_string"
		local
			item: MICRODVD_SUBTITLE_ITEM
		do
			create item.make_from_string("{1}{2}hola")
			assert ("create microdvd item from string of file.sub", item.start_frame = 1 and item.stop_frame = 2 and item.text.is_equal ("hola"))
		end

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

	test_make_with_text_valid_frames_start_frame_set
			-- constructor make (with text) sets start frame correctly
		note
			testing:  "covers/{MICRODVD_SUBTITLE_ITEM}.make_with_text"
		local
			item: MICRODVD_SUBTITLE_ITEM
			sub: STRING
		do
			sub:= ""
			create item.make_with_text(0,1,sub)
			assert ("start frame set", item.start_frame = 0)
		end

	test_make_with_text_valid_frames_stop_frame_set
			-- constructor make (with text) sets stop frame correctly
		note
			testing:  "covers/{MICRODVD_SUBTITLE_ITEM}.make_with_text"
		local
			item: MICRODVD_SUBTITLE_ITEM
			sub: STRING
		do
			sub:= ""
			create item.make_with_text(0,1,sub)
			assert ("stop frame set", item.stop_frame = 1)
		end

	test_make_with_text_valid_frames_text
			-- constructor make (with text)sets text correctly
		note
			testing:  "covers/{MICRODVD_SUBTITLE_ITEM}.make_with_text"
		local
			item: MICRODVD_SUBTITLE_ITEM
			sub: STRING
		do
			sub:= "Test Subtitle"
			create item.make_with_text(0,1,sub)
			assert ("Text subtitle set", item.text.is_equal (sub))
		end

	test_make_with_text_invalid_frames
			--  constructor make_with_text breaks on invalid frames
		note
			testing:  "covers/{MICRODVD_SUBTITLE_ITEM}.make_with_text"
		local
			item: MICRODVD_SUBTITLE_ITEM
			passed: BOOLEAN
			rescued: BOOLEAN
			sub: STRING
		do
			if (not rescued) then
				sub := "Test Subtitle"
				create item.make_with_text (1,0,sub)
				passed := True
			end
			assert ("make_with_text broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_make_with_text_invalid_frames_equal
			--  constructor make_with_text breaks on invalid frames
		note
			testing:  "covers/{MICRODVD_SUBTITLE_ITEM}.make_with_text"
		local
			item: MICRODVD_SUBTITLE_ITEM
			passed: BOOLEAN
			rescued: BOOLEAN
			sub: STRING
		do
			if (not rescued) then
				sub := "Test Subtitle"
				create item.make_with_text (1,1,sub)
				passed := True
			end
			assert ("make_with_text broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_make_with_text_invalid_text
			--  constructor make_with_text breaks on invalid text
		note
			testing:  "covers/{MICRODVD_SUBTITLE_ITEM}.make_with_text"
		local
			item: MICRODVD_SUBTITLE_ITEM
			passed: BOOLEAN
			rescued: BOOLEAN
			text_void:STRING
		do
			if (not rescued) then
				text_void := Void
				create item.make_with_text (0,1,text_void)
				passed := True
			end
			assert ("make_with_text broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end


	test_adjust_stop_frame_valid_frame
			-- method adjust_stop_frame sets stop frames correctly

		note
			testing : "covers/{MICRODVD_SUBTITLE_ITEM}.adjust_stop_frame"
		local
			item: MICRODVD_SUBTITLE_ITEM
		do
			create item.make (0,10)
			item.adjust_stop_frame (15)
			assert ("stop frame set", item.stop_frame = 15)
		end

	test_adjust_stop_frame_invalid_frame
			-- method adjust_stop_frame breaks on invalid frames

		note
			testing : "covers/{MICRODVD_SUBTITLE_ITEM}.adjust_stop_frame"
		local
			item: MICRODVD_SUBTITLE_ITEM
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create item.make (1,5)
			if (not rescued) then
				item.adjust_stop_frame (0)
				passed := True
			end
			assert ("adjust_stop_frame broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_valid_set_text
			-- Routine setting of the valid subtitle
		note
			testing : "covers/{MICRODVD_SUBTITLE_ITEM}.set_text"
		local
			item: MICRODVD_SUBTITLE_ITEM
			sub: STRING
		do
			create item.make (0,1)
			sub := "Test Subtitle"
			item.set_text (sub)
			assert ("Text subtitle set", item.text.is_equal (sub))
		end

	test_invalid_set_text
			-- Routine setting of the invalid subtitle
			-- The test fail because set the text with Void is not allowed
		note
			testing : "covers/{MICRODVD_SUBTITLE_ITEM}.set_text"
		local
			item: MICRODVD_SUBTITLE_ITEM
			passed: BOOLEAN
			rescued: BOOLEAN
			sub: STRING
		do
			create item.make (0,1)
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

	test_adjust_start_frame_valid_frame
			-- method adjust_start_frame sets start frames correctly
		note
			testing : "covers/{MICRODVD_SUBTITLE_ITEM}.adjust_start_frame"
		local
			item: MICRODVD_SUBTITLE_ITEM
		do
			create item.make (0,5)
			item.adjust_start_frame (0)
			assert ("start frame set", item.start_frame = 0)
		end

	test_adjust_start_frame_invalid_frame
			-- method adjust_start_frame breaks on invalid frames
		note
			testing : "covers/{MICRODVD_SUBTITLE_ITEM}.adjust_start_frame"
		local
			item: MICRODVD_SUBTITLE_ITEM
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create item.make (1,5)
			if (not rescued) then
				item.adjust_start_frame (15)
				passed := True
			end
			assert ("adjust_start_frame broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end
end


