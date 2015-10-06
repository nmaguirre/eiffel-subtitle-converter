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
			--            1
			--            00:00:00,394 --> 00:00:03,031
			--            Hola

			--            2
			--            00:00:03,510 --> 00:00:05,154
			--            Chau
   			--		When the file is loaded into the application as subrip subtitle
    		--		And the subrip is converter to microdvd subtitle successfully
    		--		Then should save the conversion into a text fil with the extensio .sub
    		--		And should containg:
    		--			{1}{10}Hola
			--          {12}{24}Chau
		local
			file_of_subtitle: CONVERTER_LOGIC
			passed: BOOLEAN
			file_of_microdvd: PLAIN_TEXT_FILE
			line_text: STRING
		do
			--		Given a file text with the extension .srt with a valid subrip subtitle not empty, containing:
			--            1
			--            00:00:01,000 --> 00:00:02,000
			--            Hola

			--            2
			--            00:00:03,000 --> 00:00:04,000
			--            Chau
			--		When the file is loaded into the application as subrip subtitle
			create file_of_subtitle.make_with_subrip_subtitle("test_file.srt")
			--		And the subrip is converter to microdvd subtitle successfully
			file_of_subtitle.convert_subtitle
			--		Then should save the conversion into a text fil with the extensio .sub
			file_of_subtitle.save("test_file")
			create file_of_microdvd.make("test_file.sub")
			assert("the file is in the directory", file_of_microdvd /= Void)
			--		And should containg:
    		--			{24}{48}Hola
			--          {72}{96}Chau
			create file_of_microdvd.make_open_read("test_file.sub")
			file_of_microdvd.read_line
			create line_text.make_from_string(file_of_microdvd.last_string)
			passed := line_text.is_equal("{24}{48}Hola")
			file_of_microdvd.read_line
			create line_text.make_from_string(file_of_microdvd.last_string)
			assert("the file is correct", passed and line_text.is_equal("{72}{96}Chau"))
		end

end
