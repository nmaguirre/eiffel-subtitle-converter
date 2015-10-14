Feature: Save a convert file from Subrip to microdvd.

	Scenario: save the conversion of subrip to microdvd subtitle in a file with the extension .sub
	
	GIVEN	 A file text with the extension .srt with a valid subrip subtitle not empty
	WHEN	 The file is loaded into the application as subrip subtitle
	AND 	 The subrip is converter to microdvd subtitle successfully
	THEN 	 should save the conversion into a text fil with the extensio .sub
