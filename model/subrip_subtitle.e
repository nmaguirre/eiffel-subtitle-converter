note
	description: "Class that represents a subtitle in sSubRip format."
	author: "DOSE 2015, Rio Cuarto Team"
	date: "September 2015"
	revision: "0.1"

class
	SUBRIP_SUBTITLE

create
	make

feature -- Initialisation

	make
			-- Default constructor
		do
			create items.make

		ensure
			empty_list:	items.is_empty
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
			items.item.start_time = start_time
			items.item.stop_time = stop_time
			items.item.text = text
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

	repOK: BOOLEAN
			-- Checks if subtitle is internally consistent.
			-- Subtitle items should be within increasingly larger
			-- time ranges.
		require
			True
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
		ensure
			repOk_check: Result /= Void
		end

feature {NONE} -- Implementation

	items: LINKED_LIST[SUBRIP_SUBTITLE_ITEM]
			-- items that conform the subtitle, in order.

end
