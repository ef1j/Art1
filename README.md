# Art1

Art1 is a program that was written by Richard Williams in 1968. Its purpose was to give non-progammers access to an IBM System/360 Model 40 computer at the University of New Mexico in order to explore artistic and aesthetic uses of the machine. Williams, an engineer at Sandia Laboratories and later a faculty member of Electrical Engineering at UNM, collaborated with artists Charles Mattox, Frederick Hammersley, Kathernine Nash, and others in the UNM art department. This early period of computer art is described in Patrick Frank's recent book, "Sharing Code: Art1, Frederick Hammersley and the Dawn of Computer Art." [1] Art1 was disseminated to other institutions, especially through the efforts of Kathernine Nash, including to her home institution, the University of Minnesota, and the Computer Arts Society in the UK. Williams' description of Art1 appears in Jasia Reichardt's 1971 book, "The Computer in Art." [2]

Williams wrote Art1 in Fortran IV. The program provided six elementary "drawing" routines for lines, open and closed rectangles, ellipses, triangles, and exponential curves, set in a composition space of two 50 by 105 character arrays (AR1 and AR2). A seventh routine mirrors the top left quadrant of a composition to the other three quadrants. A running Art1 program received input from the user as a set of punch cards. The program's output, which included runtime information and the drawing, was printed on an IBM 1403 line printer. Because Art1 works are composed of printed characters, they are an early example of "ASCII art", albeit within a more abstract composition space.

Hammersley in particular systematically explored the Art1 program. His extensive archives [3] document a meticulous study during the period spanning late 1968 through early 1971. Hammersley's use of overprint and especially simple overlapping shapes produced many sublime pieces. In David Pagel's review of a 2013 restrospective, he writes, "Hammersley's drawings show an inventive mind having a blast as it turns simple grids of letters, numerals and punctuation marks into eccentric compositions that are a pleasure to look at -- as fresh with insight and surprising delight as the moment they were made." [4]

Using an available listing of the original Fortran code, the Art1 program can be compiled with a modern Fortran compiler. Instead of reading a stack of punch cards, the program reads a simple text file redirected to the standard input; `art1 < fort.25` in a Unix environment, for instance. The structure of the input is described in Williams' instructions, which can be found in the `docs` directory. Sample "card stacks" for generating a few of Hammersley's works are located under `cards`. Each line in the `*.25` file represents one IBM 80-column punch card. The output of Art1 is sent to the standard output with Fortran carriage control characters, +, 0, and 1, to denote carriage return, line feed, and form feed. The BSD Unix command `asa` can be used to convert this to use more common ASCII control characters.

Art1 makes use of overstriking, the ability to print characters on top of each other by issuing a carriage return without a line feed. Text output in a terminal will separate lines that would be overprinted in a printer, or only render the second line. Since most of us don't have an IBM 1403 line printer handy, the Python script `ibm1403fort.py` will process the text from Art1 and generate images. The script uses high resolution scans of glyphs from an Olivetti Te-318 teleprinter. (In the future, I hope to use scans of the the 1403's character set for a more faithful reproduction.) Four separate sets of the characters in the directory provide some variation that is typical of mechanical printing. The final images are 600dpi and would normally have been printed on 14-7/8" by 11" white tractor feed paper.

## COMMANDS / WORKFLOW

Required tools:
- A Fortran compiler. GNU Fortran works fine.
- A line printer, teleprinter, daisy wheel printer, or...
- Python 3.6 or higher and the Pillow image library

Process:
1. Compile `art1.f`.
2. Create a `fort.25` input file. See Williams' instructions and examples.
3. Run the executable with the input file: `art1 < fort.25`
4. Send to your hardcopy printer (convert Fortran carriage control characters with a command like `asa`).
5. Or, generate images of the output: `python3 ibm1408fort.py output.txt`.
6. Rock computer art like it's 1969.

Some issues:

The legacy `art1.f` program does not initialize the AR1 and AR2 arrays. This can lead to unprintable characters and misprints when the initializing card commands skip columns (on a modern computer, at least.) A modified version of the Art1 program `art21.f` includes code to initialize each array to space characters. It involves some FORTRAN variable type gymnastics.

The "exponential" code contains several bugs in the archival listing: the lines between statement 708 up to 712 are never executed. Changing `S.0320` in the original listing from `IF(AKSIG) 704, 724, 706` to `IF(AKSIG) 704, 724, 710` seems to fix the issue. [5] This correction is included in `art1.f` and `art21.f` in the main directory.

## ACKNOWLEDGMENTS

Thanks to Patrick Frank for providing a copy of Richard Williams' mimeographed instructions and to Paul Rickards for pointing out the proper use of STDIN. I gratefully acknowledge Richard Williams' family for their permission to make his code and instructions available and the Archive of American Art for their scans of Frederick Hammersley papers, including those of his original punch cards, Art1 output, and printed works.

## REFERENCES

1. Patrick Frank, Sharing Code: Art1, Frederick Hammersley, and the Dawn of Computer Art (Santa Fe, New Mexico: Museum of New Mexico Press, 2020).
2. Jasia Reichardt, The Computer in Art. (New York: Von Nostrand Reinhold Publishing, 1971).
3. Frederick Hammersley papers, circa 1860-2009, bulk 1940-2009. Archives of American Art, Smithsonian Institution.
4. David Pagel, Taking on the computer age. Los Angeles Times, February 8, 2013.
5. Marco Verpelli, personal communication.

## OTHER RESOURCES
- [Computer Drawings](http://www.hammersleyfoundation.org/index.php/artwork/computer-drawings) Courtesy of the Frederick Hammersley Foundation
- [Frederick Hammersley papers, Series 12: Artwork and Artifacts, 1934-2009](https://www.aaa.si.edu/collections/frederick-hammersley-papers-7270/series-12) The Archive of American Art's scans of Computer Drawings, Handwritten Calculations and Formulas, Computer Punch Cards, and other materials.
- [Sharing Code](http://www.mnmpress.org/?p=allBooks&id=270) by Patrick Frank, Museum of New Mexico Press
- [IBM System/360 Fortran IV Language](https://archive.org/details/bitsavers_ibm360fortVLanguage1966_8202220) Bitsavers scan of the IBM Fortran IV systems reference library volume from 1966. Also check out the [Bitsavers](http://www.bitsavers.org/pdf/ibm/1403/) IBM-1403 systems library reference and service manuals. 
 - [GNU Fortran for macOS](https://github.com/fxcoudert/gfortran-for-macOS), if that is your jam.
 - [Art1 in Javascript](https://github.com/piratefsh/art1.js) Sher Minn Chong's modern take on Art1.

[![Art1 output](samechg2.jpg)](samechg2.jpg)
