note
	description	: "Root class for this application."
	author		: "Generated by the New Vision2 Application Wizard."
	date		: "$Date: 2015/9/8 18:38:1 $"
	revision	: "1.0.0"

class
	APPLICATION

inherit
	EV_APPLICATION

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
			-- Initialize and launch application
		do
			default_create
			prepare
			launch
		end

	prepare
			-- Prepare the first window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
			create controller.make_with_no_subtitle
			system_logic := controller.system_logic
			create first_window.create_with_logic (system_logic)
				-- Show the first window.
			first_window.show
		end

feature {NONE} -- Implementation

	first_window: MAIN_WINDOW
			-- Main window.

	controller: CONTROLLER
			-- Controller object.

	system_logic: CONVERTER_LOGIC
			-- Logic of the application


end -- class APPLICATION
