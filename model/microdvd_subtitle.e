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

		end

feature -- Status setting

	change_fps (new_fps: REAL)
			-- Changes the frames per second of the subtitle.
		do

		end

	add_subtitle_item (start_frame: INTEGER; stop_frame: INTEGER; text: STRING)
			-- adds new item to the subtitle.
			-- must be added in the correct place in the list of subtitle items
		local
			i:INTEGER
			new_frame:MICRODVD_SUBTITLE_ITEM
			condition:BOOLEAN
		do
			create new_frame.make
			condition:=false
			new_frame.start_frame:=start_frame
			new_frame.stop_frame:=stop_frame
			new_frame.stop:=stop
			if (item.isEmpty) then
				item.appen(new_frame)
			else
				from i:=1 until (i>item.count and (not codition)) loop
				 if (new_frame.start_frame>item[i].stop_frame) then
				 	condition:=true
				 end
					i:=i+1
				end
				if (new_frame.stop_frame<item[i].start_frame) then
					item.put_i_th(new_frame, i)
				end
			end
		end

	flush
			-- Removes all items from the subtitle
		do

		end

	remove_items (start_frame: INTEGER; stop_frame: INTEGER)
			-- Removes all subtitle items between start_frame and stop_frame
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
