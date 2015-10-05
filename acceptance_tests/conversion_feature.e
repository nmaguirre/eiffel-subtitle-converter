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

	microdvd_to_subrip_custom_framerate
    		--Scenario: Converting a subtitle from MicroDVD to SubRip, with a custom framerate, and all subtitle items
            --  			within the first minute of reproduction.
        	--		Given that the system has been loaded with the MicroDVD subtitle and the user selects a framerate equals to 25
            --			{0}{50}Hola
            --			{100}{150}Chau
        	--		When the user selects the convert subtitle option
        	--		Then the obtained subtitle is in SubRip format, and contains the following
            --			1
            --			00:00:00,000 --> 00:00:02,000
            --			Hola

            --			2
            --			00:00:04,000 --> 00:00:06,000
            --			Chau
		local
			microdvd_subtitle: MICRODVD_SUBTITLE
			subrip_subtitle: SUBRIP_SUBTITLE
			comparison_subrip_subtitle: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
			converter_logic: CONVERTER_LOGIC
			text: STRING
		do
			create microdvd_subtitle.make
			create subrip_subtitle.make
			microdvd_subtitle.change_fps (25)
			microdvd_subtitle.add_subtitle_item (0, 50,"Hola")
			microdvd_subtitle.add_subtitle_item (100, 150,"Chau")

			create converter_logic.make
			converter_logic.set_source (microdvd_subtitle)
			converter_logic.convert_subtitle
			subrip_subtitle := converter_logic.target_as_subrip

			create comparison_subrip_subtitle.make
			create start_time.make_with_values (00, 00, 00, 000)
			create stop_time.make_with_values (00, 00, 02, 000)
			text := "Hola"
			comparison_subrip_subtitle.add_subtitle_item (start_time, stop_time, text)
			start_time.set_seconds (4)
			stop_time.set_seconds (6)
			text := "Chau"
			comparison_subrip_subtitle.add_subtitle_item (start_time, stop_time, text)
			assert("MicroDVD Subtitle has been successfully converted to SubRip",subrip_subtitle.out.is_equal (comparison_subrip_subtitle.out))
		end
end
