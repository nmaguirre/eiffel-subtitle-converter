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
			-- create repOk.make
			create items.make
			create frames_per_second

			-- repOk := TRUE
			frames_per_Second := 25
		ensure
			items.count = 0
		end

feature -- Status setting

	change_fps (new_fps: REAL)
			-- Changes the frames per second of the subtitle.
		require
			valid_new_fps: new_fps >= 0.0
		do
			frames_per_second := new_fps
		ensure
			frames_per_second = new_fps
		end

	add_subtitle_item (start_frame: INTEGER; stop_frame: INTEGER; text: STRING)
			-- adds new item to the subtitle.
			-- must be added in the correct place in the list of subtitle items
		local
			i:INTEGER
			new_frame:MICRODVD_SUBTITLE_ITEM
			condition:BOOLEAN
		do
			create new_frame.make_with_text(start_frame, stop_frame, text)
			condition:=false
			if (items.count = 0) then
				items.put(new_frame)
			else
				from
					i:=1
				until
					(i>items.count and (not condition))
				loop
					if (new_frame.start_frame>items[i].stop_frame) then
				 		condition:=true
				 	end
						i:=i+1
				end
				if (new_frame.stop_frame<items[i].start_frame) then
					items.put_i_th(new_frame, i)
				end
			 end
		ensure
			items.item.start_frame = start_frame
			items.item.stop_frame = stop_frame
			items.item.text = text
		end

	flush
			-- Removes all items from the subtitle
		require
			-- valid_item = item.count /= 0
		do
			items.wipe_out

		ensure
			items.count = 0
		end

	remove_items (start_frame: INTEGER; stop_frame: INTEGER)
			-- Removes all subtitle items between start_frame and stop_frame
			-- require valid_items = item.count /= 0
		do
			from
				items.start
			until
				items.after or stop_frame <= items.item.stop_frame
			loop
				if (start_frame <= items.item.start_frame) and (items.item.stop_frame <= stop_frame) then
					items.remove
				else
					items.forth
				end
			end
			ensure items.count <= old items.count
		end

feature -- Status report

	frames_per_second: REAL
			-- Frames per second to which this subtitle corresponds

feature -- Status checking

	repOK: BOOLEAN
			-- Checks if subtitle is internally consistent.
			-- Subtitle items should be within increasingly larger
			-- frames.
		local
			res: BOOLEAN
			prev_stop_frame: INTEGER
		do
			res := true
			from
				items.start
			until
				items.off
			loop
				if not items.isfirst then
					if prev_stop_frame > items.item.start_frame then
						res := false
					end
				end
				prev_stop_frame := items.item.stop_frame
				items.forth
			end
			Result := res
		end

feature {NONE} -- Implementation

	items: LINKED_LIST[MICRODVD_SUBTITLE_ITEM]
			-- items that conform the subtitle, in order.
end
