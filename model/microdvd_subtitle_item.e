note
	description: "Class that represents the items that conform a subtitle in MicroDVD format."
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"

class
	MICRODVD_SUBTITLE_ITEM

create
	make, make_with_text

feature -- Initialisation

	make (new_start_frame: INTEGER; new_stop_frame: INTEGER)
			-- Constructs a microdvd sub. item with empty text, and provided
			-- start and stop frames
		do
			start_frame:=new_start_frame
			stop_frame:=new_stop_frame
			create text.make_empty
		ensure
			start_frame=new_start_frame and
			stop_frame=new_stop_frame and
			text.is_empty=true
		end

	make_with_text (new_start_frame: INTEGER; new_stop_frame: INTEGER; new_text: STRING)
			-- Constructs a microdvd sub. item with provided text, start and stop frames
		require
			new_start_frame /= Void and
			new_stop_frame /= Void and
			new_text /= Void and
			new_start_frame >= 0 and
			new_stop_frame >= 0 and
			new_start_frame <= new_stop_frame
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
			valid_new_start_frame: new_start_frame >= 0
		do
			start_frame:=new_start_frame
		ensure
			start_frame = new_start_frame
		end

	adjust_stop_frame (new_stop_frame: INTEGER)
			-- Changes the stop frame to the provided value
		do

		ensure
			stop_frame_set: stop_frame = new_stop_frame
		end

	set_text (new_text: STRING)
			-- Changes the text of the item to the provided string
		require
			set_text_new_text:  new_text /= void
		do
			text := new_text
		ensure
			text = new_text
		end

feature -- Status report

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
