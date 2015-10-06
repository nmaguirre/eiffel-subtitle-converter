note
	description: "Summary description for {SAVE_CONVERT_SUBRIP_TO_MICRODVD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERT_SAVE_SUBRIP_TO_MICRODVD_FEATURE

inherit
	EQA_TEST_SET

feature --test routines

	test_save_convert_subrip_to_microdvd
			--	Scenario: save the conversion of subrip to microdvd subtitle in a file with the extension .sub
			--		Given a file text with the extension .srt with a valid subrip subtitle not empty, containing:
			--			{1}{10}Hola
			--          {12}{24}Chau
   			--		When the file is loaded into the application as subrip subtitle
    		--		And the subrip is converter to microdvd subtitle successfully
    		--		Then should save the conversion into a text fil with the extensio .sub
		local
			subrip_subtitle: SUBRIP_SUBTITLE
			file_of_subrip_subtitle: CONVERTER_LOGIC
		do
			--		Given a file text with the extension .srt with a valid subrip subtitle not empty, containing:
			--			{1}{10}Hola
			--          {12}{24}Chau
			--		When the file is loaded into the application as subrip subtitle
			create file_of_subrip_subtitle.make_with_subrip_subtitle("test_file.srt")
			--		And the subrip is converter to microdvd subtitle successfully
			file_of_subrip_subtitle.convert_subtitle
			--		Then should save the conversion into a text fil with the extensio .sub
			assert("has been converted and saved", save_convert_subrip_to_microdvd)
			assert("the file is in the directory", existing_file("test_file.sub"))
		end

end
