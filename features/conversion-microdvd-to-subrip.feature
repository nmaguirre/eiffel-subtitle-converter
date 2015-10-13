Feature: Subtitle conversion, from MicroDVD format to SubRip format. 

    Scenario: Converting a subtitle from MicroDVD to SubRip, with default framerate, and all subtitle items
              within the first minute of reproduction.
        Given that the system has been loaded with the MicroDVD subtitle
            {0}{50}Hola
            {100}{150}Chau
        When the user selects the convert subtitle option
        Then the obtained subtitle is in SubRip format, and contains the following
            1
            00:00:00,000 --> 00:00:02,085
            Hola

            2
            00:00:04,171 --> 00:00:06,257
            Chau

    Scenario: Converting a subtitle from MicroDVD to SubRip, with a custom framerate, and all subtitle items
              within the first minute of reproduction.
        Given that the system has been loaded with the MicroDVD subtitle and the user selects a framerate equals to 25
            {0}{50}Hola
            {100}{150}Chau
        When the user selects the convert subtitle option
        Then the obtained subtitle is in SubRip format, and contains the following
            1
            00:00:00,000 --> 00:00:02,000
            Hola

            2
            00:00:04,000 --> 00:00:06,000
            Chau