Feature: Initialisation of the subtitle converter application. 

    Scenario: Initialising the subtitle converter application with no provided parameters
        When the system is started without any provided parameters
        Then the system state should be initialised with no loaded subtitles 
        And the user should be informed about the system having no loaded subtitles

    Scenario: Initialising the subtitle converter application with a valid MicroDVD subtitle
        Given a MicroDVD subtitle file with extension .sub, containing: 
            {1}{10}Hola
            {12}{24}Chau
        When the system is started with the name of the file as a parameter 
        Then the system state should be initialised loading the provided subtitle 
        And the frame rate should be the default 
        And the user should be informed that the system is ready to convert to SubRip format.

    Scenario: Initialising the subtitle converter application with a valid SubRip subtitle
        Given a SubRip subtitle file with extension .srt, containing: 
            1
            00:00:00,394 --> 00:00:03,031
            Hola
            
            2
            00:00:03,510 --> 00:00:05,154
            Chau
        When the system is started with the name of the file as a parameter 
        Then the system state should be initialised loading the provided subtitle 
        And the user should be informed that the system is ready to convert to MicroDVD format.

    Scenario: Initialising the subtitle converter application with invalid MicroDVD subtitle 
        Given a MicroDVD subtitle file with extension .sub, containing: 
            {10}{0}Hola
        When the system is started with the name of the file as a parameter 
        Then the system state should be initialised with no loaded subtitles 
        And the user should be informed that the attempted load has failed

    Scenario: Initialising the subtitle converter application with invalid SubRip subtitle 
        Given a SubRip subtitle file with extension .srt, containing: 
            1
            00:00:05,394 --> 00:00:03,031
            Hola
        When the system is started with the name of the file as a parameter 
        Then the system state should be initialised with no loaded subtitles 
        And the user should be informed that the attempted load has failed

