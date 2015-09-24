note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	CONVERTER_LOGIC_TEST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_make_valid_source
		note
			testing:  "covers/{COVERTER_LOGIC}.make"
		local
			converter: CONVERTER_LOGIC
		do
			create converter.make
			assert (" Make correct", converter.source = Void)
		end

	test_make_valid_target
		note
			testing:  "covers/{COVERTER_LOGIC}.make"
		local
			converter: CONVERTER_LOGIC
		do
			create converter.make
			assert (" Make correct", converter.target = Void)
		end


	test_has_load_subtitle_valid
		local
			passed: BOOLEAN
			converter : CONVERTER_LOGIC
			subtitle: MICRODVD_SUBTITLE
		do
			create subtitle.make
			create converter.make
			converter.set_source(subtitle)
			passed := (converter.source /= Void)
			assert ("has_load_subtitle correct", passed = True)
		end

	test_has_load_subtitle_invalid
		local
			passed: BOOLEAN
			converter : CONVERTER_LOGIC
		do
			create converter.make
			passed := (converter.source /= Void)
			assert ("has_load_subtitle isn't correct", passed = False)
		end

	test_has_loaded_subrip_subtitle_valid
		local
			passed: BOOLEAN
			converter : CONVERTER_LOGIC
			subtitle: SUBRIP_SUBTITLE
		do
			create converter.make
			create subtitle.make
			converter.set_source(subtitle)
			passed := (converter.has_loaded_subrip_subtitle)
			assert("Loaded subrip subtitle is correct ", passed =True)

		end


	test_has_loaded_subrip_subtitle_invalid
		local
			passed: BOOLEAN
			converter : CONVERTER_LOGIC
			subtitle: MICRODVD_SUBTITLE
		do
			create converter.make
			create subtitle.make
			converter.set_source(subtitle)
			passed := (converter.has_loaded_subrip_subtitle)
			assert("Loaded subrip subtitle isn't correct ", passed =False)

		end

	test_is_ready_to_convert_valid
		local
			passed: BOOLEAN
			converter : CONVERTER_LOGIC
			subtitle: MICRODVD_SUBTITLE
		do
			create converter.make
			create subtitle.make
			subtitle.add_subtitle_item(1,2,"texto")
			converter.set_source(subtitle)
			passed := (converter.source /= Void)
			assert ("is_ready_to_convert correct", passed = True)
		end

	test_is_ready_to_convert_invalid
		local
			passed: BOOLEAN
			converter: CONVERTER_LOGIC
		do
			create converter.make
			passed := (converter.source /= Void)
			assert ("is_ready_to_convert correct", passed = False)
		end

	test_has_loaded_microdvd_subtitle_valid
		note
			testing:  "covers/{CONVERTER_LOGIC_TEST}.has_loaded_microdvd_subtitle"
		local
			passed: BOOLEAN
			converter: CONVERTER_LOGIC
			subtitle: MICRODVD_SUBTITLE
		do
			create converter.make
			create subtitle.make
			converter.set_source(subtitle)
			passed := (converter.has_loaded_microdvd_subtitle)
			assert ("Loaded microdvd subtitle is correct ", passed = True)
		end

	test_has_loaded_microdvd_subtitle_invalid
		note
			testing:  "covers/{CONVERTER_LOGIC_TEST}.has_loaded_microdvd_subtitle"
		local
			passed: BOOLEAN
			converter: CONVERTER_LOGIC
			subtitle: SUBRIP_SUBTITLE
		do
			create converter.make
			create subtitle.make
			converter.set_source(subtitle)
			passed := (converter.has_loaded_microdvd_subtitle)
			assert ("Loaded microdvd subtitle isn´t correct ", passed = False)
		end

	test_set_source_subrip_valid
			-- Routine 'set_source' sets 'source' with a SUBRIP_SUBTITLE
		note
			testing:  "covers/{CONVERTER_LOGIC_TEST}.set_source"
		local
			converter: CONVERTER_LOGIC
			subrip_sub: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
		do
			create subrip_sub.make
			create start_time.make_with_values (00,25,30,800)
			create stop_time.make_with_values (00,40,50,999)
			subrip_sub.add_subtitle_item (start_time, stop_time,"Subtitle one")

			create start_time.make_with_values (00,50,40,600)
			create stop_time.make_with_values (1,12,30,800)
			subrip_sub.add_subtitle_item (start_time, stop_time,"Subtitle two")
			create converter.make
			converter.set_source (subrip_sub)
			assert ("set source",converter.source.is_equal(subrip_sub))
		end

	test_set_source_microdvd_valid
		-- Routine 'set_source' sets 'source' with a MICRODVD_SUBTITLE
		note
			testing:  "covers/{CONVERTER_LOGIC_TEST}.set_source"
		local
			converter: CONVERTER_LOGIC
			microdvd_sub: MICRODVD_SUBTITLE
			start_frame: MICRODVD_SUBTITLE_ITEM
			stop_frame:  MICRODVD_SUBTITLE_ITEM
		do
			create microdvd_sub.make
			microdvd_sub.add_subtitle_item (9, 72, "Subtitulo one")
			microdvd_sub.add_subtitle_item (84, 123, "Subtitulo two")
			microdvd_sub.add_subtitle_item (126, 168, "Subtitulo three")

			create converter.make
			converter.set_source (microdvd_sub)
			assert ("set source",converter.source.is_equal(microdvd_sub))
		end

	test_set_source_subrip_invalid
			-- Routine 'set_source' sets 'source' with a start_time invalid
		note
			testing:  "covers/{CONVERTER_LOGIC_TEST}.set_source"
		local
			converter: CONVERTER_LOGIC
			subrip_sub: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create subrip_sub.make
			create start_time.make_with_values (1,34,53,200)
			create stop_time.make_with_values (0,34,20,800)
			create converter.make
			if (not rescued) then
				subrip_sub.add_subtitle_item (start_time, stop_time,"Subtitle one")
				converter.set_source (subrip_sub)
				passed := True
			end
			assert ("set_source_subrip broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
	end

	test_set_source_microdvd_invalid
			-- Routine 'set_source' sets 'source' with a start_frame underhand
		note
			testing:  "covers/{CONVERTER_LOGIC_TEST}.set_source"
		local
			converter: CONVERTER_LOGIC
			microdvd_sub: MICRODVD_SUBTITLE
			start_frame: MICRODVD_SUBTITLE_ITEM
			stop_frame:  MICRODVD_SUBTITLE_ITEM
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create microdvd_sub.make
			create converter.make

			if (not rescued) then
				microdvd_sub.add_subtitle_item (9, 72, "Subtitulo one")
				microdvd_sub.add_subtitle_item (60, 123, "Subtitulo two")
				converter.set_source (microdvd_sub)
				passed := True
			end
			assert ("set_source_microdvd broke", not passed)
		rescue
			if (not rescued) then
				rescued := True
				retry
			end
	end
end


