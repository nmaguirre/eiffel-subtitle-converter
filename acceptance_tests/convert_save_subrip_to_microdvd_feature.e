note
	description: "Summary description for {SAVE_CONVERT_SUBRIP_TO_MICRODVD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERT_SAVE_SUBRIP_TO_MICRODVD_FEATURE

inherit
	EQA_TEST_SET

feature
	test_save_convert_subrip_to_microdvd
	local
		subrip: SUBRIP_SUBTITLE
		subrip_item: SUBRIP_SUBTITLE_ITEM
		microdvd: MICRODVD_SUBTITLE
		start_time,stop_time: SUBRIP_SUBTITLE_TIME
		file: FILE
	do
		create subrip.make
		create microdvd.make
		--create file.make
		create start_time.make_with_values (0, 0, 1, 0)
		create stop_time.make_with_values (0, 0, 2, 0)
		subrip.add_subtitle_item (start_time,stop_time,"hola")
		microdvd := subrip.convert_to_microdvd

		assert("has been converted", true = true)
	end

end
