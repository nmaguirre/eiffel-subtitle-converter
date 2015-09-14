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

		end

feature -- Status setting

	add_subtitle_item (start_time: SUBRIP_SUBTITLE_TIME; stop_time: SUBRIP_SUBTITLE_TIME; text: STRING)
			-- adds new item to the subtitle.
			-- must be added in the correct place in the list of subtitle items
		do
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
		do
		end

feature -- Status checking

	repOK: BOOLEAN
			-- Checks if subtitle is internally consistent.
			-- Subtitle items should be within increasingly larger
			-- time ranges.
		do
		end

feature {NONE} -- Implementation

	items: LINKED_LIST[SUBRIP_SUBTITLE_ITEM]
			-- items that conform the subtitle, in order.

end
