note
	description: "Class that represents a subtitle in sSubRip format."
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"

class
	SUBRIP_SUBTITLE

inherit
	SUBTITLE
		redefine
			out
		end

create
	make, make_from_file

feature -- Initialisation

	make
			-- Default constructor
		do
			create items.make

		ensure
			empty_list:	items.is_empty
		end

	make_from_file (filename: STRING)
			-- Initialize a subrip_subtitle from a file
		local
			file: PLAIN_TEXT_FILE
			time_line: STRING
			text_line: STRING
			item: SUBRIP_SUBTITLE_ITEM
			read_mode: INTEGER
		do
			create file.make_open_read (filename)
			create items.make
			create time_line.make_empty
			create text_line.make_empty
			read_mode := 0	-- srt files start with a number
			from
				file.start
			until
				file.end_of_file
			loop
				file.read_line -- next line
				inspect read_mode
				when 0 then
					read_mode := 1 -- next line is a timecode
				when 1 then
					time_line.append (file.last_string)
					read_mode := 2 -- next line is a text_line
				when 2 then
					if file.last_string.is_equal ("") then
						create item.make_from_string (time_line, text_line)
						items.extend (item)
						time_line.wipe_out	-- remove all characters from time_line
						text_line.wipe_out	-- remove all characters from subtitle_text
						read_mode := 0		-- next line is a number
					end
					text_line.append (file.last_string)
				end

			end
		end

feature -- Status setting

	add_subtitle_item (start_time: SUBRIP_SUBTITLE_TIME; stop_time: SUBRIP_SUBTITLE_TIME; text: STRING)
			-- adds new item to the subtitle.
			-- must be added in the correct place in the list of subtitle items
		require
			valid_time: start_time.time_milliseconds < stop_time.time_milliseconds
			text_not_void: text /= Void
		local
			subtitle:SUBRIP_SUBTITLE_ITEM
			condition:BOOLEAN
		do
			create subtitle.make_with_text(start_time, stop_time, text)
			condition := false
			if (items.is_empty) then
				items.extend(subtitle)
			else
				from
					items.start
				until
					condition or items.off
				loop
					if (start_time.time_milliseconds > items.item.stop_time.time_milliseconds) then
						if(items.index < items.count)then
							if (stop_time.time_milliseconds<items[items.index+1].start_time.time_milliseconds) then
								condition := true
								items.put_right(subtitle)
							end
						else
							condition := true
							items.extend(subtitle)
						end
					end
					items.forth
				end
			end
		ensure
			items.item.start_time.is_equal(start_time)
			items.item.stop_time.is_equal(stop_time)
			items.item.text.is_equal(text)
		end

	flush
			-- Removes all items from the subtitle
		do
			items.wipe_out
		ensure
			valid_items_count: items.count = 0
		end

	remove_items (start_time: SUBRIP_SUBTITLE_TIME; stop_time: SUBRIP_SUBTITLE_TIME)
			-- Removes all subtitle items between start_time and stop_time

		require
			valid_time_not_void: start_time /= Void and stop_time /= Void
			valid_time: start_time < stop_time

		local
			cond1: BOOLEAN
			cond2: BOOLEAN
		do
			from
				items.start
			until
				items.after or items.item.stop_time < stop_time
			loop
				cond1:= start_time < items.item.start_time or start_time.is_equal(items.item.start_time)
				cond2:= items.item.stop_time < stop_time or items.item.stop_time.is_equal(stop_time)
				if cond1 and cond2 then
					items.remove
				else
					items.forth
				end
			end
		ensure
			valid_items_count: items.count <= old items.count
		end

feature -- Status checking

	nr_of_items: INTEGER
			-- Number of items in the subtitle
		do
			Result:=items.count
		end

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
				res.append (items.index.out+"%N"+items.item.out+"%N")
				items.forth
			end
			Result := res
		end

	repOK: BOOLEAN
			-- Checks if subtitle is internally consistent.
			-- Subtitle items should be within increasingly larger
			-- time ranges.
		local
			res: BOOLEAN
			prev_stop_time: SUBRIP_SUBTITLE_TIME
 		do
			res := True
			from
				items.start
			until
				items.off or not res
			loop
				if items.item = Void then
					res := False
				else
					if not items.isfirst then
						if prev_stop_time > items.item.start_time then
							res := False
						end
					end
				end
				prev_stop_time := items.item.stop_time
				items.forth
			end
			Result := res
		end

feature {CONVERTER_LOGIC} -- Auxiliary functions 		

	convert_to_microdvd : MICRODVD_SUBTITLE
			-- This routine converts a Subrrip subtitle into a Microdvd subtitle
		local
			microdvd_sub: MICRODVD_SUBTITLE
			start_frame: INTEGER
			stop_frame: INTEGER
		do
			from
				items.start
			until
				items.off
			loop
				create microdvd_sub.make
				start_frame := change_format_to_microdvd(items.item.start_time, microdvd_sub.frames_per_second)
				stop_frame := change_format_to_microdvd(items.item.stop_time,microdvd_sub.frames_per_second)
				microdvd_sub.add_subtitle_item (start_frame, stop_frame, items.item.text)
				items.forth
			end
			Result := microdvd_sub
		end

	change_format_to_microdvd (st_time: SUBRIP_SUBTITLE_TIME ; fps: REAL): INTEGER
				-- This auxiliary routine converts a Subrip subtitle format into a Microdvd subtitle format
		local
			st_frame: INTEGER
			time_subrip: DOUBLE
		do
			time_subrip := st_time.hours * 3600 + st_time.minutes * 60 + st_time.seconds + st_time.milliseconds / 1000
			st_frame:= (time_subrip * fps).rounded
			Result:= st_frame

		end


feature {SUBRIP_SUBTITLE_TESTS} -- Implementation

	items: LINKED_LIST[SUBRIP_SUBTITLE_ITEM]
			-- items that conform the subtitle, in order.

end
