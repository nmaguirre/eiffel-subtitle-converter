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
	make

feature -- Initialisation

	make
	do

	end

feature

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


	is_ready_to_convert: BOOLEAN
			-- System is ready to convert: source is loaded, and
			-- conversion hasn't taken place yet
		do

		end

	set_source(new_source: SUBTITLE)
	do
		source := new_source
	ensure
		source_is_set: source.is_equal (new_source)
	end


feature

	convert_subtitle
		do

		end

feature

	source_as_microdvd: MICRODVD_SUBTITLE
		require
			has_loaded_microdvd_subtitle
		do
			if attached {MICRODVD_SUBTITLE} source as microdvd_sub then
				Result := microdvd_sub
			end
		end

	source: detachable SUBTITLE

	target: detachable SUBTITLE

end
