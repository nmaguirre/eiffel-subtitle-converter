note
	description: "Class that represents the time as used in subtitles in SubRip format."
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"

class
	SUBRIP_SUBTITLE_TIME

inherit
	COMPARABLE
		redefine
			is_less,out
		end

create
	make, make_with_values, make_from_string

feature -- Initialisation

	make
			-- Creates time with default values hh:mm:ss:mmmm
		do
		ensure
			hours=0 and
			minutes=0 and
			seconds=0 and
			milliseconds=0
		end

	make_with_values (new_hours: INTEGER; new_minutes: INTEGER; new_seconds: INTEGER; new_mil: INTEGER)
			-- Creates time with provided values for hours, minutes, etc.
		require
			valid_hours: (new_hours < 24) and (new_hours >= 0)
			valid_minutes: (new_minutes < 60) and (new_minutes >= 0)
			valid_seconds: (new_seconds < 60) and (new_seconds >= 0)
			valid_milliseconds: (new_mil < 1000) and (new_mil >= 0)
		do
			hours := new_hours
			minutes := new_minutes
			seconds := new_seconds
			milliseconds := new_mil
		ensure
			hours=new_hours and
			minutes=new_minutes and
			seconds=new_seconds and
			milliseconds=new_mil
		end

	make_from_string (timecode: STRING)
			-- Creates subrip_subtitle_time from its timecode string format
			-- hours:minutes:seconds,milliseconds
		require
			timecode.count = 12
		do
			hours := timecode.substring(1,2).to_integer
			minutes := timecode.substring(4,5).to_integer
			seconds := timecode.substring(7,8).to_integer
			milliseconds := timecode.substring(10,12).to_integer
		end

feature -- Status setting

	time_milliseconds:INTEGER
		do
			Result:= hours*3600000 + minutes*60000 + seconds*1000 + milliseconds
		ensure
			total_milliseconds: Result = (hours*3600000 + minutes*60000 + seconds*1000 + milliseconds)
		end


	set_hour (new_hour: INTEGER)
			-- sets hours to provided value

		require (new_hour < 24) and (new_hour >= 0)
		do
			hours:= new_hour
		ensure
			hours = new_hour
		end

	set_minute (new_minute: INTEGER)
			-- sets minutes to provided value
		require (new_minute < 60) and (new_minute >= 0)
		do
			minutes:= new_minute
		ensure
			minutes = new_minute
		end

	set_seconds (new_seconds: INTEGER)
			-- sets seconds to provided value
		require (new_seconds < 60) and (new_seconds >= 0)
		do
			seconds:= new_seconds
		ensure
			seconds= new_seconds
		end

	set_milliseconds (new_milliseconds: INTEGER)
			-- sets milliseconds to provided value
		require
			(new_milliseconds >= 0) and (new_milliseconds < 1000)
		do
			milliseconds := new_milliseconds

		ensure
			milliseconds = new_milliseconds
		end

	move_forward (offset_milliseconds: INTEGER)
			-- Moves the time forward the number of provided milliseconds
		require
			valid_milliseconds: offset_milliseconds > 0
		local
			remainder_hours,remainder_minutes:INTEGER
		do
			hours := hours + offset_milliseconds//3600000
			remainder_hours := offset_milliseconds\\3600000;

			minutes := minutes + remainder_hours//60000
			remainder_minutes := remainder_hours\\60000;

			seconds := seconds + remainder_minutes//1000
			milliseconds := milliseconds + remainder_minutes\\1000
		ensure
			hours = old hours + offset_milliseconds//3600000
			minutes = old minutes + (offset_milliseconds\\3600000)//60000
			seconds = old seconds + (offset_milliseconds\\3600000)//1000
			milliseconds = old milliseconds + 	(offset_milliseconds\\3600000)\\1000
		end

	rewind (offset_milliseconds: INTEGER)
			-- Moves the time backward the numbe of provided milliseconds
		require
			valid_milliseconds: offset_milliseconds > 0 and time_milliseconds-offset_milliseconds>=0
		local
			remainder_hours,remainder_minutes: INTEGER
		do
			hours := hours - offset_milliseconds//3600000
			remainder_hours := offset_milliseconds\\3600000

			minutes := minutes - remainder_hours//60000
			remainder_minutes := remainder_hours\\60000

			seconds := seconds - remainder_minutes//1000
			milliseconds := milliseconds - remainder_minutes\\1000
		ensure
			valid_hours: hours = (old hours) - offset_milliseconds//3600000
			valid_minutes: minutes = (old minutes) - (offset_milliseconds\\3600000)//60000
			valid_seconds: seconds = (old seconds) - ((offset_milliseconds\\3600000)\\60000)//1000
		 	valid_milliseconds: milliseconds = (old milliseconds) - ((offset_milliseconds\\3600000)\\60000)\\1000
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
		do
			Result := Current.time_milliseconds < other.time_milliseconds
		end

feature {NONE} -- Auxiliary Functions

	fill_with_zeros(act:STRING;size:INTEGER):STRING
		do
			from

			until
				act.count=size
			loop
				act.precede('0')
			end
		end


feature -- Status report

	out: STRING
			-- Returns the STRING representation of the time
		local
			res,final_hours,final_minutes,final_seconds,final_milliseconds: STRING
		do
			create final_hours.make_from_string (hours.out)
			if(final_hours.count<2) then
				final_hours:=fill_with_zeros(final_hours,2)
			end

			create final_minutes.make_from_string (minutes.out)
			if(final_minutes.count<2) then
				final_minutes:=fill_with_zeros(final_minutes,2)
			end

			create final_seconds.make_from_string (seconds.out)
			if(final_seconds.count<2) then
				final_seconds:=fill_with_zeros(final_seconds,2)
			end

			create final_milliseconds.make_from_string (milliseconds.out)
			if(final_milliseconds.count<3) then
				final_milliseconds:=fill_with_zeros(final_milliseconds,3)
			end

			res.make_empty
			res.append(final_hours+":"+final_minutes+":"+final_seconds+","+final_milliseconds)
			Result := res
		end

	hours: INTEGER
			-- hours of the time

	minutes: INTEGER
			-- minutes of the time

	seconds: INTEGER
			-- seconds of the time

	milliseconds: INTEGER
			-- milliseconds of the time

invariant
	valid_hours: hours >= 0 and hours < 24
	valid_minutes: minutes >= 0 and minutes < 60
	valid_seconds: seconds >= 0 and seconds < 60
	valid_milliseconds: milliseconds >= 0 and milliseconds < 1000
end
