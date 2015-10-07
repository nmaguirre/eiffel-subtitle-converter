note
	description: "Summary description for {CONVERSION_FEATURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERSION_FEATURE

inherit

	EQA_TEST_SET

feature -- Test routines
	microdvd_to_subrip
			--Scenario: Converting a subtitle from MicroDVD to SubRip, with default framerate, and all subtitle items
			--              within the first minute of reproduction.
			--        Given that the system has been loaded with the MicroDVD subtitle
			--            {0}{50}Hola
			--            {100}{150}Chau
			--        When the user selects the convert subtitle option
			--        Then the obtained subtitle is in SubRip format, and contains the following
			--            1
			--            00:00:00,000 --> 00:00:02,086
			--            Hola

			--            2
			--            00:00:04,172 --> 00:00:06,258
			--            Chau
		local
			microdvd_sub: MICRODVD_SUBTITLE
			subrip_sub: SUBRIP_SUBTITLE
			logic: CONVERTER_LOGIC
			other: STRING
		do
			create microdvd_sub.make
			create subrip_sub.make
			create logic.make

			microdvd_sub.add_subtitle_item (0, 50,"Hola")
			microdvd_sub.add_subtitle_item (100, 150,"Chau")

			logic.set_source (microdvd_sub)
			logic.convert_subtitle
			subrip_sub:= logic.target_as_subrip

			create other.make_from_string (
			"1%N00:00:00,000 --> 00:00:02,086%NHola%N%N2%N00:00:04,172 --> 00:00:06,258%NChau%N%N"
			)
			assert("Subtitle has been well converted",subrip_sub.out.is_equal (other))
		end

	convert_subtitle_no_loaded
			--	Scenario: Initialising the subtitle converter application, there is no subtitle loaded and an
			--			attempted conversion is executed			
			--		When try to perform a conversion and there is any subtitle loaded
			--		Then the system show a error message
		local
			logic: CONVERTER_LOGIC
			controller: CONTROLLER
			rescued: BOOLEAN
		do
			create controller.make_with_no_subtitle
			logic := controller.system_logic
			if (not rescued)
			then
				logic.convert_subtitle
			end
			assert("there is no subtitle loaded", not logic.has_loaded_subtitle)
			rescue
				if (not rescued) then
					rescued := True
					retry
				end
		end

	convert_file_void_microdvd
			--		Scenario: convert an empty subtitle in microdvd format.
			--		When an empty microdvd subtitle is loaded and perform the conversion
			--		Then the system should return an empty subtitle in subrip format
		local
			logic: CONVERTER_LOGIC
			controller: CONTROLLER
			microdvd_sub: MICRODVD_SUBTITLE
			subrip_sub: SUBRIP_SUBTITLE
		do
			create controller.make_with_microdvd_subtitle ("./acceptance_tests/voidSample.sub")
			logic := controller.system_logic
			microdvd_sub := logic.source_as_microdvd
			logic.convert_subtitle
			subrip_sub := logic.target_as_subrip
			assert("source_as_microdvd empty", microdvd_sub.nr_of_items = 0)
			assert("target_as_subrip empty", subrip_sub.nr_of_items = 0)
			assert("source and target are both empty", microdvd_sub.nr_of_items = subrip_sub.nr_of_items)
		end

	convert_file_void_subrip
			--		Scenario: convert an empty subtitle with subrip format.
			--		When an empty subrip subtitle is loaded and perform the conversion
			--		Then the system should return an empty subtitle in microdvd format
		local
			logic: CONVERTER_LOGIC
			controller: CONTROLLER
			microdvd_sub: MICRODVD_SUBTITLE
			subrip_sub: SUBRIP_SUBTITLE
		do
			create controller.make_with_subrip_subtitle ("./acceptance_tests/voidSample.srt")
			logic := controller.system_logic
			subrip_sub := logic.source_as_subrip
			logic.convert_subtitle
			microdvd_sub := logic.target_as_microdvd
			assert("source_as_subrip empty", subrip_sub.nr_of_items = 0)
			assert("target_as_microdvd empty", microdvd_sub.nr_of_items = 0)
			assert("source and target are both empty", microdvd_sub.nr_of_items = subrip_sub.nr_of_items)
		end
end
