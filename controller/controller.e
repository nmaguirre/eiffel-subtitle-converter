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

	make_with_microdvd_subtitle (filename: STRING)
		require
			valid_filename: filename /= Void
		do
			create system_logic.make_with_microdvd_subtitle(filename)
		ensure
	--		microdvd_check: system_logic = filename
		end

	make_with_subrip_subtitle (filename: STRING)
		require
			valid_filename: filename /= Void
		do
			create system_logic.make_with_subrip_subtitle (filename)
		end

feature --Loading Files

	load_microdvd_subtile(filename: STRING)
		require
			valid_filename: filename /= Void
		do
			system_logic.make_with_microdvd_subtitle(filename)
			window.on_update
		end

	load_subrip_subtitle (filename: STRING)
		require
			valid_filename: filename /= Void
		do
			system_logic.make_with_subrip_subtitle (filename)
			window.on_update
		end


feature -- Inicialization
	set_window(new_window: MAIN_WINDOW)
		do
			window:= new_window
		end
feature

	system_logic: CONVERTER_LOGIC

	window: MAIN_WINDOW

end
