note
	description: "Main window for this application"
	author: "Generated by the New Vision2 Application Wizard."
	date: "$Date: 2015/9/8 18:38:1 $"
	revision: "1.0.0"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize,
			is_in_default_state
		end

	INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	ABSTRACT_OBSERVER
		undefine
			default_create, copy
		redefine
			on_update
		end

create
	default_create

feature -- Initialisation

	set_logic(new_logic: CONVERTER_LOGIC)
		do
			system_logic := new_logic
		end

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			create enclosing_box
				-- Create enclosig_box
			create standard_menu_bar
				-- Create file menu.
			create file_menu.make_with_text (Menu_file_item)
				-- Create help menu.
			create help_menu.make_with_text (Menu_help_item)
				-- Create a toolbar.
			create standard_toolbar
				-- Create a status bar and a status label.
			create standard_status_bar
			create standard_status_label.make_with_text ("Add your status text here...")
		end

	initialize
			-- Build the interface for this window.
		do
			Precursor {EV_TITLED_WINDOW}

				-- Create and add the menu bar.
			build_standard_menu_bar
			set_menu_bar (standard_menu_bar)

				-- Create and add the toolbar.
			build_standard_toolbar
			upper_bar.extend (create {EV_HORIZONTAL_SEPARATOR})
			upper_bar.extend (standard_toolbar)

				-- Create and add the status bar.
			build_standard_status_bar
			lower_bar.extend (standard_status_bar)

			build_main_enclosing_box
			extend (enclosing_box)

				-- Execute `request_close_window' when the user clicks
				-- on the cross in the title bar.
			close_request_actions.extend (agent request_close_window)

				-- Set the title of the window.
			set_title (Window_title)

				-- Set the initial size of the window.
			set_size (Window_width, Window_height)

			Current.disable_user_resize
		end

	is_in_default_state: BOOLEAN
			-- Is the window in its default state?
			-- (as stated in `initialize')
		do
			Result := (width = Window_width) and then
				(height = Window_height) and then
				(title.is_equal (Window_title))
		end


feature {NONE} -- Menu Implementation

	standard_menu_bar: EV_MENU_BAR
			-- Standard menu bar for this window.

	file_menu: EV_MENU
			-- "File" menu for this window (contains New, Open, Close, Exit...)

	help_menu: EV_MENU
			-- "Help" menu for this window (contains About...)

	build_standard_menu_bar
			-- Create and populate `standard_menu_bar'.
		do
				-- Add the "File" menu.
			build_file_menu
			standard_menu_bar.extend (file_menu)
				-- Add the "Help" menu.
			build_help_menu
			standard_menu_bar.extend (help_menu)
		ensure
			menu_bar_initialized: not standard_menu_bar.is_empty
		end

	build_file_menu
			-- Create and populate `file_menu'.
		local
			menu_item: EV_MENU_ITEM
		do
			create menu_item.make_with_text (Menu_file_new_item)
				--| TODO: Add the action associated with "New" here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_open_item)
			menu_item.select_actions.extend (agent request_about_open.show_modal_to_window(Current)) --controller for click in new
				--| TODO: Add the action associated with "Open" here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_save_item)
				--| TODO: Add the action associated with "Save" here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_saveas_item)

				--| TODO: Add the action associated with "Save As..." here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_close_item)
				--| TODO: Add the action associated with "Close" here.
			file_menu.extend (menu_item)

			file_menu.extend (create {EV_MENU_SEPARATOR})

				-- Create the File/Exit menu item and make it call
				-- `request_close_window' when it is selected.
			create menu_item.make_with_text (Menu_file_exit_item)
			menu_item.select_actions.extend (agent request_close_window)
			file_menu.extend (menu_item)
		ensure
			file_menu_initialized: not file_menu.is_empty
		end

	build_help_menu
			-- Create and populate `help_menu'.
		local
			menu_item: EV_MENU_ITEM

		do
			create menu_item.make_with_text (Menu_help_contents_item)
				--| TODO: Add the action associated with "Contents and Index" here.
			help_menu.extend (menu_item)


			create menu_item.make_with_text (Menu_help_about_item)
			menu_item.select_actions.extend (agent on_about)
			help_menu.extend (menu_item)

		ensure
			help_menu_initialized: not help_menu.is_empty
		end


feature {NONE} -- ToolBar Implementation

	standard_toolbar: EV_TOOL_BAR
			-- Standard toolbar for this window.

	build_standard_toolbar
			-- Populate the standard toolbar.
		local
			toolbar_item: EV_TOOL_BAR_BUTTON
			toolbar_pixmap: EV_PIXMAP
		do
				-- Initialize the toolbar.
			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./gui/new.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			create a_color.make_with_8_bit_rgb (0,150,0)
			standard_toolbar.set_background_color (a_color)
			standard_toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./gui/open.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.select_actions.extend (agent request_about_open.show_modal_to_window(Current))
			standard_toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./gui/save.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./gui/clear.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.select_actions.extend (agent clear)
			standard_toolbar.extend (toolbar_item)

		ensure
			toolbar_initialized: not standard_toolbar.is_empty
		end

