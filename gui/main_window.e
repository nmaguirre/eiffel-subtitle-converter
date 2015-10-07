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
				-- Create main container.
			create main_container
				-- Create the menu bar.
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

			build_main_container
			extend (main_container)


				-- Execute `request_close_window' when the user clicks
				-- on the cross in the title bar.
			close_request_actions.extend (agent request_close_window)

				-- Set the title of the window.
			set_title (Window_title)

				-- Set the initial size of the window.
			set_size (Window_width, Window_height)
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
			a:EV_PIXMAP
		do
			create menu_item.make_with_text (Menu_file_new_item)
				--| TODO: Add the action associated with "New" here.
			file_menu.extend (menu_item)
			create a.make_with_size (10, 10)
			create a_color.make_with_8_bit_rgb (0,0,110)
			a.set_background_color (a_color)
			file_menu.set_pixmap (a)

			create menu_item.make_with_text (Menu_file_open_item)
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
			standard_toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./gui/open.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.select_actions.extend (agent on_open)
			standard_toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("./gui/save.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
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
				-- Initialize the status bar.
			standard_status_bar.set_border_width (5)

				-- Populate the status bar.
			standard_status_label.align_text_left
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

feature {NONE} -- Implementation

	main_container: EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window).

	build_main_container
			-- Populate `main_container'.
		local
			microdvd_label: EV_LABEL
			subrip_label: EV_LABEL
			pixmap: EV_PIXMAP
			enclosing_box: EV_FIXED
			font: EV_FONT
			text_field_number : EV_TEXT_FIELD
			button_forward : EV_BUTTON
			button_rewind : EV_BUTTON
			button_convert: EV_BUTTON
			background: EV_PIXMAP

		do
			create microdvd_text
			create subrip_text
			microdvd_text.disable_edit
			microdvd_text.set_minimum_height (175)
			microdvd_text.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (243, 243, 243))
			subrip_text.disable_edit
			subrip_text.set_minimum_height (175)
			subrip_text.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (243, 243, 243))

			create a_color.make_with_8_bit_rgb (0, 150,200)
			create microdvd_label.make_with_text ("MicroDVD")
			create font.default_create
			font.set_family ({EV_FONT_CONSTANTS}.family_modern)
			font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			font.set_height_in_points (12)
			microdvd_label.set_font (font)
			microdvd_label.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			microdvd_label.set_background_color (a_color)

			main_container.extend (microdvd_label)
			main_container.extend (microdvd_text)
			main_container.disable_item_expand (microdvd_label)



			create a_color.make_with_8_bit_rgb (0,150,200)
			microdvd_text.set_foreground_color (a_color)
			subrip_text.set_foreground_color (a_color)

			create background
			background.set_with_named_file ("./gui/background.png")
			background.stretch (252, 42)
			create enclosing_box
			enclosing_box.set_minimum_height (42)
			enclosing_box.set_background_pixmap (background)

				--BUTTON REWIND
			create button_rewind.make_with_text (button_rewind_item)
			button_rewind.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			button_rewind.set_minimum_width (100)
			enclosing_box.extend (button_rewind)
			enclosing_box.set_item_x_position(button_rewind,10)
			enclosing_box.set_item_y_position(button_rewind,7)

				--NUMBER TEXT FIELD
			create text_field_number
			text_field_number.set_minimum_width (50)
			enclosing_box.extend (text_field_number)
			enclosing_box.set_item_height (text_field_number, 10)
			enclosing_box.set_item_x_position(text_field_number,110)
			enclosing_box.set_item_y_position(text_field_number,8)

				--BUTTON FORWARD
			create button_forward.make_with_text (button_forward_item)
			button_forward.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			button_forward.set_minimum_width (100)
			enclosing_box.extend (button_forward)
			enclosing_box.set_item_x_position(button_forward,160)
			enclosing_box.set_item_y_position(button_forward,7)

				-- BUTTON CONVERT
			create button_convert.make_with_text (button_convert_item)
			create pixmap
			pixmap.set_with_named_file ("./gui/convert.png")
			pixmap.stretch (24, 18)
			button_convert.set_pixmap (pixmap)
			button_convert.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			button_convert.set_minimum_width (100)
			enclosing_box.extend (button_convert)
			button_convert.select_actions.extend (agent on_convert)
			enclosing_box.set_item_height (button_convert, 20)
			enclosing_box.set_item_x_position(button_convert,575)
			enclosing_box.set_item_y_position(button_convert,7)

			main_container.extend (enclosing_box)
			main_container.disable_item_expand (enclosing_box)
				--SUBRIP LABEL & TEXT BOX
			create subrip_label.make_with_text ("SubRip")
			subrip_label.set_font (font)
			subrip_label.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			subrip_label.set_background_color (a_color)
			main_container.extend (subrip_label)
			main_container.disable_item_expand (subrip_label)
			main_container.extend (subrip_text)
		ensure
			main_container_created: main_container /= Void
		end

feature --Implementation, Converter_sub

	on_open
		local
			open_dialog: EV_FILE_OPEN_DIALOG
		do
			create open_dialog
			open_dialog.show_modal_to_window (Current)
			create file_name.make_from_string (open_dialog.file_name)
		end

	on_convert
		local
			msj_error: EV_INFORMATION_DIALOG
		do
			if microdvd_text.text_length = 0 and subrip_text.text_length = 0 then
				create msj_error.make_with_text ("There is no subtitle to convert ")
				msj_error.set_title ("Error")
				msj_error.set_pixmap (default_pixmaps.error_pixmap)
				msj_error.show_modal_to_window (Current)
			end
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
		end



feature {NONE} -- Implementation / Constants

	Window_title: STRING = "eiffel_subtitle_converter"
			-- Title of the window.

	Window_width: INTEGER = 800
			-- Initial width for this window.

	--Window_height: INTEGER = 800
Window_height: INTEGER = 600
			-- Initial height for this window.

	microdvd_text: EV_TEXT

	subrip_text: EV_TEXT

	a_color: EV_COLOR

	system_logic: CONVERTER_LOGIC

	file_name : STRING

end
