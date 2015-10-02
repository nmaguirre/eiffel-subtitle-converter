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

	load_file_void_microdvd
			-- Scenario: Carga de un archivo en formato microdvd, el cual es vacio
			-- Then: El sistema informa que el archivo cargado no es valido para poder converir.
			-- Mensaje de Error: "Archivo no valido para realizar la conversion"

		local
			logic: CONVERTER_LOGIC
			controller: CONTROLLER
			rescued: BOOLEAN
		do
			if (not rescued) then
				create controller.make_with_microdvd_subtitle ("./acceptance_tests/voidSample.sub")
				logic := controller.system_logic
			end
			assert("Subtitle is void, source is void", not logic.has_loaded_subtitle)
			assert ("system not ready to convert", not logic.is_ready_to_convert)
		rescue
			if (not rescued) then
				rescued:= True
				retry
			end

		end
end
