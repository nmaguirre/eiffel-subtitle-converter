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

end