feature {NONE} -- StatusBar Implementation

	standard_status_bar: EV_STATUS_BAR
			-- Standard status bar for this window

	standard_status_label: EV_LABEL
			-- Label situated in the standard status bar.
			--
			-- Note: Call `standard_status_label.set_text (...)' to change the text
			--       displayed in the status bar.

	build_standard_status_bar
			-- Populate the standard toolbar.
		do
			create a_color.make_with_8_bit_rgb (0,0,10)
				-- Initialize the status bar.
			standard_status_bar.set_border_width (1)
			standard_status_bar.set_background_color (a_color)

				-- Populate the status bar.
			create a_color.make_with_8_bit_rgb (0,150,0)
			standard_status_label.align_text_left
			standard_status_label.set_background_color (a_color)
			standard_status_bar.extend (standard_status_label)
		end

feature {NONE} -- About Dialog Implementation

	on_about
			-- Display the About dialog.
		local
			about_dialog: ABOUT_DIALOG
		do
			create about_dialog
			about_dialog.show_modal_to_window (Current)
		end

feature {NONE} -- Implementation, Close event

	request_close_window
			-- Process user request to close the window.
		local
			question_dialog: EV_CONFIRMATION_DIALOG
		do
			create question_dialog.make_with_text (Label_confirm_close_window)
			question_dialog.show_modal_to_window (Current)

			if question_dialog.selected_button ~ (create {EV_DIALOG_CONSTANTS}).ev_ok then
					-- Destroy the window.
				destroy

					-- End the application.
					--| TODO: Remove next instruction if you don't want the application
					--|       to end when the first window is closed..
				if attached (create {EV_ENVIRONMENT}).application as a then
					a.destroy
				end
			end
		end

	request_about_open: EV_FILE_OPEN_DIALOG
		do
			create Result
			Result.open_actions.extend (agent open_path(Result))
		end

	open_path(file: EV_FILE_OPEN_DIALOG)
		local
			error: EV_INFORMATION_DIALOG

		do
			create file_name.make_from_string (file.file_title)

			if(file.full_file_path.out.substring (file.full_file_path.out.count-3, file.full_file_path.out.count).is_equal (".srt"))then
					--file_name:=file.file_title
					--file_path:= file.full_file_path.out
					read_file (file.full_file_path, "srt")
					subrip_text.disable_edit
			else
				if(file.full_file_path.out.substring (file.full_file_path.out.count-3, file.full_file_path.out.count).is_equal (".sub"))then
					--file_name:= file.file_title
					--file_path:= file.full_file_path.out
					read_file (file.full_file_path, "sub")
					microdvd_text.disable_edit
				else
					create error.make_with_text ("The file is not correct")
					error.show
				end
			end
		end

	read_file (a_path: PATH; sub_type: STRING)
            -- Show how to read a file into a string
            -- For binary files you can use {RAW_FILE}.
        local
            file_open: FILE
            content_file: STRING
        do
            create path.make_empty
            create {PLAIN_TEXT_FILE} file_open.make_with_path (a_path)
            if file_open.exists and then file_open.is_readable and sub_type.is_equal("srt") then
                file_open.open_read
                file_open.read_stream (file_open.count)
                content_file := file_open.last_string
                subrip_text.set_text (content_file)
                path:= a_path.out
                file_open.close
            else
            	if file_open.exists and then file_open.is_readable and sub_type.is_equal("sub") then
            		file_open.open_read
                	file_open.read_stream (file_open.count)
                	content_file := file_open.last_string
                	microdvd_text.set_text (content_file)
                	path:= a_path.out
                	file_open.close
            	else
                	io.error.put_string ("Could not read, the file:[" + a_path.name + " ] does not exist")
                	io.put_new_line
                end
            end
        end


	feature {NONE} -- Implementation

	enclosing_box: EV_FIXED

	build_main_enclosing_box
			-- Populate `enclosing_box'.
		local
			microdvd_label: EV_LABEL
			subrip_label: EV_LABEL
			pixmap: EV_PIXMAP
			button_converter_subrip: EV_BUTTON
			button_converter_microdvd: EV_BUTTON
			font: EV_FONT
  		    text_field_fw : EV_TEXT_FIELD
			text_field_rw : EV_TEXT_FIELD
			button_forward : EV_BUTTON
			button_rewind : EV_BUTTON

		do
				-- ENCLOSING
			create pixmap.default_create
			pixmap.set_with_named_file ("./gui/enclosing.png")
			enclosing_box.set_background_pixmap (pixmap)

				-- MICRODVD_LABEL AND MICRODVD_TEXT
			create microdvd_text
			create a_color.make_with_8_bit_rgb (0,150,0)
			create microdvd_label.make_with_text ("MicroDVD")
			microdvd_text.set_foreground_color (a_color)
			create font.default_create
			font.set_family (1)
			font.set_height_in_points (25)
			microdvd_label.set_font (font)
			microdvd_label.set_background_color (a_color)
			microdvd_text.disable_edit
			microdvd_label.set_minimum_height (35)
			microdvd_label.set_minimum_width (250)
			microdvd_text.set_minimum_height (400)
			microdvd_text.set_minimum_width (250)

				-- ENCLOSING MICRODVD_LABEL AND MICRODVD_TEXT
			enclosing_box.extend (microdvd_label)
			enclosing_box.extend (microdvd_text)
			enclosing_box.set_item_x_position (microdvd_label,50)
			enclosing_box.set_item_y_position (microdvd_label,70)
			enclosing_box.set_item_x_position (microdvd_text,50)
			enclosing_box.set_item_y_position (microdvd_text,100)

				-- SUBRIP_LABEL AND SUBRIP_TEXT
			create subrip_text
			create subrip_label.make_with_text ("Subrip")
			subrip_text.set_foreground_color (a_color)
			subrip_label.set_font (font)
			subrip_label.set_background_color (a_color)
			subrip_text.disable_edit
			subrip_label.set_minimum_height (35)
			subrip_label.set_minimum_width (250)
			subrip_text.set_minimum_height (400)
			subrip_text.set_minimum_width (250)

				-- ENCLOSING SUBRIP_LABEL AND SUBRIP_TEXT
			enclosing_box.extend (subrip_label)
			enclosing_box.extend (subrip_text)
			enclosing_box.set_item_x_position (subrip_label,400)
			enclosing_box.set_item_y_position (subrip_label,68)
			enclosing_box.set_item_x_position (subrip_text,400)
			enclosing_box.set_item_y_position (subrip_text,100)

				-- PIXMAP RIGHT
			pixmap.set_with_named_file ("./gui/right.png")
			create button_converter_subrip.default_create
			button_converter_subrip.set_pixmap (pixmap)
			enclosing_box.extend (button_converter_subrip)
			enclosing_box.set_item_x_position(button_converter_subrip,315)
			enclosing_box.set_item_y_position(button_converter_subrip,200)
			button_converter_subrip.select_actions.extend (agent converter_sub)

				-- PIXMAP LEFT
			pixmap.set_with_named_file ("./gui/left.png")
			create button_converter_microdvd.default_create
			button_converter_microdvd.set_pixmap (pixmap)
			enclosing_box.extend (button_converter_microdvd)
			enclosing_box.set_item_x_position(button_converter_microdvd,315)
			enclosing_box.set_item_y_position(button_converter_microdvd,350)
			button_converter_microdvd.select_actions.extend (agent converter_sub)

				--BUTTON REWING
			pixmap.set_with_named_file ("./gui/rewind.png")
			create button_rewind.default_create
			button_rewind.set_pixmap (pixmap)

			button_rewind.select_actions.extend (agent rewind_subtitle_main_window(text_field_rw))

			button_rewind.select_actions.extend (agent rewind_subtitle_main_window)
			enclosing_box.extend (button_rewind)
			enclosing_box.set_item_x_position(button_rewind,115)
			enclosing_box.set_item_y_position(button_rewind,520)


				-- TEXTFIELD REWIND
			create text_field_rw
			text_field_rw.set_capacity (12)
			enclosing_box.extend (text_field_rw)
			--rewind_subtitle:= text_field_number.selected_text
			enclosing_box.set_item_x_position(text_field_rw,160)
			enclosing_box.set_item_y_position(text_field_rw,539)
