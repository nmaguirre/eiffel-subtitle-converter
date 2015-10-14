note
	description: "Class that represents the items that conform a subtitle in MicroDVD format."
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"

class
	MICRODVD_SUBTITLE_ITEM

inherit
	ANY
		redefine
			out
		end

create
	make, make_with_text,make_from_string

feature -- Initialisation

	make (new_start_frame: INTEGER; new_stop_frame: INTEGER)
			-- Constructs a microdvd sub. item with empty text, and provided
			-- start and stop frames
		require
			new_start_frame >= 0 and new_stop_frame > new_start_frame
		do
			start_frame:=new_start_frame
			stop_frame:=new_stop_frame
			create text.make_empty
		ensure
			start_frame=new_start_frame and
			stop_frame=new_stop_frame and
			text.is_empty=true
		end

	make_from_string(line: STRING)
			-- COnstruct a microDVD from a string rep of asubtible of an archive
			-- with the extension .sub and the form "{time_init}{time_finish}text"
		require

			line /= Void
		local
			start_frame_string: STRING
			stop_frame_string: STRING
			i: INTEGER
		do
			create start_frame_string.make_empty
			create stop_frame_string.make_empty

			from
				i := 2
			until
				line.item(i) ='}'
			loop
				start_frame_string.extend(line.item (i))
				i := i + 1

			end
			start_frame := start_frame_string.to_integer

			from
				i := i+2
			until
				line.item(i) ='}'
			loop
				stop_frame_string.extend(line.item (i))
				i := i + 1
			end

			stop_frame := stop_frame_string.to_integer
			line.remove_head(i)
			text := line
		end


	make_with_text (new_start_frame: INTEGER; new_stop_frame: INTEGER; new_text: STRING)
			-- Constructs a microdvd sub. item with provided text, start and stop frames
		require
			valid_subtitle_frames: new_start_frame >= 0 and new_start_frame < new_stop_frame
			valid_subtitle_text: new_text /= Void
		do
			start_frame := new_start_frame
			stop_frame := new_stop_frame
			text := new_text
		ensure
			start_frame = new_start_frame
			stop_frame = new_stop_frame
			text = new_text
		end

feature -- Status setting

	adjust_start_frame (new_start_frame: INTEGER)
			-- Changes the start frame to the provided value
		require
			valid_new_start_frame: new_start_frame >= 0 and new_start_frame < stop_frame
		do
			start_frame := new_start_frame
		ensure
			start_frame_set: start_frame = new_start_frame
		end

	adjust_stop_frame (new_stop_frame: INTEGER)
			-- Changes the stop frame to the provided value
		require
			valid_new_stop_frame: new_stop_frame > start_frame
		do
			stop_frame := new_stop_frame
		ensure
			stop_frame_set: stop_frame = new_stop_frame
		end

	set_text (new_text: STRING)
			-- Changes the text of the item to the provided string
		require
			new_text_not_void: new_text /= Void
		do
			text := new_text
		ensure
			text_is_set: text = new_text
		end

feature -- Status report

	out: STRING
			-- Returns the string representation of a MicroDVD item.
			-- A MicroDVD subtitle looks this way:
			--	{100}{250}Subtitle Text.
		do
			Result := "{"+start_frame.out+"}{"+stop_frame.out+"}"+text
		end

	start_frame: INTEGER
			-- Frame where the subtitle item should start to be shown

	stop_frame: INTEGER
			-- Frame where the subtitle item should stop to be shown

	text: STRING
			-- Text constituting this subtitle item (to be shown between initial and final frames)


invariant
	valid_start_frame: start_frame >= 0
	valid_stop_frame: stop_frame > start_frame

end
