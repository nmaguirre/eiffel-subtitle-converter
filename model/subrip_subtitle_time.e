note
	description: "Class that represents the time as used in subtitles in SubRip format."
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"

class
	SUBRIP_SUBTITLE_TIME

create
	make, make_with_values

feature -- Initialisation

	make
			-- Creates time with default values hh:mm:ss:mmmm
		do

		end

	make_with_values (new_hours: INTEGER; new_minutes: INTEGER; new_seconds: INTEGER; new_mil: INTEGER)
			-- Creates time with provided values for hours, minutes, etc.
		do
			hours := new_hours
			minutes := new_minutes
			seconds := new_Seconds
			milliseconds := new_mil
		end

feature -- Status setting

	set_hour (new_hour: INTEGER)
			-- sets hours to provided value
		do
			hours:= new_hour
		end

	set_minute (new_minute: INTEGER)
			-- sets minutes to provided value
		do

		end

	set_seconds (new_seconds: INTEGER)
			-- sets seconds to provided value
		do

		end

	set_milliseconds (new_milliseconds: INTEGER)
			-- sets milliseconds to provided value
		do

		end

	move_forward (offset_milliseconds: INTEGER)
			-- Moves the time forward the number of provided milliseconds
		do

		end

	rewind (offset_milliseconds: INTEGER)
			-- Moves the time backward the numbe of provided milliseconds
		do

		end

feature -- Status report

	hours: INTEGER
			-- hours of the time

	minutes: INTEGER
			-- minutes of the time

	seconds: INTEGER
			-- seconds of the time

	milliseconds: INTEGER
			-- milliseconds of the time

invariant

end
