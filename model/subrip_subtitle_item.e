note
	description: "Class that represents the items that conform a subtitle in SubRip format."
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"

class
	SUBRIP_SUBTITLE_ITEM

inherit
	ANY
		redefine
			out
		end

create
	make, make_with_text, make_from_string

feature -- Initialisation

	make (new_start_time: SUBRIP_SUBTITLE_TIME; new_stop_time: SUBRIP_SUBTITLE_TIME)
			-- Constructs a subrip sub. item with empty text, and provided
			-- start and stop times
		require
			valid_time: new_stop_time.time_milliseconds > new_start_time.time_milliseconds
		do
			start_time:=new_start_time
			stop_time:=new_stop_time
			create text.make_empty
		ensure
			valid_result: start_time.is_equal(new_start_time) and
						  stop_time.is_equal(new_stop_time) and
						  text.is_empty
		end

	make_with_text (new_start_time: SUBRIP_SUBTITLE_TIME; new_stop_time: SUBRIP_SUBTITLE_TIME; new_text: STRING)
			-- Constructs a subrip sub. item with provided text, start and stop times
		require
			valid_time: new_start_time < new_stop_time
			new_text_not_void: new_text /= Void
		do
			start_time := new_start_time
			stop_time := new_stop_time
			text := new_text
		ensure
			valid_result:start_time.is_equal(new_start_time) and
						 stop_time.is_equal(new_stop_time)   and
		    			 text.is_equal (new_text)
		end

	make_from_string (time_line: STRING; subtitle_text: STRING)
			-- Initialize a subrip_subtitle_item
		do
			start_time.make_from_string (time_line.substring(1,12))
			stop_time.make_from_string (time_line.substring(18,29))
			text := subtitle_text
		end

feature -- Status setting


	adjust_stop_time (new_stop_time: SUBRIP_SUBTITLE_TIME)
			-- Changes the stop time to the provided value
		require
			new_stop_time_not_void: new_stop_time /= Void
		do
			stop_time := new_stop_time
		ensure
			stop_time_set: stop_time.is_equal(new_stop_time)
		end

	adjust_start_time (new_start_time: SUBRIP_SUBTITLE_TIME)
			-- Changes the start time to the provided value
		require
 			new_start_time_not_void: new_start_time /= Void
		do
			start_time := new_start_time
		ensure
			start_time_set: start_time.is_equal(new_start_time)
		end

	set_text (new_text: STRING)
			-- Changes the text of the item to the provided string
		require
			new_text_not_void:new_text /= Void
		do
			text := new_text
		ensure
			text_is_set: text.is_equal (new_text)
		end

feature -- Status report

	out: STRING
			-- Returns the STRING representation of the list
		local
			res: STRING
		do
			res.make_empty

			Result := res
		end

	start_time: SUBRIP_SUBTITLE_TIME
			-- Time when the subtitle item should start to be shown

	stop_time: SUBRIP_SUBTITLE_TIME
			-- Time when the subtitle item should stop being shown

	text: STRING
			-- Text constituting this subtitle item (to be shown between initial and final times)
invariant
	valid_start_time: start_time.is_less (stop_time)
	valid_text: text /= Void
end
