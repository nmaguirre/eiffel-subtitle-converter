note
	description: "Summary description for {CONVERTER_LOGIC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERTER_LOGIC

inherit
	ABSTRACT_SUBJECT

create

	make,make_with_microdvd_subtitle, make_with_subrip_subtitle

feature -- Initialisation

	make
			-- Default constructor
		do
			source := Void
			target := Void
		ensure
			valid_source_and_target: source = Void and target = Void
		end

	make_with_subrip_subtitle (filename: STRING)
			-- Constructor takes as a parameter a filename of a
			-- subrip subtitle file, setting source with it.
		local
			subrip_subtitle: SUBRIP_SUBTITLE
		do
			create subrip_subtitle.make_from_file (filename)
			if subrip_subtitle.repok then
				source := subrip_subtitle
				target := Void
				last_load_succeeded := True
			else
				source := Void
				target := Void
				last_load_succeeded := False
			end
		ensure
			valid_source: (source /= Void and last_load_succeeded = true) or (source = Void and last_load_succeeded = false)
			valid_target: target = Void
		end

	make_with_microdvd_subtitle(file_name: STRING)
			-- Create converter logic with a microdvd subtitle as source
		local
			microdvd : MICRODVD_SUBTITLE
		do
			create microdvd.make_from_file(file_name)
			if(microdvd.repok) then
				source := microdvd
				target := Void
				last_load_succeeded := true
			else
				source := Void
				target := Void
				last_load_succeeded := false
			end
		ensure
			valid_source: (source /= Void and last_load_succeeded = true) or (source = Void and last_load_succeeded = false)
			valid_target: target = Void
		end


feature
	last_load_succeeded : BOOLEAN

	has_loaded_subtitle: BOOLEAN
			-- Is there a subtitle loaded?
		do
			Result := source /= Void
		end

	has_loaded_microdvd_subtitle: BOOLEAN
			-- Is the loaded subtitle a MicroDVD one?
		require
			has_loaded_subtitle
		do
			if attached {MICRODVD_SUBTITLE} source as microdvd_sub then
				Result := True
			else
				Result := False
			end

		end

	has_loaded_subrip_subtitle: BOOLEAN
			-- Is the loaded subtitle a SubRip one?
		require
			has_loaded_subtitle
		do
			if attached {SUBRIP_SUBTITLE} source as subrip_sub then
				Result := True
			else
				Result := False
			end
		end


	is_ready_to_convert: BOOLEAN
			-- System is ready to convert: source is loaded, and
			-- conversion hasn't taken place yet
		require
			has_loaded_subtitle /= Void
		do
			Result := has_loaded_subtitle and target = Void
		end

	set_source(new_source: SUBTITLE)
		require
			valid_new_source: new_source /= Void
		do
			source := new_source
		ensure
			source_is_set: source.is_equal(new_source)
		end

	set_target(new_target: SUBTITLE) obsolete "To be deleted: Unnecessary feature"
		do
			target := new_target
		end

feature

	convert_subtitle
			-- Converts the contents of 'source' and set 'target'.
			-- If 'source' is a microdvd subtitle, 'target' will be a subrip subtitle.
			-- In the other hand, if 'source' is a subrip subtitle, 'target' will be a microdvd subtitle.
		do
			if attached {MICRODVD_SUBTITLE} source as microdvd_sub
			then
				target := microdvd_sub.convert_to_subrip
			end
			if attached {SUBRIP_SUBTITLE} source as subrip_sub
			then
				target := subrip_sub.convert_to_microdvd
			end

		end


feature

	source_as_microdvd: MICRODVD_SUBTITLE
			-- Return the source as a MICRODVD_SUBTITLE object
		require
			has_loaded_microdvd_subtitle
		do
			if attached {MICRODVD_SUBTITLE} source as microdvd_sub then
				Result := microdvd_sub
			end
		end

	source_as_subrip: SUBRIP_SUBTITLE
			-- Return the source as a SUBRIP_SUBTITLE object
		require
			has_loaded_subrip_subtitle
		do
			if attached {SUBRIP_SUBTITLE} source as subrip_sub then
				Result := subrip_sub
			end

		ensure
	    	valid_source: attached {SUBRIP_SUBTITLE} Result
		end


	flush_target_source
		do
			if attached {SUBRIP_SUBTITLE} source as subrip and
			   attached {MICRODVD_SUBTITLE} target as microdvd
			then
				subrip.flush
				microdvd.flush
			end
			if attached {MICRODVD_SUBTITLE} source as microdvd and
			   attached {SUBRIP_SUBTITLE} target as subrip
			then
				microdvd.flush
				subrip.flush
			end
		end

	forward_subtitle_conver_logic(for_sub:STRING)
		local
			subrip_sub_time: SUBRIP_SUBTITLE_TIME
			time_milliseconds:INTEGER
		do
			create subrip_sub_time.make_from_string (for_sub)
			time_milliseconds:= subrip_sub_time.time_milliseconds
			subrip_sub_time.move_forward (time_milliseconds)
		end

	rewind_subtitle_conver_logic(rew_sub: STRING)
		local
			subrip_sub_time: SUBRIP_SUBTITLE_TIME
			time_milliseconds:INTEGER
		do
			create subrip_sub_time.make_from_string (rew_sub)
			time_milliseconds:= subrip_sub_time.time_milliseconds
			subrip_sub_time.rewind (time_milliseconds)
		end
	source: detachable SUBTITLE

	target: detachable SUBTITLE

end
