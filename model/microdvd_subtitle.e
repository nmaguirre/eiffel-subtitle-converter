note
	description: "Class that represents a subtitle in MicroDVD format."
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"

class
	MICRODVD_SUBTITLE

create
	make

feature -- Initialisation

	make
			-- Default constructor
		do
			create repOk.make
			create items.make
			create frames_per_second

			repOk := TRUE
			frames_per_Second := 25
		end

feature -- Status setting

	change_fps (new_fps: REAL)
			-- Changes the frames per second of the subtitle.
		require
			valid_new_fps: new_fps >= 0.0
		do
			frames_per_second := new_fps
		end

	add_subtitle_item (start_frame: INTEGER; stop_frame: INTEGER; text: STRING)
			-- adds new item to the subtitle.
			-- must be added in the correct place in the list of subtitle items
		do

		end

	flush
			-- Removes all items from the subtitle
		do
			items.wipe_out

		ensure
			items.count = 0
		end

	remove_items (start_frame: INTEGER; stop_frame: INTEGER)
			-- Removes all subtitle items between start_frame and stop_frame
			require start_frame >=0 and stop_frame >=0
		do

		end

feature -- Status report

	frames_per_second: REAL
			-- Frames per second to which this subtitle corresponds

feature -- Status checking

	repOK: BOOLEAN
			-- Checks if subtitle is internally consistent.
			-- Subtitle items should be within increasingly larger
			-- frames.

feature {NONE} -- Implementation

	items: LINKED_LIST[MICRODVD_SUBTITLE_ITEM]
			-- items that conform the subtitle, in order.
end
