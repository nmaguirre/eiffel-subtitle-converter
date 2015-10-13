note
	description: "[
		Eiffel tests for class MICRODVD_SUBTITLE.
	]"
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"
	testing: "type/manual"

class
	MICRODVD_SUBTITLE_TEST

inherit
	EQA_TEST_SET

feature -- Test routines


	test_valid_make_from_file
			-- Make MicroDVD Subtitle from file
		note
			testing: "covers/{MICRODVD_SUBTITLE}.make_from_file"
		local
			subs: MICRODVD_SUBTITLE
			file: PLAIN_TEXT_FILE
		do
			create file.make_with_name ("text_archive")
			file.open_write
			file.putstring ("{1}{2}first_text")
			file.new_line
			file.putstring ("{3}{5}second_text")
			file.new_line
			file.close
			create subs.make_from_file("text_archive")
			assert ("Make MicroDVD from file is correct", subs.items.count = 2)
			file.delete
		end


	test_make_from_file_invalid_values
			--make_from_file breaks on invalid values
		note
			testing: "covers/{MICRODVD_SUBTITLE}.make_from_file"
		local
			subs: MICRODVD_SUBTITLE
			file: PLAIN_TEXT_FILE
			pass: BOOLEAN
			rescued: BOOLEAN
		do
			create file.make_with_name ("text_archive")
			if not rescued then
				file.open_write
				file.putstring ("{2}{1}first_text")
				file.new_line
				file.close
				create subs.make_from_file("text_archive")
				pass:= True
			end
			assert ("Make MicroDVD from file with invalid value is broke", not pass)
			file.delete
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end


	test_invalid_make_from_file_negative_value
			--make_from_file breaks on negative value
		note
			testing: "covers/{MICRODVD_SUBTITLE}.make_from_file"
		local
			subs: MICRODVD_SUBTITLE
			file: PLAIN_TEXT_FILE
			pass: BOOLEAN
			rescued: BOOLEAN
		do
			create file.make_with_name ("text_archive")
			if not rescued then
				file.open_write
				file.putstring ("{-1}{2}first_text")
				file.new_line
				file.close
				create subs.make_from_file("text_archive")
				pass:= True
			end
			assert ("Make MicroDVD from file with negative value is broke", not pass)
			file.delete
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end


	test_invalid_make_from_file_wrong_sequence
			--make_from_file breaks on wrong sequence
		note
			testing: "covers/{MICRODVD_SUBTITLE}.make_from_file"
		local
			subs: MICRODVD_SUBTITLE
			file: PLAIN_TEXT_FILE
			pass: BOOLEAN
			rescued: BOOLEAN
		do
			create file.make_with_name ("text_archive")
			if not rescued then
				file.open_write
				file.putstring ("{1}{4}first_text")
				file.new_line
				file.putstring ("{3}{7}second_text")
				file.new_line
				file.putstring ("{2}{9}third_text")
				file.new_line
				file.close
				create subs.make_from_file("text_archive")
				pass:= True
			end
			assert ("Make MicroDVD from file on invalid sequence is broke", not pass)
			file.delete
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_repOk_valid_representation
			-- create a valid sequence and evaluate it with repOk.
			-- Modifies the items list manually
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.repOK"
		local
			subs: MICRODVD_SUBTITLE
			itm:MICRODVD_SUBTITLE_ITEM
		do
			create subs.make
			create itm.make(0,100)
			subs.items.extend (itm)
			create itm.make(101,200)
			subs.items.extend (itm)
			assert ("Subtitle representation is ok", subs.repOk)
		end

	test_repOk_invalid_representation
			-- create a invalid sequence and evaluate it with repOk.
			-- Modifies the items list manually
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.repOK"
		local
			subs: MICRODVD_SUBTITLE
			itm:MICRODVD_SUBTITLE_ITEM
		do
			create subs.make
			create itm.make(101,200)
			subs.items.extend (itm)
			create itm.make(0,100)
			subs.items.extend (itm)
			assert ("Subtitle representation is ok", not subs.repOk)
		end

	test_repOk_invalid_representation_with_void_element
			-- create a invalid sequence with a Void elment in the head and evaluate it with repOk.
			-- Modifies the items list manually
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.repOK"
		local
			subs: MICRODVD_SUBTITLE
			itm:MICRODVD_SUBTITLE_ITEM
		do
			create subs.make
			subs.items.extend (itm) --  put a Void element in the list
			create itm.make(0,100)
			subs.items.extend (itm)
			assert ("Subtitle representation is ok", not subs.repOk)
		end

	test_flush_valid
			-- checks that removes all items from the subtitle
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.flush"
		local
			item: MICRODVD_SUBTITLE
		do
			create item.make
			item.flush
			assert ("flush correct", item.items.count = 0)
		end

	test_flush_items_not_empty
			-- checks that removes all items from the subtitle
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.flush"
		local
			subtitle: MICRODVD_SUBTITLE
		do
			create subtitle.make
			subtitle.add_subtitle_item (0, 5, "test flush_items_not_empty")
			subtitle.flush
			assert ("flush correct", subtitle.items.count = 0)
		end

	test_remove_items_valid_one
			-- checks that remove subtitle items from start_frame
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.remove_items"
		local
			subtitle: MICRODVD_SUBTITLE
		do
			create subtitle.make
			subtitle.add_subtitle_item (0, 5, "text_one")
			subtitle.add_subtitle_item (10, 15, "text_two")
			subtitle.remove_items (0,5)
			assert ("remove_items correct", subtitle.items.count =  1)
		end


	test_remove_items_valid_two
			-- checks that removes subtitle items between start_frame and one value out of range from start_frame
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.remove_items"
		local
			subtitle: MICRODVD_SUBTITLE
		do
			create subtitle.make
			subtitle.add_subtitle_item (0, 5, "text_one")
			subtitle.add_subtitle_item (10, 15, "text_two")
			subtitle.remove_items (0,8)
			assert ("remove_items correct", subtitle.items.count = 1)
		end

	test_remove_items_valid_three
			-- checks that removes all subtitle items between start_frame and stop_frame
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.remove_items"
		local
			subtitle: MICRODVD_SUBTITLE
		do
			create subtitle.make
			subtitle.add_subtitle_item (0, 5, "text_one")
			subtitle.add_subtitle_item (10, 15, "text_two")
			subtitle.remove_items (0,15)
			assert ("remove_items correct", subtitle.items.count = 0)
		end

	test_remove_items_valid_four
			-- checks that removes subtitle items between start_frame and stop_frame
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.remove_items"
		local
			subtitle: MICRODVD_SUBTITLE
		do
			create subtitle.make
			subtitle.add_subtitle_item (0, 5, "text_one")
			subtitle.add_subtitle_item (10, 15, "text_two")
			subtitle.remove_items (4,13)
			assert ("remove_items correct", subtitle.items.count =  2)
		end


	test_remove_items_valid_five
			-- checks that removes all subtitle items between start_frame and stop_frame and value out of range from stop_frame
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.remove_items"
		local
			subtitle: MICRODVD_SUBTITLE
		do
			create subtitle.make
			subtitle.add_subtitle_item (0, 5, "text_one")
			subtitle.add_subtitle_item (10, 15, "text_two")
			subtitle.remove_items (0,20)
			assert ("remove_items correct", subtitle.items.count = 0)
		end

	test_remove_items_valid_six
			-- checks that removes subtitle items of value between start_frame and stop_frame
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.remove_items"
		local
			subtitle: MICRODVD_SUBTITLE
		do
			create subtitle.make
			subtitle.add_subtitle_item (0, 5, "text_one")
			subtitle.add_subtitle_item (10, 15, "text_two")
			subtitle.remove_items (6,9)
			assert ("remove_items correct", subtitle.items.count = 2)
		end

	test_remove_items_invalid_negative_value
			--  remove_items breaks on invalid parameters
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.remove_items"
		local
			item: MICRODVD_SUBTITLE
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create item.make
			if (not rescued) then
				item.remove_items(-10,100)
				passed := True
			end
			assert ("remove_items broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_remove_items_invalid
			--  remove_items breaks on invalid parameters
			-- 	start_frame > stop_frame
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.remove_items"
		local
			item: MICRODVD_SUBTITLE
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create item.make
			if (not rescued) then
				item.remove_items(10,5)
				passed := True
			end
			assert ("remove_items broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_valid_zero_change_fps
			-- Routine 'change_fps' sets 'frames_per_second' correctly in zero
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.change_fps"
		local
			sub_microdvd: MICRODVD_SUBTITLE
		do
			create sub_microdvd.make
			sub_microdvd.change_fps(sub_microdvd.min_valid_fps + 1)
			assert("change frames_per_second", sub_microdvd.frames_per_second = 13)
		end

	test_valid_greater_than_zero_change_fps
			-- Routine 'change_fps' sets 'frames_per_second' correctly in positive value
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.change_fps"
		local
			sub_microdvd: MICRODVD_SUBTITLE
		do
			create sub_microdvd.make
			sub_microdvd.change_fps (30)
			assert("change frames_per_second", sub_microdvd.frames_per_second = 30)
		end

	test_invalid_change_fps
			-- Routine 'change_fps' sets 'frames_per_second' in a invalid value
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.change_fps"
		local
			sub_microdvd: MICRODVD_SUBTITLE
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create sub_microdvd.make
			if (not rescued) then
				sub_microdvd.change_fps (sub_microdvd.min_valid_fps)
				passed := True
			end
			assert ("change_fps broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_add_subtitle_item_valid
			-- check that the items are entered correctly
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.add_subtitle_item"
		local
			sub: MICRODVD_SUBTITLE
		do
			create sub.make
			sub.add_subtitle_item(20,100,"text1")
			sub.add_subtitle_item(201,300,"text3")
			sub.add_subtitle_item(101,200,"text2")
			assert ("Add Subtitle is ok",sub.items[1].text.is_equal("text1")
			and sub.items[2].text.is_equal("text2")
			and sub.items[3].text.is_equal("text3"))
		end

	test_add_subtitle_item_valid_alternative
				-- check that the items are entered correctly
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.add_subtitle_item"
		local
			sub: MICRODVD_SUBTITLE
			pass: BOOLEAN
		do
			create sub.make
			sub.add_subtitle_item (0,5,"sub1")
			sub.add_subtitle_item (6,9,"sub2")
			sub.add_subtitle_item (10,19,"sub3")
			pass:= sub.items[1].text.is_equal("sub1")
			pass:= sub.items[2].text.is_equal("sub2") and pass
			pass:= sub.items[3].text.is_equal("sub3") and pass
			assert("Subtitles has been inserted sucessfully", pass)
		end

	test_add_subtitle_item_invalid
			--  add_subtitle_item breaks on invalid parameters
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.add_subtitle_item"
		local
			item: MICRODVD_SUBTITLE
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create item.make
			if (not rescued) then
				item.add_subtitle_item (1,100,"text1")
				item.add_subtitle_item (50,120,"text2")
				passed := True
			end
			assert ("add_subtitle_items is broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end


	test_free_time_frame_mid
		note
			testing: "convers/{MICRODVD_SUBTITLE}.free_time_frame"
		local
			microdvd: MICRODVD_SUBTITLE
		do
			create microdvd.make
			microdvd.add_subtitle_item (1, 2,"hola")
			microdvd.add_subtitle_item (3, 5,"buenas")
			microdvd.add_subtitle_item (8, 10,"chau")
			assert("free time frame",microdvd.free_time_frame (6, 7))
		end

	test_free_time_frame_one_element_init
		note
			testing: "convers/{MICRODVD_SUBTITLE}.free_time_frame"
		local
			microdvd: MICRODVD_SUBTITLE
		do
			create microdvd.make
			microdvd.add_subtitle_item (4, 5,"hola")
			assert("free time frame with one element",microdvd.free_time_frame (1,3))
		end

	test_free_time_frame_one_element_last
		note
			testing: "convers/{MICRODVD_SUBTITLE}.free_time_frame"
		local
			microdvd: MICRODVD_SUBTITLE
		do
			create microdvd.make
			microdvd.add_subtitle_item (1, 2,"hola")
			assert("free time frame with one element",microdvd.free_time_frame (3, 7))
		end

	test_free_time_frame_the_first
		note
			testing: "convers/{MICRODVD_SUBTITLE}.free_time_frame"
		local
			microdvd: MICRODVD_SUBTITLE
		do
			create microdvd.make
			microdvd.add_subtitle_item (8, 10,"chau")
			assert("free time frame when the timeat init",microdvd.free_time_frame (6, 7))
		end

	test_free_time_frame_the_first_invalid
		note
			testing: "convers/{MICRODVD_SUBTITLE}.free_time_frame"
		local
			microdvd: MICRODVD_SUBTITLE
		do
			create microdvd.make
			microdvd.add_subtitle_item (8, 10,"chau")
			assert("No free time at the beginning of the subtitle",not microdvd.free_time_frame (6, 9))
		end


	test_free_time_frame_empty
		note
			testing: "convers/{MICRODVD_SUBTITLE}.free_time_frame"
		local
			microdvd: MICRODVD_SUBTITLE
		do
			create microdvd.make
			assert("free time frame witout elementt",microdvd.free_time_frame (3, 7))
		end



	test_free_time_frame_last
		note
			testing: "convers/{MICRODVD_SUBTITLE}.free_time_frame"
		local
			microdvd: MICRODVD_SUBTITLE
		do
			create microdvd.make
			microdvd.add_subtitle_item (1, 2,"hola")
			microdvd.add_subtitle_item (3, 5,"buenas")
			microdvd.add_subtitle_item (8, 10,"chau")
			assert("free time frame at the last of the list",microdvd.free_time_frame (11, 14))
		end



	test_free_time_frame_invalid
		note
			testing: "convers/{MICRODVD_SUBTITLE}.free_time_frame"
		local
			microdvd: MICRODVD_SUBTITLE
		do
			create microdvd.make
			microdvd.add_subtitle_item (1, 2,"hola")
			microdvd.add_subtitle_item (3, 5,"buenas")
			microdvd.add_subtitle_item (8, 10,"chau")
			assert("free time frame",not microdvd.free_time_frame (6, 8))
		end


	test_checker_valid
			--Verifies that subtitle can be inserted between two subtitles
		note
			testing: "covers/{MICRODVD_SUBTITLE}.checker"
		local
			sub, fst, snd: MICRODVD_SUBTITLE_ITEM
			subtitles: MICRODVD_SUBTITLE
		do
			create sub.make (4,5)
			create fst.make (1,3)
			create snd.make (8,9)
			create subtitles.make
			assert("The microdvd subtitle item can be inserted", subtitles.checker(sub,fst,snd))
		end


	test_checker_invalid_fst
			--verifies that subtitle cannot be inserted between two subtitle because does not meet condition
		note
			testing: "covers/{MICRODVD_SUBTITLE}.checker"
		local
			sub, fst, snd: MICRODVD_SUBTITLE_ITEM
			subtitles: MICRODVD_SUBTITLE
		do
			create sub.make (2,5)
			create fst.make (1,3)
			create snd.make (8,9)
			create subtitles.make
			assert("The microdvd subtitle item cannot be inserted", not subtitles.checker(sub,fst,snd))
		end


	test_checker_invalid_snd
			--verifies that subtitle cannot be inserted between two subtitle because does not meet condition
		note
			testing: "covers/{MICRODVD_SUBTITLE}.checker"
		local
			sub, fst, snd: MICRODVD_SUBTITLE_ITEM
			subtitles: MICRODVD_SUBTITLE
		do
			create sub.make (4,9)
			create fst.make (1,3)
			create snd.make (8,9)
			create subtitles.make
			assert("The microdvd subtitle item cannot be inserted", not subtitles.checker(sub,fst,snd))
		end


	test_checker_invalid
			--verifies that subtitle cannot be inserted between two subtitle because does not meet condition
		note
			testing: "covers/{MICRODVD_SUBTITLE}.checker"
		local
			sub, fst, snd: MICRODVD_SUBTITLE_ITEM
			subtitles: MICRODVD_SUBTITLE
		do
			create sub.make (2,9)
			create fst.make (1,3)
			create snd.make (4,5)
			create subtitles.make
			assert("The microdvd subtitle item cannot be inserted", not subtitles.checker(sub,fst,snd))
		end

	test_out
		note
			testing: "convers/{MICRODVD_SUBTITLE}.out"
		local
			microdvd: MICRODVD_SUBTITLE
		do
			create microdvd.make
			microdvd.add_subtitle_item (24, 48,"Hola")
			microdvd.add_subtitle_item (72, 96,"Chau")
			assert("out",microdvd.out.is_equal ("{24}{48}Hola%N{72}{96}Chau%N"))
		end


	test_check_one_valid_subtitle_for_beginning
			--Checks that the subtitle can be inserted at the beginning
		note
			testing: "covers/{MICRODVD_SUBTITLE}.check_one"
		local
			sub,item: MICRODVD_SUBTITLE_ITEM
			subtitles: MICRODVD_SUBTITLE
		do
			create item.make (0,1)		 -- initial subtitle
			create sub.make (1,3)		-- subtitle to be inserted
			create subtitles.make
			assert("The microdvd subtitle item can be inserted at the beginning", subtitles.check_one(sub,item))
		end

	test_check_one_valid_subtitle_at_the_end
			--Checks that the subtitle can be inserted at the end
		note
			testing: "covers/{MICRODVD_SUBTITLE}.check_one"
		local
			sub,item: MICRODVD_SUBTITLE_ITEM
			subtitles: MICRODVD_SUBTITLE
		do
			create sub.make (1,3)	  -- subtitle to be inserted
			create item.make (4,6)    -- initial subtitle
			create subtitles.make
			assert("The microdvd subtitle item can be inserted at the end", subtitles.check_one (sub,item))
		end


	test_check_one_invalid_subtitle_for_beginning
			--Checks that subtitles cannot be inserted at the beginning, because does not meet conditions
		note
			testing: "covers/{MICRODVD_SUBTITLE}.check_one"
		local
			sub, item: MICRODVD_SUBTITLE_ITEM
			subtitles: MICRODVD_SUBTITLE
		do
			create sub.make (0,2)		-- subtitle to be inserted
			create item.make (1,3)	    -- initial subtitle
			create subtitles.make
			assert("The microdvd subtitle item cannot be inserted at the beginning", not subtitles.check_one(sub,item))
		end

	test_check_one_invalid_subtitle_at_the_end
			--Checks that subtitles cannot be inserted at the end, because does not meet conditions
		note
			testing: "covers/{MICRODVD_SUBTITLE}.check_one"
		local
			sub, item: MICRODVD_SUBTITLE_ITEM
			subtitles: MICRODVD_SUBTITLE
		do
			create sub.make (4,9)		-- subtitle to be inserted
			create item.make (1,6)	    -- initial subtitle
			create subtitles.make
			assert("The microdvd subtitle item cannot be inserted at the end", not subtitles.check_one(sub,item))
		end


	test_check_one_invalid_subtitle_within
			--Checks that subtitles cannot be inserted, because does not meet conditions
		note
			testing: "covers/{MICRODVD_SUBTITLE}.check_one"
		local
			sub, item: MICRODVD_SUBTITLE_ITEM
			subtitles: MICRODVD_SUBTITLE
		do
			create sub.make (2,4)		-- subtitle to be inserted
			create item.make (1,6)	    -- initial subtitle
			create subtitles.make
			assert("The microdvd subtitle item cannot be inserted", not subtitles.check_one(sub,item))
		end

	test_check_one_invalid_subtitle_equal
			--Checks that subtitles cannot be inserted, because does not meet conditions
		note
			testing: "covers/{MICRODVD_SUBTITLE}.check_one"
		local
			sub, item: MICRODVD_SUBTITLE_ITEM
			subtitles: MICRODVD_SUBTITLE
		do
			create sub.make (0,1)		-- subtitle to be inserted
			create item.make (0,1)	    -- initial subtitle
			create subtitles.make
			assert("The microdvd subtitle item cannot be inserted", not subtitles.check_one(sub,item))
		end

		test_convert_to_subrip
			-- Check that converts a subtitle microdvd to subrip
		note
			testing:  "covers/{SUBRIP_SUBTITLE}.convert_to_subrip"
		local
			subrip_sub: SUBRIP_SUBTITLE
			microdvd_sub: MICRODVD_SUBTITLE
		do
			create microdvd_sub.make
			create subrip_sub.make

			microdvd_sub.add_subtitle_item (36693,58750,"Text Subtitle")
			microdvd_sub.add_subtitle_item (336693,588750,"Text Subtitle")
			microdvd_sub.add_subtitle_item (9,72,"Text Subtitle")

			subrip_sub := microdvd_sub.convert_to_subrip

			assert("checks conversion start_time",subrip_sub.items.i_th (1).start_time.hours = 0)
			assert("checks conversion start_time",subrip_sub.items.i_th (1).start_time.minutes = 0)
			assert("checks conversion start_time",subrip_sub.items.i_th (1).start_time.seconds = 0)
			assert("checks conversion start_time",subrip_sub.items.i_th (1).start_time.milliseconds = 375)

			assert("checks conversion stop_time",subrip_sub.items.i_th (1).stop_time.hours = 0)
			assert("checks conversion stop_time",subrip_sub.items.i_th (1).stop_time.minutes = 0)
			assert("checks conversion stop_time",subrip_sub.items.i_th (1).stop_time.seconds = 3)
			assert("checks conversion stop_time",subrip_sub.items.i_th (1).stop_time.milliseconds = 4)

			assert("checks conversion start_time",subrip_sub.items.i_th (2).start_time.hours = 0)
			assert("checks conversion start_time",subrip_sub.items.i_th (2).start_time.minutes = 25)
			assert("checks conversion start_time",subrip_sub.items.i_th (2).start_time.seconds = 30)
			assert("checks conversion start_time",subrip_sub.items.i_th (2).start_time.milliseconds = 789)

			assert("checks conversion stop_time",subrip_sub.items.i_th (2).stop_time.hours = 0)
			assert("checks conversion stop_time",subrip_sub.items.i_th (2).stop_time.minutes = 40)
			assert("checks conversion stop_time",subrip_sub.items.i_th (2).stop_time.seconds = 50)
			assert("checks conversion stop_time",subrip_sub.items.i_th (2).stop_time.milliseconds = 980)

			assert("checks conversion start_time",subrip_sub.items.i_th (3).start_time.hours = 3)
			assert("checks conversion start_time",subrip_sub.items.i_th (3).start_time.minutes = 54)
			assert("checks conversion start_time",subrip_sub.items.i_th (3).start_time.seconds = 6)
			assert("checks conversion start_time",subrip_sub.items.i_th (3).start_time.milliseconds = 434)

			assert("checks conversion stop_time",subrip_sub.items.i_th (3).stop_time.hours = 6)
			assert("checks conversion stop_time",subrip_sub.items.i_th (3).stop_time.minutes = 49)
			assert("checks conversion stop_time",subrip_sub.items.i_th (3).stop_time.seconds = 21)
			assert("checks conversion stop_time",subrip_sub.items.i_th (3).stop_time.milliseconds = 953)

		end

end-- class MICRODVD_SUBTITLE_TESTS



