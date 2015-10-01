note
	description: "Summary description for {SAVE_CONVERT_SUBRIP_TO_MICRODVD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SAVE_CONVERT_SUBRIP_TO_MICRODVD

inherit
	EQA_TEST_SET

feature
	test_save_convert_subrip_to_microdvd
	local
		subrip: SUBRIP_SUBTITLE
		subrip_item: SUBRIP_SUBTITLE_ITEM
		microdvd: MICRODVD_SUBTITLE
	do
		create subrip.make
		create subrip_item.make (new_start_time, new_stop_time: SUBRIP_SUBTITLE_TIME)
		subrip.add_subtitle_item (start_time, stop_time: SUBRIP_SUBTITLE_TIME, text: STRING_8)
		assert("has been converted",)
	end


end
