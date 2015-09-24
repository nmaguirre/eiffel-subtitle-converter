note
	description: "Summary description for {CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONTROLLER

create
	make_with_no_subtitle, make_with_microdvd_subtitle

feature

	make_with_no_subtitle
			-- Initialises the controller and logic
			-- with no loaded subtitle
		do
			create system_logic.make
		end

	make_with_microdvd_subtitle (filename: STRING)
		do

		end

feature

	system_logic: CONVERTER_LOGIC

end
