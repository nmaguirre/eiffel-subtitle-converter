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
			flag: BOOLEAN
		do
			create subtitle.make
			subtitle.add_subtitle_item (0, 5, "test flush_items_not_empty")
			if (subtitle.items.count /= 0) then
				subtitle.flush
				flag := true
			end
			assert ("flush correct", flag = True)
			assert ("flush correct", subtitle.items.count = 0)
		end

	test_remove_items_valid
			-- checks that removes all subtitle items between start_frame and stop_frame
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.remove_items"
		local
			subtitle: MICRODVD_SUBTITLE
			old_value: INTEGER
		do
			create subtitle.make
			subtitle.add_subtitle_item (0, 5, "text_one")
			subtitle.add_subtitle_item (10, 15, "text_two")
			old_value := subtitle.items.count
			subtitle.remove_items (0,5)
			assert ("remove_items correct", subtitle.items.count <=  old_value)
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
			assert ("Add Subtitle is ok",sub.items[1].text ="text1"
			and sub.items[2].text="text2"
			and sub.items[3].text="text3")
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



end-- class MICRODVD_SUBTITLE_TESTS



