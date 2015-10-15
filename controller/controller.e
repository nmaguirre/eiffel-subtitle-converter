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
			system_logic.update
		end

	load_subrip_subtitle (filename: STRING)
		require
			valid_filename: filename /= Void
		do
			system_logic.make_with_subrip_subtitle (filename)
			system_logic.update
		end

	save(filename: STRING)
		do
			system_logic.save (filename)
		end

feature --Conversion
	convert_subtitle
		do
			system_logic.convert_subtitle
			system_logic.update
			system_logic.set_source (system_logic.target)
		end

	forward (milliseconds: INTEGER)
		require
			milliseconds > 0
		do
			if attached {SUBRIP_SUBTITLE} system_logic.source as subrip_sub then
				system_logic.forward (milliseconds)
				system_logic.update
			end
		end

	rewind (milliseconds: INTEGER)
		require
			milliseconds > 0
		do
			if attached {SUBRIP_SUBTITLE} system_logic.source as subrip_sub then
				system_logic.rewind (milliseconds)
				system_logic.update
			end
		end

feature

	system_logic: CONVERTER_LOGIC

end
