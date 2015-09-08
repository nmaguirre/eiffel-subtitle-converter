# eiffel-subtitle-converter
A Subtitle Converter developed in Eiffel using Design by Contract

Several video players support different subtitle formats. Two of these are MicroDVD and SubRip. In the former, subtitles are composed of a list of tuples (fi,ff,t), where fi is the initial frame, ff is the end frame, and t is the text to be shown in those frames. The SubRip format, on the other hand, represents subtitles as a list of tuples (no,ti,tf,t), where no is the sequential number of the subtitle element, ti is the initial time (in milliseconds), tf is the end time (in milliseconds), and t is the text to be shown during that time. 

The SubRip format is usually the preferred format, since it does not depend on the frame rate of the video to which the subtitles are being attached to. However, not all video players support all formats, and then it is useful to be able to convert from either of the two just described, to the other one. 

This subtitle converter will enable one to handle SubRip and MicroDVD subtitle files, and in particular convert these files from one format to the other. It will also support features for subtitle edition, including:
- changing the frame rate associated with a MicroDVD subtitle
- split subtitle files in several parts (e.g., for using with videos that have also been splitted for storage)
- "Move" subtitles forward or backward, i.e., given an offset (positive or negative), adjust the subtitles to accomodate to it. 

This project will be developed using Eiffel, with EiffelStudio as platform, using Design by Contract.
