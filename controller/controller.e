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
			if system_logic.last_load_succeeded then
				system_logic.update
			end
		end

	load_subrip_subtitle (filename: STRING)
		require
			valid_filename: filename /= Void
		do
			system_logic.make_with_subrip_subtitle (filename)
			if system_logic.last_load_succeeded then
				system_logic.update
			end
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
				system_logic.convert_subtitle -- convert to microdvd
				system_logic.update
			end
			if attached {MICRODVD_SUBTITLE} system_logic.source as microdvd_sub then
				system_logic.convert_subtitle -- convert to srt
				system_logic.set_source (system_logic.target)
				system_logic.source_as_subrip.forward (milliseconds)
				system_logic.convert_subtitle -- convert to microdvd
				system_logic.update
			end
		end

	rewind (milliseconds: INTEGER)
		require
			milliseconds > 0
		do
			if attached {SUBRIP_SUBTITLE} system_logic.source as subrip_sub then
				system_logic.rewind (milliseconds)
				system_logic.convert_subtitle -- convert to microdvd
				system_logic.update
			end
			if attached {MICRODVD_SUBTITLE} system_logic.source as microdvd_sub then
				system_logic.convert_subtitle -- convert to srt
				system_logic.set_source (system_logic.target)
				system_logic.source_as_subrip.rewind (milliseconds)
				system_logic.convert_subtitle -- convert to microdvd
				system_logic.update
			end
		end

	change_fps(fps :INTEGER)
		do
			if attached {MICRODVD_SUBTITLE} system_logic.source as microdvd_sub then
				system_logic.source_as_microdvd.change_fps (fps)
				system_logic.update
			else
				if attached {SUBRIP_SUBTITLE} system_logic.source as subrip_sub	then
					system_logic.convert_subtitle
					system_logic.set_source (system_logic.target)
					system_logic.source_as_microdvd.change_fps (fps)
					system_logic.update
				end

			end

		end

feature

	system_logic: CONVERTER_LOGIC

end
