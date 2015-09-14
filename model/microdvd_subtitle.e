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
			create items.make
			frames_per_Second := 23.97
		ensure
			valid_items_count: items.count = 0
		end

feature -- Status setting

	change_fps (new_fps: REAL)
			-- Changes the frames per second of the subtitle.
		require
			valid_new_fps: new_fps > 12
		do
			frames_per_second := new_fps
		ensure
			fps_set: frames_per_second = new_fps
		end

	add_subtitle_item (start_frame: INTEGER; stop_frame: INTEGER; text: STRING)
			-- adds new item to the subtitle.
			-- must be added in the correct place in the list of subtitle items
		local
			i: INTEGER
			new_frame: MICRODVD_SUBTITLE_ITEM
			condition: BOOLEAN
		do
			create new_frame.make_with_text(start_frame, stop_frame, text)
			condition := false
			if (items.count = 0) then
				items.extend(new_frame)
			else
				from
					i := 1
				until
					(i>items.count) or (not condition)
				loop
					if (new_frame.start_frame > items[i].stop_frame) then
				 		condition := true
				 	end
						i := i+1
				end
				if (new_frame.stop_frame<items[i].start_frame) then
					items.put_i_th(new_frame, i)
				end
			 end
		ensure
			valid_start_frame: items.item.start_frame = start_frame
			valid_stop_frame: items.item.stop_frame = stop_frame
			valid_text: items.item.text = text
		end

	flush
			-- Removes all items from the subtitle
		do
			items.wipe_out

		ensure
			valid_items_count: items.count = 0
		end

	remove_items (start_frame: INTEGER; stop_frame: INTEGER)
			-- Removes all subtitle items between start_frame and stop_frame
		require
			start_frame: start_frame >= 0 and start_frame >= stop_frame
		do
			from
				items.start
			until
				items.after or stop_frame > items.item.stop_frame
			loop
				if (start_frame <= items.item.start_frame) and (items.item.stop_frame <= stop_frame) then
					items.remove
				else
					items.forth
				end
			end
		ensure
			valid_items_count: items.count <= old items.count
		end

feature -- Status report

	frames_per_second: REAL
			-- Frames per second to which this subtitle corresponds

feature -- Status checking

	repOK: BOOLEAN
			-- Checks if subtitle is internally consistent.
			-- Subtitle items should be within increasingly larger
			-- frames and distinc to Void.
		local
			res: BOOLEAN
			prev_stop_frame: INTEGER
		do
			res := True
			from
				items.start
			until
				items.off or res = False
			loop
				if not items.isfirst then
					if  items.item = Void or prev_stop_frame > items.item.start_frame then
						res := False
					end
				end
				prev_stop_frame := items.item.stop_frame
				items.forth
			end
			Result := res
		end

feature {MICRODVD_SUBTITLE_TEST} -- Implementation

	items: LINKED_LIST[MICRODVD_SUBTITLE_ITEM]
			-- items that conform the subtitle, in order.

invariant
	valid_items: items /= Void
end