=======
				-- TEXTFIELD
			create text_field_number
			text_field_number.set_capacity (12)
			enclosing_box.extend (text_field_number)
			--rewind_subtitle:= text_field_number.selected_text
			enclosing_box.set_item_x_position(text_field_number,160)
			enclosing_box.set_item_y_position(text_field_number,539)


				--BUTTON FOWARD
			pixmap.set_with_named_file ("./gui/forward.png")
			create button_forward.default_create
			button_forward.set_pixmap (pixmap)

			button_forward.select_actions.extend (agent forward_subtitle_main_window(text_field_fw))
			button_forward.select_actions.extend (agent forward_subtitle_main_window)
			enclosing_box.extend (button_forward)
			enclosing_box.set_item_x_position(button_forward,480)
			enclosing_box.set_item_y_position(button_forward,520)

				--NUMBER TEXT FIELD

			create text_field_fw
			--forward_subtitle:= text_field_number.selected_text
			text_field_fw.set_capacity (12)
			--text_field_number.set_minimum_width_in_characters (12)
			enclosing_box.extend (text_field_fw)
			enclosing_box.set_item_x_position(text_field_fw,525)
			enclosing_box.set_item_y_position(text_field_fw,539)
=======
			create text_field_number
			--forward_subtitle:= text_field_number.selected_text
			text_field_number.set_capacity (12)
			text_field_number.set_minimum_width_in_characters (12)
			enclosing_box.extend (text_field_number)
			enclosing_box.set_item_x_position(text_field_number,525)
			enclosing_box.set_item_y_position(text_field_number,539)
