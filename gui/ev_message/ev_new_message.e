note
	description: "Summary description for {EV_NEW_MESSAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_NEW_MESSAGE
	
inherit
	EV_MESSAGE_DIALOG
		redefine
			initialize
		end

create
	default_create,
	make_with_text,
	make_with_text_and_actions

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_MESSAGE_DIALOG}
			set_pixmap (Default_pixmaps.Question_pixmap)
			set_icon_pixmap (Default_pixmaps.Question_pixmap)
			set_title (ev_confirmation_dialog_title)
			set_buttons (<<"MICRODVD", "SUBRIP">>)
			set_default_push_button (button ("MICRODVD"))
			set_default_cancel_button (button ("SUBRIP"))
		end



end
