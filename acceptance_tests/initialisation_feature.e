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


end