>>>>>>> ebc25b9214212037eff018b505add4e4927bb843

		ensure
			main_enclosing_created: enclosing_box /= Void
		end


	feature --Implementation, Converter_sub

	converter_sub
		local
			msj_error: EV_INFORMATION_DIALOG
			msg_box: EV_INFORMATION_DIALOG
		do
			if microdvd_text.text_length = 0 and subrip_text.text_length = 0 then
				create msj_error.make_with_text ("There is no subtitle to convert ")
				msj_error.set_title ("Error")
				msj_error.set_pixmap (default_pixmaps.error_pixmap)
				msj_error.show_modal_to_window (Current)
			end
			if (microdvd_text.text_length /= 0) and (subrip_text.text_length = 0) then
				create controller.make_with_microdvd_subtitle (path, Current)
				set_logic (controller.system_logic)
				controller.convert_sub
				create msg_box.make_with_text ("Conversion exitosa.")
				msg_box.set_title ("Mensaje")
				msg_box.show_modal_to_window (Current)
			end
			if (subrip_text.text_length /= 0) and (microdvd_text.text_length = 0)then
				create controller.make_with_subrip_subtitle (path, Current)
				set_logic (controller.system_logic)
				controller.convert_sub
				create msg_box.make_with_text ("Conversion exitosa.")
				msg_box.set_title ("Mensaje")
				msg_box.show_modal_to_window (Current)
			end

		end

	clear
		local
			do
				if (subrip_text.text_length /= 0 and microdvd_text.text_length /= 0) then
					microdvd_text.remove_text
					subrip_text.remove_text
					controller.flush_items
				end

			end

	forward_subtitle_main_window (text_field_fw: EV_TEXT_FIELD)
			do
				controller.forward_subtitle_controller (text_field_fw.text)
			end

	rewind_subtitle_main_window (text_field_rw: EV_TEXT_FIELD)
			do
				controller.rewind_subtitle_controller (text_field_rw.text)
			end


		end

	clear
		local
			do
				if (subrip_text.text_length /= 0 and microdvd_text.text_length /= 0) then
					microdvd_text.remove_text
					subrip_text.remove_text
					controller.flush_items
				end

			end

	forward_subtitle_main_window

			do

				-- text_field_number.is_sensitive
			--	controller.forward_subtitle_controller (current.selected_text)
			end

	rewind_subtitle_main_window
		local
		--	i:INTEGER
		do

			controller.rewind_subtitle_controller (text_field_number.selected_text)
		end



feature -- Observer features

	on_update
		do
			if system_logic.has_loaded_microdvd_subtitle then
				microdvd_text.remove_text
				microdvd_text.append_text (system_logic.source_as_microdvd.out)
				if attached {SUBRIP_SUBTITLE} system_logic.target as subrip_sub then
					subrip_text.remove_text
					subrip_text.append_text (subrip_sub.out)
				end
			end
			if system_logic.has_loaded_subrip_subtitle then
				subrip_text.remove_text
				subrip_text.append_text (system_logic.source_as_subrip.out)
				if attached {MICRODVD_SUBTITLE} system_logic.target as microdvd_sub then
					microdvd_text.remove_text
					microdvd_text.append_text (microdvd_sub.out)
				end
			end
		end



feature {NONE} -- Implementation / Constants

	Window_title: STRING = "Subtitle Converter"
			-- Title of the window.

	Window_width: INTEGER = 800
			-- Initial width for this window.

	Window_height: INTEGER = 700
			-- Initial height for this window.

	microdvd_text: EV_TEXT

	subrip_text: EV_TEXT

	a_color: EV_COLOR

	system_logic: CONVERTER_LOGIC

	path: STRING

	controller: CONTROLLER
<<<<<<< HEAD

	file_name: STRING
=======
>>>>>>> ebc25b9214212037eff018b505add4e4927bb843

	file_name: STRING

	text_field_number : EV_TEXT_FIELD
end
