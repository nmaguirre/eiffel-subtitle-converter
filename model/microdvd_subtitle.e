note
	description: "Class that represents a subtitle in MicroDVD format."
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"

class
	MICRODVD_SUBTITLE

inherit
	SUBTITLE

create
	make,make_from_file

feature -- Initialisation


	make
			-- Default constructor
		do
			create items.make
			frames_per_second := 23.97
		ensure
			valid_items_count: items.count = 0
		end

	make_from_file(name_file: STRING)
			-- Create a microDVD from a file
		require
			valid_string: name_file.count > 4
		local
			current_line : STRING
			microdvd_file : PLAIN_TEXT_FILE
			microdvd_item : MICRODVD_SUBTITLE_ITEM
		do
			create microdvd_file.make_open_read(name_file)
			frames_per_second := 23.97
			create items.make
			from
				microdvd_file.read_line
			until
				microdvd_file.end_of_file
			loop
				create current_line.make_from_string(microdvd_file.last_string)
				create microdvd_item.make_from_string(current_line)
				items.extend(microdvd_item)
				microdvd_file.read_line
			end

		end

feature -- Status setting

	change_fps (new_fps: REAL)
			-- Changes the frames per second of the subtitle.
		require
			valid_new_fps: new_fps > min_valid_fps
		do
			frames_per_second := new_fps
		ensure
			fps_set: frames_per_second = new_fps
		end

	add_subtitle_item (start_frame: INTEGER; stop_frame: INTEGER; text: STRING)
			-- adds new item to the subtitle.
			-- must be added in the correct place in the list of subtitle items
		require
			valid_item: start_frame >= 0 and start_frame < stop_frame
			text_not_void : text /= Void
		local
			new_frame: MICRODVD_SUBTITLE_ITEM
		do
			create new_frame.make_with_text(start_frame, stop_frame, text)
			if (items.count = 0) then
				items.extend(new_frame)
			else
				from
					items.start
				until
					new_frame.start_frame > items.item.stop_frame
				loop
					items.forth
				end
				if items.islast then
					items.extend(new_frame)
				else
					items.put_right(new_frame)
				end

			 end
		ensure
			start_frame_set: items.item.start_frame.is_equal(start_frame)
			stop_frame_set: items.item.stop_frame.is_equal(stop_frame)
			text_set: items.item.text.is_equal(text)
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
			start_frame_valid: start_frame >= 0
			start_frame_valid: start_frame < stop_frame
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


	free_time_frame(start_frame: INTEGER; stop_frame: INTEGER): BOOLEAN
		require
			valid_start_frame: start_frame>=0 and start_frame<stop_frame
			valid_stop_frame: stop_frame>0 and start_frame<stop_frame
		local
			res: BOOLEAN
			item_microdvd: MICRODVD_SUBTITLE_ITEM
		do
			create res.default_create
			res := True
			from
				items.start
			until
				items.islast
			loop
				item_microdvd := items.item
				if(item_microdvd.start_frame >= start_frame and item_microdvd.stop_frame <= stop_frame)then
					res := False
				end
				items.forth
			end
			Result := res
		end

feature -- Status report

	nr_of_items: INTEGER
		do
			Result := items.count
		end

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
			prev_stop_frame := -1
			from
				items.start
			until
				items.off or not res
			loop
				if  items.item /= Void and prev_stop_frame < items.item.start_frame then
					prev_stop_frame := items.item.stop_frame
					items.forth
				else
					res := False
				end
			end
			Result := res
		ensure
			repOk_check: Result /= void
		end

feature {MICRODVD_SUBTITLE_TEST} -- Implementation

	items: LINKED_LIST[MICRODVD_SUBTITLE_ITEM]
			-- items that conform the subtitle, in order.


feature  --Constant

	min_valid_fps: INTEGER = 12
			--Minimum valid fps. FPS less than 12 is insufficient for a stream of frames to be perceived as a continous image.


invariant
	valid_items: items /= Void

end
