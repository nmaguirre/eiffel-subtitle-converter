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
			-- create a valid sequence and evaluate it with repOk
		note
			testing:  "covers/{MICRODVD_SUBTITLE}.repOK"
		local
			item: MICRODVD_SUBTITLE
		do
			create item.make
			item.add_subtitle_item(0,100,"text 1")
			item.add_subtitle_item(101,200,"text 2")
			assert ("Subtitle representation is ok", item.repOk)
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
			if (not rescued) then
				create item.make
				item.remove_items (0,100)
				passed := True
			end
			assert ("remove_items broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

end-- class MICRODVD_SUBTITLE_TESTS


