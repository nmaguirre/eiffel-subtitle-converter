Feature: Subtitle conversion, from SubRip format to MicroDVD format. 

    Scenario: Converting a subtitle from SubRip to MicroDVD, with default framerate, and all subtitle items
              within the first minute of reproduction.
        Given that the system has been loaded with the SubRip subtitle
            1
            00:00:00,000 --> 00:00:02,085
            Hola

            2
            00:00:04,171 --> 00:00:06,257
            Chau
        When the user selects the convert subtitle option
        Then the obtained subtitle is in MicroDVD format, and contains the following
            {0}{50}Hola
            {100}{150}Chau


