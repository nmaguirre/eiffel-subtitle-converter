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

feature

	default_framerate: REAL = 23.97

end