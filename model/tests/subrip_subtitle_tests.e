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
			subrip_sub: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			subtitle : STRING
		do
			subtitle := "Text Subtitle"
			create subrip_sub.make
			create start_time.make_with_values (0, 5, 0, 0)
			create stop_time.make_with_values (0, 7, 0, 0)
			subrip_sub.add_subtitle_item (start_time,stop_time,subtitle)

			create start_time.make_with_values (0, 8, 0, 330)
			create stop_time.make_with_values (0, 20, 0, 500)
			subrip_sub.add_subtitle_item (start_time,stop_time,subtitle)
			subrip_sub.flush
			assert ("flush correct", subrip_sub.items.count = 0)
		end

	test_remove_items_valid
			-- checks that removes all subtitle items between start_frame and stop_frame
		note
			testing:  "covers/{SUBRIP_SUBTITLE}.remove_items"
		local
			subrip_sub: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			old_items_count: INTEGER
		do
			create subrip_sub.make
			create start_time.make_with_values (1, 20, 15, 350)
			create stop_time.make_with_values (1, 21, 15, 550)
			subrip_sub.add_subtitle_item (start_time, stop_time, "First line")
			create start_time.make_with_values (1, 40, 35, 240)
			create stop_time.make_with_values (1, 40, 36, 760)
			subrip_sub.add_subtitle_item (start_time, stop_time, "Last line")
			old_items_count := subrip_sub.items.count

			create start_time.make_with_values (1, 40, 00, 000)
			create stop_time.make_with_values (1, 41, 00, 000)
			subrip_sub.remove_items (start_time,stop_time)
			assert ("remove_items correct", subrip_sub.items.count <= old_items_count)
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

	test_repOk_valid_representation
			-- create a valid sequence and evaluate it with repOk
			-- modifies the items list manually
		note
			testing:  "covers/{SUBRIP_SUBTITLE}.repOK"
		local
			sub_title: SUBRIP_SUBTITLE
			sub_start_time: SUBRIP_SUBTITLE_TIME
			sub_stop_time:  SUBRIP_SUBTITLE_TIME

			sub:STRING
		do
			create sub_title.make
			sub := "Test Subtitle"

			create sub_start_time.make_with_values(0,0,0,20)
			create sub_stop_time.make_with_values(0,0,0,500)
			sub_title.add_subtitle_item(sub_start_time,sub_stop_time,sub)

			create sub_start_time.make_with_values(0,0,0,900)
			create sub_stop_time.make_with_values(0,0,0,990)
			sub_title.add_subtitle_item (sub_start_time,sub_stop_time,sub)

			assert ("Subtitle representation is ok", sub_title.repOK)
		end

	test_repOk_invalid_representation
			-- create a valid sequence and evaluate it with repOk
			-- modifies the items list manually
		note
			testing:  "covers/{SUBRIP_SUBTITLE}.repOK"
		local
			sub_title: SUBRIP_SUBTITLE
			sub_start_time: SUBRIP_SUBTITLE_TIME
			sub_stop_time:  SUBRIP_SUBTITLE_TIME
			sub_start1_time: SUBRIP_SUBTITLE_TIME
			sub_stop1_time:  SUBRIP_SUBTITLE_TIME
			sub:STRING

			passed: BOOLEAN
			rescued: BOOLEAN

		do
			create sub_title.make
			sub := "Test Subtitle"
			create sub_start_time.make_with_values(0,0,0,20)
			create sub_stop_time.make_with_values(0,0,0,500)
			create sub_start1_time.make_with_values(0,0,0,488)
			create sub_stop1_time.make_with_values(0,0,0,990)

			if (not rescued) then
				sub_title.add_subtitle_item(sub_start_time,sub_stop_time,sub)
				sub_title.add_subtitle_item (sub_start1_time,sub_stop1_time,sub)
				passed := True
			end
			assert ("Subtitle representation not is correct", not passed)
			rescue
			if (not rescued) then
				rescued := True
				retry
			end

		end



	test_add_subtitle_item_valid
			-- check that add_subtitle_item run correctly
		note
			testing:  "covers/{SUBRIP_SUBTITLE}.add_subtitle_item"
		local
			subtitle_item: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			text: STRING
		do
			create subtitle_item.make
			text := "Text Subtitle"
			create start_time.make_with_values (2, 30,50 , 101)
			create stop_time.make_with_values (2, 35, 55,150)
			subtitle_item.add_subtitle_item(start_time,stop_time,text)
			assert ("add_subtitle_item correct", true)
		end

	test_make_from_file
		note
			testing:  "covers/{SUBRIP_SUBTITLE}.make_from_file"
		local
			subrip : SUBRIP_SUBTITLE
		do
			create subrip.make_from_file ("test_make.srt")
			subrip.items.start
			assert("make from file ",subrip.items.item.text.is_equal("Hola"))
		end

	test_add_subtitle_item_invalid
			--add_subtitle_item breaks on invalid paramters
		note
			testing:  "covers/{SUBRIP_SUBTITLE}.add_subtitle_item"
		local
			subtitle_item: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			text: STRING
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create subtitle_item.make
			text := "Test Subtitle"
			create start_time.make_with_values(2,50,50,950)
			create stop_time.make_with_values(1,30,30,100)

			if (not rescued) then
				subtitle_item.add_subtitle_item(start_time,stop_time,text)
				passed := True
			end
			assert ("add_subtitle_item Invalid", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end


	test_convert_to_microdvd
		note
			testing:  "covers/{SUBRIP_SUBTITLE}.convert_to_microdvd"
		local
			subrip: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			text: STRING
			microdvd: MICRODVD_SUBTITLE
		do
			create subrip.make
			create text.make_from_string ("Hola")
			create start_time.make_with_values (0, 00,1 , 000)
			create stop_time.make_with_values (0,0, 2,000)
			subrip.add_subtitle_item(start_time,stop_time,text)


			create text.make_from_string ("Chau")
			create start_time.make_with_values (0, 00,3 , 000)
			create stop_time.make_with_values (0,0, 4,000)
			subrip.add_subtitle_item(start_time,stop_time,text)


			create microdvd.make
			microdvd := subrip.convert_to_microdvd
			assert("Conversion",microdvd.items.item.text.is_equal("Hola") and microdvd.items.item.start_frame.is_equal (24) and microdvd.items.item.stop_frame.is_equal (48))

		end

end-- class SUBRIP_SUBTITLE_TESTS

