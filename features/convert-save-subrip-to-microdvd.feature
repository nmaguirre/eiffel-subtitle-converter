Feature: Save a convert file from Subrip to microdvd.

	Scenario: after to convert the subtitle subrip to microdvd formate, i want to save the microdvd in a persistent file text.
	
	GIVEN	 a valid subrip subtitle
	WHEN	 i convert that subtitle to microdvd
	AND 	 the conversiion was succes
	THEN 	 i want to might save to a persisten text file 
