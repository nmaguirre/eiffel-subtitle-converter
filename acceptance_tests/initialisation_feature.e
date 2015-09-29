note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	INITIALISATION_FEATURE

inherit

	EQA_TEST_SET

feature -- Test routines

	default_system_start
			--    Scenario: Initialising the subtitle converter application with no provided parameters
			--        When the system is started without any provided parameters
			--        Then the system state should be initialised with no loaded subtitles
			--        And the user should be informed about the system having no loaded subtitles
		local
			controller: CONTROLLER
			logic: CONVERTER_LOGIC
		do
			-- When the system is started without any provided parameters
			create controller.make_with_no_subtitle
			-- Then the system state should be initialised with no loaded subtitles
			logic := controller.system_logic
			assert ("no loaded subtitles", not logic.has_loaded_subtitle)
		end



	system_start_with_microdvd_subtitle
			--    Scenario: Initialising the subtitle converter application with a valid MicroDVD subtitle
			--        Given a MicroDVD subtitle file with extension .sub, containing:
			--            {1}{10}Hola
			--            {12}{24}Chau
			--        When the system is started with the name of the file as a parameter
			--        Then the system state should be initialised loading the provided subtitle
			--        And the frame rate should be the default
			--        And the user should be informed that the system is ready to convert to SubRip format.
		local
			controller: CONTROLLER
			logic: CONVERTER_LOGIC
		do
			--        Given a MicroDVD subtitle file with extension .sub, containing:
			--            {1}{10}Hola
			--            {12}{24}Chau
			--        When the system is started with the name of the file as a parameter
			create controller.make_with_microdvd_subtitle ("./acceptance_tests/sample.sub")
			--        Then the system state should be initialised loading the provided subtitle
			logic := controller.system_logic
			assert ("loaded subtitle is microdvd", logic.has_loaded_microdvd_subtitle)
			assert ("loaded subtitle has two items", logic.source_as_microdvd.nr_of_items = 2)
			--        And the frame rate should be the default
			assert ("frame rate is the default", logic.source_as_microdvd.frames_per_second = default_framerate)
			--        And the user should be informed that the system is ready to convert to SubRip format.
			assert ("system ready to convert", logic.is_ready_to_convert)
		end


	system_start_with_subrip_subtitle
			--	    Scenario: Initialising the subtitle converter application with a valid SubRip subtitle
			--        Given a SubRip subtitle file with extension .srt, containing:
			--            1
			--            00:00:00,394 --> 00:00:03,031
			--            Hola

			--            2
			--            00:00:03,510 --> 00:00:05,154
			--            Chau
			--        When the system is started with the name of the file as a parameter
			--        Then the system state should be initialised loading the provided subtitle
			--        And the user should be informed that the system is ready to convert to MicroDVD format.
		local
			controller: CONTROLLER
			logic: CONVERTER_LOGIC
		do
			--        Given a SubRip subtitle file with extension .srt, containing:
			--            1
			--            00:00:00,394 --> 00:00:03,031
			--            Hola

			--            2
			--            00:00:03,510 --> 00:00:05,154
			--            Chau
			--        When the system is started with the name of the file as a parameter
			create controller.make_with_subrip_subtitle ("./acceptance_tests/sample.srt")
			--        Then the system state should be initialised loading the provided subtitle
			logic := controller.system_logic
			assert ("loaded subtitle is microdvd", logic.has_loaded_subrip_subtitle)
			assert ("loaded subtitle has two items", logic.source_as_subrip.nr_of_items = 2)
			--        And the user should be informed that the system is ready to convert to SubRip format.
			assert ("system ready to convert", logic.is_ready_to_convert)
		end

	system_start_with_invalid_microdvd_subtitle
--    Scenario: Initialising the subtitle converter application with invalid MicroDVD subtitle
--        Given a MicroDVD subtitle file with extension .sub, containing:
--            {10}{0}Hola
--        When the system is started with the name of the file as a parameter
--        Then the system state should be initialised with no loaded subtitles
--        And the user should be informed that the attempted load has failed
		local
			controller: CONTROLLER
			logic: CONVERTER_LOGIC
		do
--        Given a MicroDVD subtitle file with extension .sub, containing:
--            {10}{0}Hola
--        When the system is started with the name of the file as a parameter

			create controller.make_with_microdvd_subtitle ("./acceptance_tests/invalidSample.sub")
--        Then the system state should be initialised with no loaded subtitles
--        And the user should be informed that the attempted load has failed
			logic := controller.system_logic
			assert ("load failed", not logic.last_load_succeeded)
			assert ("loaded subtitle is microdvd", not logic.has_loaded_subtitle)
		end

	system_start_with_invalid_subrip_subtitle
			--	    Scenario: Initialising the subtitle converter application with a invalid SubRip subtitle
			--        Given a SubRip subtitle file with extension .srt, containing:
			--            1
			--            00:00:05,394 --> 00:00:03,031
			--            Hola
			--        When the system is started with the name of the file as a parameter
			--        Then the system state should be initialised loading the provided subtitle
			--        And the user should be informed that the attempted load has failed

		local
			controller: CONTROLLER
			logic: CONVERTER_LOGIC
		do
			--        Given a SubRip subtitle file with extension .srt, containing:
			--            1
			--            00:00:05,394 --> 00:00:03,031
			--            Hola

			--        When the system is started with the name of the file as a parameter
			create controller.make_with_subrip_subtitle ("./acceptance_tests/invalidSample.srt")
			--        Then the system state should be initialised loading the provided subtitle
			--        And the user should be informed that the attempted load has faile

			logic := controller.system_logic
			assert ("load failed", not logic.last_load_succeeded)
			assert ("loaded subtitle is subrip", not logic.has_loaded_subtitle)
		end

feature

	default_framerate: REAL = 23.97

end
