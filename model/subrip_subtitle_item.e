note
	description: "Class that represents the items that conform a subtitle in SubRip format."
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"

class
	SUBRIP_SUBTITLE_ITEM

create
	make, make_with_text

feature -- Initialisation

	make (new_start_time: SUBRIP_SUBTITLE_TIME; new_stop_time: SUBRIP_SUBTITLE_TIME)
			-- Constructs a subrip sub. item with empty text, and provided
			-- start and stop times
		do
		end

	make_with_text (new_start_time: SUBRIP_SUBTITLE_TIME; new_stop_time: SUBRIP_SUBTITLE_TIME; new_text: STRING)
			-- Constructs a subrip sub. item with provided text, start and stop times
		do
		end

feature -- Status setting

	adjust_start_time (new_start_time: SUBRIP_SUBTITLE_TIME)
			-- Changes the start time to the provided value
		do
		end

	adjust_stop_time (new_stop_time: SUBRIP_SUBTITLE_TIME)
			-- Changes the stop time to the provided value
		do
		end

	set_text (new_text: STRING)
			-- Changes the text of the item to the provided string
		do
		end

feature -- Status report

	start_time: SUBRIP_SUBTITLE_TIME
			-- Time when the subtitle item should start to be shown

	stop_time: SUBRIP_SUBTITLE_TIME
			-- Time when the subtitle item should stop being shown

	text: STRING
			-- Text constituting this subtitle item (to be shown between initial and final times)
end
