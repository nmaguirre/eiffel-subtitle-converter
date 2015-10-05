note
	description: "Class that represents a subtitle in MicroDVD format."
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"

class
	MICRODVD_SUBTITLE

inherit
	SUBTITLE
		redefine
			out
		end

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
				add_constructed_subtitle_item(microdvd_item)
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
			valid_item: start_frame < stop_frame
			valid_start_frame: start_frame >= 0
			text_not_void : text /= Void
			free_time_frame(start_frame,stop_frame)
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
					items.forth
				else
					items.put_right(new_frame)
					items.forth
				end

			 end
		ensure
			start_frame_set: items.item.start_frame.is_equal(start_frame)
			stop_frame_set: items.item.stop_frame.is_equal(stop_frame)
			text_set: items.item.text.is_equal(text)
		end


    check_one (sub:MICRODVD_SUBTITLE_ITEM; item: MICRODVD_SUBTITLE_ITEM) : BOOLEAN
			-- Verifies that subtitle can be inserted.
		local
			cond: BOOLEAN
		do
			cond:= not((item.stop_frame > sub.start_frame) and (item.start_frame < sub.start_frame))
			cond:= not((item.start_frame < sub.stop_frame) and (item.stop_frame > sub.stop_frame)) and cond
			cond:= not((item.start_frame >= sub.start_frame) and (item.stop_frame <= sub.stop_frame)) and cond
			cond:= not((item.start_frame < sub.start_frame) and (item.stop_frame > sub.stop_frame)) and cond
			Result := cond
		end

	checker(sub, prev, item: MICRODVD_SUBTITLE_ITEM): BOOLEAN
			--Verifies that subtitle can be inserted between two subtitles.
		do
			Result:= (prev.start_frame <= sub.start_frame) and (sub.stop_frame <= item.stop_frame)
		end


	free_time_position(sub: MICRODVD_SUBTITLE_ITEM) : INTEGER
	        -- returns the available position. if there is not place, returns -1
	    local
	        item: MICRODVD_SUBTITLE_ITEM
	        prev: MICRODVD_SUBTITLE_ITEM
	    do
	    	if (items.count=0) then
				Result:= 0
			else
	        	from
		            items.start
		        until
		            items.off
		        loop
					prev:= items.item
					items.forth
					if (not items.off) then
						item:= items.item
						if (prev.stop_frame >= sub.start_frame ) then

							if checker(sub,prev,item) then
								Result:= items.index - 1
							else
								Result:= -1
							end
						end
					else
						if check_one(sub,prev) then

							if (sub.stop_frame <= prev.start_frame) then
								Result:= items.index
							else
								Result:= items.index - 1
							end
						else
							Result:= -1
						end
					end
		        end
			end
		 end



	add_constructed_subtitle_item(sub: MICRODVD_SUBTITLE_ITEM)
			--Adds new item microdvd_subtitle_item to the subtitle
			--must be added in the correct place in the list of subtitle items
		local
			i: INTEGER
		do
			i:= free_time_position(sub)
			if (i = 0) then
				items.extend(sub)
			else
				if (i /= -1) then
					items.go_i_th (i)
					items.put_right (sub)
				end
			end
		ensure
			valid_items_count: items.count >= old items.count
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
			microdvd: MICRODVD_SUBTITLE_ITEM
		do
			create res.default_create
			res := False
--			from
--				items.start
--			until
--				items.off or res
--			loop
--				microdvd := items.item

--				if(microdvd.stop_frame < start_frame or microdvd.start_frame > stop_frame) then
--					res := True
--				end

--				items.forth
--				if(items.item /= Void) then
--					if (items.item.start_frame <= stop_frame)then
--						res := False
--					end
--				end
--			end
--			if(items.count = 0)then
--				res := True
--			end
			if (items.count=0) then
				res:=True
			else
				from
					items.start
				until
					items.off or items.item.stop_frame<start_frame
				loop
					items.forth
				end

				if(not(items.off)) then
					items.forth
				end
				if (items.off) then
					res := True
				else
					res:=items.item.start_frame>stop_frame
				end
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

	out: STRING
			-- Returns the STRING representation of the list
		local
			res: STRING
		do
			create res.make_empty
			from
				items.start
			until
				items.off
			loop
				res.append (items.item.out+"%N")
				items.forth
			end
			Result := res
		end

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

feature {CONVERTER_LOGIC} -- Auxiliary functions 	

	convert_to_subrip : SUBRIP_SUBTITLE
			-- This routine converts a Microdvd subtitle into a Subrip subtitle
		local
			subrip_sub: SUBRIP_SUBTITLE
			start_time: SUBRIP_SUBTITLE_TIME
			stop_time: SUBRIP_SUBTITLE_TIME
		do
			create subrip_sub.make
			from
				items.start
			until
				items.off
			loop
				start_time := change_format_to_subrip(items.item.start_frame)
				stop_time := change_format_to_subrip(items.item.stop_frame)
				subrip_sub.add_subtitle_item (start_time, stop_time,items.item.text)
				items.forth
			end
			Result := subrip_sub
		end

	change_format_to_subrip (stframe: INTEGER): SUBRIP_SUBTITLE_TIME
			-- This auxiliary routine converts a  Microdvd subtitle format into aSubrip subtitle format	
		local
		seconds,hours,minutes,miliseconds_rounded: INTEGER
		frame_microdvd,miliseconds: DOUBLE
		subrip_time: SUBRIP_SUBTITLE_TIME
		do
			frame_microdvd := (stframe / frames_per_second)
			hours := frame_microdvd.truncated_to_integer // 3600
			minutes := (frame_microdvd.truncated_to_integer \\ 3600) // 60
			seconds := frame_microdvd.truncated_to_integer \\ 60
			miliseconds := (frame_microdvd - frame_microdvd.truncated_to_integer )*1000
			miliseconds_rounded := miliseconds.rounded
			create subrip_time.make_with_values (hours, minutes, seconds, miliseconds_rounded)
			Result := subrip_time

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
