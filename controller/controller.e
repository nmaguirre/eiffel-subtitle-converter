note
	description: "Summary description for {CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONTROLLER

create
	make_with_no_subtitle, make_with_microdvd_subtitle, make_with_subrip_subtitle

feature

	make_with_no_subtitle
			-- Initialises the controller and logic
			-- with no loaded subtitle
		do
			create system_logic.make
		ensure
			logic_check: system_logic /= void
		end

	make_with_microdvd_subtitle (filename: STRING; main: MAIN_WINDOW)
		require
			valid_filename: filename /= Void
		do
			gui := main
			create system_logic.make_with_microdvd_subtitle(filename)
		end

	make_with_subrip_subtitle (filename: STRING; main: MAIN_WINDOW)
		require
			valid_filename: filename /= Void
		do
			gui := main
			create system_logic.make_with_subrip_subtitle (filename)
		end

	convert_sub
		do
			system_logic.convert_subtitle
			gui.on_update

		end
	
feature

	system_logic: CONVERTER_LOGIC
	gui: MAIN_WINDOW
end
