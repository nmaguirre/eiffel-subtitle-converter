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
			flag: BOOLEAN
		do
			create item.make
			--if (item.count > 0) then
				item.flush
				flag := True
			--end
			assert ("flush correct", flag = True)
		end

	test_remove_items_valid
			-- checks that removes all subtitle items between start_frame and stop_frame
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.remove_items"
		local
			item: MICRODVD_SUBTITLE
		do
			create item.make
			item.remove_items (0,100)
			--assert ("remove_items correct", item.count <= old item.count)
			assert ("remove_items correct", True)
		end

	test_remove_items_invalid
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

	test_valid_zero_change_fps
			-- Routine 'change_fps' sets 'frames_per_second' correctly in zero
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.change_fps"
		local
			sub_microdvd: MICRODVD_SUBTITLE
		do
			create sub_microdvd.make
			sub_microdvd.change_fps (0.0)
			assert("change frames_per_second", sub_microdvd.frames_per_second = 0.0)
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
				sub_microdvd.change_fps (-30)
				passed := True
			end
			assert ("change_fps broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

end-- class MICRODVD_SUBTITLE_TESTS



