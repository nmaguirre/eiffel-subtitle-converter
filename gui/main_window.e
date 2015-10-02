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
--feature {NONE} -- Button Implementation

	--button_converter: EV_BUTTON



	--build_button_converter
	--local
	--	enclosing_box: EV_FIXED
	--do
	--	lock_update
	--	create enclosing_box
	--	extend (enclosing_box)
	--	button_converter.set_minimum_width(105)
	--	enclosing_box.extend(button_converter)
	--	enclosing_box.set_item_x_position(button_converter, 225)
	--	enclosing_box.set_item_y_position(button_converter, 256)
	--	button_converter.select_actions.extend (agent converter_sub)
--	end



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
			create a_color.make_with_8_bit_rgb (200,0,0)
			standard_status_label.set_foreground_color (a_color)
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
			create a_color.make_with_8_bit_rgb (200,0,100)
			question_dialog.set_background_color (a_color)
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
			button_converter: EV_BUTTON
			enclosing_box: EV_FIXED
		do
			create microdvd_text.make_with_text ("{1}{10}Hola")
			create subrip_text
			create pixmap.default_create
			pixmap.set_with_named_file ("./gui/new.png")
			microdvd_text.disable_edit
			subrip_text.disable_edit

			create a_color.make_with_8_bit_rgb (0, 150,0)
			create microdvd_label.make_with_text ("MicroDVD")
			microdvd_label.set_background_color (a_color)

			main_container.extend (microdvd_label)
			main_container.extend (microdvd_text)

			create subrip_label.make_with_text ("Subrip")
			subrip_label.set_background_color (a_color)

			main_container.extend (subrip_label)
			main_container.extend (subrip_text)

			create a_color.make_with_8_bit_rgb (0,150,0)
			microdvd_text.set_foreground_color (a_color)
			subrip_text.set_foreground_color (a_color)
			main_container.set_border_width (34)

			-- BUTTON CONVERTER
			create enclosing_box

			create button_converter.make_with_text (button_converter_item)
			button_converter.set_minimum_width (200)
			enclosing_box.extend (button_converter)
			button_converter.select_actions.extend (agent converter_sub)
			enclosing_box.set_item_x_position(button_converter,10)
			enclosing_box.set_item_y_position(button_converter,20)
			main_container.extend (enclosing_box)

			create a_color.make_with_8_bit_rgb (200,0,100)
			main_container.set_background_color (a_color)


		ensure
			main_container_created: main_container /= Void
		end

feature --Implementation, Converter_sub

	converter_sub
		local
			msj_error: EV_INFORMATION_DIALOG
		do
			if microdvd_text.text_length = 0 and subrip_text.text_length = 0 then
				create msj_error.make_with_text ("There is no subtitle to convert ")
				msj_error.set_title ("Error")
				msj_error.set_pixmap (default_pixmaps.error_pixmap)
				msj_error.show_modal_to_window (Current)
			else
				system_logic.convert_subtitle
				on_update
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

	Window_height: INTEGER = 800
			-- Initial height for this window.

	microdvd_text: EV_TEXT

	subrip_text: EV_TEXT

	a_color: EV_COLOR

	system_logic: CONVERTER_LOGIC

end
