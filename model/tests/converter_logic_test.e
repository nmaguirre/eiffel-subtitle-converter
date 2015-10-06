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
		-- Load subtitle subrip correct
		note
			testing : "covers/{CONVERTER_LOGIC}.has_loaded_subrip_subtitle"

		local
			passed: BOOLEAN
			converter : CONVERTER_LOGIC
			subtitle: SUBRIP_SUBTITLE
		do
			create converter.make
			create subtitle.make
			converter.set_source(subtitle)
			passed := (converter.source /= Void) and (converter.has_loaded_subrip_subtitle = True)
			assert("Loaded subrip subtitle is correct ", passed = True)

		end

	test_has_loaded_subrip_subtitle_invalid
		-- Load subtitle subrip invalid
		note
			testing : "covers/{CONVERTER_LOGIC}.has_loaded_subrip_subtitle"

		local
			passed: BOOLEAN
			converter : CONVERTER_LOGIC
			subtitle: MICRODVD_SUBTITLE
		do
			create converter.make
			create subtitle.make
			converter.set_source(subtitle)
			passed := (converter.source /= Void) and (converter.has_loaded_subrip_subtitle = False)
			assert("Loaded subrip subtitle isn't correct because of load microdvd subtitle ", passed = True)

		end

	test_has_loaded_subrip_subtitle_invalid_void
		-- without loaded subtitle for the  routine has_loaded_subrip_subtitle
		note
			testing : "covers/{CONVERTER_LOGIC}.has_loaded_subrip_subtitle"

		local
			converter: CONVERTER_LOGIC
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create converter.make
			if (not rescued) then
				passed:= converter.has_loaded_subrip_subtitle
			end
			passed := converter.source /= Void
			assert("Loaded subrip subtitle isn't correct because is empty ", not passed)

			rescue
			if (not rescued) then
				rescued := True
				retry
			end
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
			assert ("is_ready_to_convert correct", converter.is_ready_to_convert)
		end

	test_is_ready_to_convert_with_not_subtitle
		local
			passed: BOOLEAN
			converter: CONVERTER_LOGIC
		do
			create converter.make
			passed := (converter.source /= Void) and (converter.target = Void)
			assert ("is_ready_to_convert correct", not converter.is_ready_to_convert)
		end

	test_is_ready_to_convert_with_target_load
		local
			passed: BOOLEAN
			converter : CONVERTER_LOGIC
			subtitle: MICRODVD_SUBTITLE
		do
			create converter.make
			create subtitle.make
			subtitle.add_subtitle_item(1,2,"texto")
			converter.set_source(subtitle)
			converter.set_target(subtitle)
			assert ("is_ready_to_convert correct", not converter.is_ready_to_convert)
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


	test_has_converted_microdvd_valid
			--Check target is a microdvd subtitle when the conversion has been performed
		note
			testing:  "covers/{CONVERTER_LOGIC}.has_converted_microdvd"
		local
			sub: SUBRIP_SUBTITLE
			logic: CONVERTER_LOGIC
		do
			create sub.make
			create logic.make
			logic.set_source(sub)
			logic.convert_subtitle
			assert("Conversion has been performed and target contains a MicroDvD", logic.has_converted_microdvd)
		end


	test_has_converted_microdvd_invalid
			--Check target isn't a microdvd subtitle when the conversion has been performed
		note
			testing:  "covers/{CONVERTER_LOGIC}.has_converted_microdvd"
		local
			sub: MICRODVD_SUBTITLE
			logic: CONVERTER_LOGIC
			pass: BOOLEAN
		do
			create sub.make
			create logic.make
			logic.set_source(sub)
			logic.convert_subtitle
			pass:= logic.has_converted_microdvd
			assert("Conversion has been performed and target doesn't contains a MicroDvD", not pass)
		end


	test_has_converted_subtitle_valid
			--Check target isn't void when the conversion has been performed
		note
			testing:  "covers/{CONVERTER_LOGIC}.has_converted_subtitle"
		local
			sub: SUBRIP_SUBTITLE
			logic: CONVERTER_LOGIC
		do
			create sub.make
			create logic.make
			logic.set_source(sub)
			logic.convert_subtitle
			assert("Conversion has been performed and target contains a subtitle", logic.has_converted_subtitle)
		end


	test_has_converted_subtitle_invalid
			--Check target is void when the conversion hasn't taken place
		note
			testing:  "covers/{CONVERTER_LOGIC}.has_converted_subtitle"
		local
			sub: SUBRIP_SUBTITLE
			logic: CONVERTER_LOGIC
		do
			create sub.make
			create logic.make
			logic.set_source(sub)
			assert("Conversion hasn't performed and target is void", not logic.has_converted_subtitle)
		end


	test_set_source_subrip_valid
			-- Routine 'set_source' sets 'source' with a SUBRIP_SUBTITLE
		note
			testing:  "covers/{CONVERTER_LOGIC}.set_source"
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
			testing:  "covers/{CONVERTER_LOGIC}.set_source"
		local
			converter: CONVERTER_LOGIC
			microdvd_sub: MICRODVD_SUBTITLE
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
			-- Routine 'set_source' sets 'source' with a start_time greater than stop_time
		note
			testing:  "covers/{CONVERTER_LOGIC}.set_source"
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
			testing:  "covers/{CONVERTER_LOGIC}.set_source"
		local
			converter: CONVERTER_LOGIC
			microdvd_sub: MICRODVD_SUBTITLE
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

	test_source_as_subrip_void_valid
			-- Checks 'source_as_subrip' with a SUBRIP_SUBTITLE void
		note
			testing:  "covers/{CONVERTER_LOGIC}.source_as_subrip"
		local
			converter: CONVERTER_LOGIC
			subrip_sub: SUBRIP_SUBTITLE
		do
			create subrip_sub.make
			create converter.make
			converter.set_source (subrip_sub)
			assert ("source_as_subrip valid", converter.source.is_equal(converter.source_as_subrip))
		end

	test_source_as_subrip_valid
			-- Checks 'source_as_subrip' with a SUBRIP_SUBTITLE /= void
		note
			testing: "covers/{CONVERTER_LOGIC}.source_as_subrip"
		local
			converter: CONVERTER_LOGIC
			subrip_sub: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
		do
			create subrip_sub.make
			create converter.make
			create start_time.make_with_values (0, 10, 35, 100)
			create stop_time.make_with_values (0, 11, 25, 250)
			subrip_sub.add_subtitle_item (start_time, stop_time, "Subtitle line_one")
			create start_time.make_with_values (1, 22, 45, 350)
			create stop_time.make_with_values (1, 23, 50, 500)
			subrip_sub.add_subtitle_item (start_time, stop_time, "Subtitle line_two")

			converter.set_source (subrip_sub)
			assert("source_as_subrip valid", converter.source.is_equal(converter.source_as_subrip))
		end

	test_source_as_subrip_invalid
			-- Checks 'source_as_subrip' with an invalid SUBRIP_SUBTITLE
		note
			testing:  "covers/{CONVERTER_LOGIC}.source_as_subrip"
		local
			converter: CONVERTER_LOGIC
			subrip_sub: SUBRIP_SUBTITLE
			source_subrip_sub: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create subrip_sub.make
			create converter.make
			create start_time.make_with_values (2,23,40,600)
			create stop_time.make_with_values (1,40,28,100)
			if (not rescued) then
				subrip_sub.add_subtitle_item (start_time, stop_time,"Subtitle line")
				converter.set_source (subrip_sub)
				source_subrip_sub := converter.source_as_subrip
				passed := True
			end
			assert ("source_as_subrip broke", not passed)
			rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_source_as_microdvd_void_valid
			-- Checks 'source_as_microdvd' with a MICRODVD_SUBTITLE void
		note
			testing:  "covers/{CONVERTER_LOGIC}.source_as_microdvd"
		local
			converter: CONVERTER_LOGIC
			microdvd_sub: MICRODVD_SUBTITLE
		do
			create converter.make
			create microdvd_sub.make
			converter.set_source (microdvd_sub)

			assert("source_as_microdvd valid",converter.source.is_equal(converter.source_as_microdvd))
		end

	test_source_as_microdvd_valid
			-- Checks 'source_as_microdvd' with a MICRODVD_SUBTITLE /= void
		note
			testing:  "covers/{CONVERTER_LOGIC}.source_as_microdvd"
		local
			converter: CONVERTER_LOGIC
			microdvd_sub: MICRODVD_SUBTITLE
		do
			create converter.make
			create microdvd_sub.make
			microdvd_sub.add_subtitle_item (9,72,"Subtitle one")
			microdvd_sub.add_subtitle_item (84,123,"Subtitle two")
			converter.set_source (microdvd_sub)
			assert("source_as_microdvd valid",converter.source.is_equal(converter.source_as_microdvd))
		end

	test_source_as_microdvd_invalid
			-- Checks 'source_as_microdvd' with an invalid MICRODVD_SUBTITLE
		note
			testing:  "covers/{CONVERTER_LOGIC}.source_as_microdvd"
		local
			converter: CONVERTER_LOGIC
			microdvd_sub: MICRODVD_SUBTITLE
			source_microdvd_sub: MICRODVD_SUBTITLE
			passed: BOOLEAN
			rescued: BOOLEAN
		do
			create microdvd_sub.make
			create converter.make
			if (not rescued) then
				microdvd_sub.add_subtitle_item (9, 72, "Subtitulo one")
				microdvd_sub.add_subtitle_item (60, 123, "Subtitulo two")
				converter.set_source (microdvd_sub)
				source_microdvd_sub := converter.source_as_microdvd
				passed := True
			end
			assert ("source_as_microdvd broke", not passed)
			rescue
			if (not rescued) then
				rescued := True
				retry
			end
		end

	test_convert_subtitle_source_microdvd
		note
			testing: "covers/{CONVERTER_LOGIC}.convert_subtitle"
		local
			converter: CONVERTER_LOGIC
			subtitle : MICRODVD_SUBTITLE
		do
			create converter.make
			create subtitle.make
			subtitle.add_subtitle_item (0, 20,"Subtitle one")
			subtitle.add_subtitle_item (23, 67,"Subtitle two")
			subtitle.add_subtitle_item (68,89,"Subtitle three")
			converter.set_source(subtitle)
			converter.convert_subtitle
			assert("Convert is correct",attached {SUBRIP_SUBTITLE} converter.target)
		end

  test_convert_subtitle_source_subrip
  	note
		testing: "covers/{CONVERTER_LOGIC}.convert_subtitle"
  	local
  		converter: CONVERTER_LOGIC
  		subtitle_subrip: SUBRIP_SUBTITLE
  		subrip_start_time: SUBRIP_SUBTITLE_TIME
 		subrip_stop_time: SUBRIP_SUBTITLE_TIME
	do
  		create converter.make
  		create subtitle_subrip.make
  		create subrip_start_time.make_with_values (0,9,34,300)
  		create subrip_stop_time.make_with_values (0,19,0,200)
  		subtitle_subrip.add_subtitle_item (subrip_start_time, subrip_stop_time,"text one")

 		create subrip_start_time.make_with_values (3,36,23,0)
  		create subrip_stop_time.make_with_values (6,12,0,200)
  		subtitle_subrip.add_subtitle_item (subrip_start_time, subrip_stop_time,"text two")

  		create subrip_start_time.make_with_values (6,30,23,0)
  		create subrip_stop_time.make_with_values (6,56,45,700)
  		subtitle_subrip.add_subtitle_item (subrip_start_time, subrip_stop_time,"text three")

  		converter.set_source (subtitle_subrip)
  		converter.convert_subtitle
  		assert("Convert is correct",attached {MICRODVD_SUBTITLE} converter.target)
  end
end


