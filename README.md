# Art1

Art1 is a program that was written by Richard Williams in 1968. Its purpose was to give artists access to an IBM System/360 Model 40 at the University of New Mexico in order to explore artistic and aesthetic uses of the machine. Williams, an engineer at Sandia National Laboratory, collaborated with Charles Mattox, Frederick Hammersley, Kathernine Nash, and others. This early period of computer art is described in Patrick Frank's recent book, "Sharing Code: Art1, Frederick Hammersley and the Dawn of Computer Art" (1). Art1 was disseminated to other institutions, especially by the efforts of Kathernine Nash, including to the University of Minnesota, the Computer Arts Society in the UK, the Univeristy of Puerto Rico, and the University of Iowa. Williams' description of Art1 appears in Jasia Reichardt's 1971 book, "The Computer in Art." (2)

Art1 was written in Fortran IV. It provided seven elementary "drawing" routines and a composition space of two 50x105 character arrays. A running Art1 program on a the IBM System/360 received its input by a set of punch cards. The output and runtime information of the program was then printed on an IBM 1403 line printer. Because Art1 works are composed of printed characters, they are an early example of "ASCII art", albeit within a more abstract space. Hammersley in particular systematically explored the Art1 program and machine. His extensive archives document a meticulous study of aesthetic results. Hammersley's use of overprint and especially simple overlapping shapes produce fascinating pieces.

Using an available listing of the original Fortran code, the Art1 program can be compiled by the modern Fortran compiler with only a few minor modifications. Instead of reading a stack of punch cards, the modified program (`cart1.f`) will read a unit file, `fort.25`. The structure of the input is described in Williams mimeographed instructions, which can be found in the `docs` diretory. Sample "card stacks" for generating a few of Hammersley's works are located under `cards`. Each line in the file represents one IBM 80-column card. The output of Art1 is sent to the standard output with Fortran carriage control characters, +, 0, and 1, to denote carriage return, line feed, and form feed. The BSD Unix command `asa` can be used to convert this to use more common ASCII control characters.

Art1 makes use of overstriking, the ability to print characters on top of each other by issuing a carriage return without a line feed. Text output in a terminal will separate lines that would be overprinted in a printer, or only render the second line. Since most of us don't have an IBM 1403 line printer handy, the Python script "ibm1403fort.py" will process the text from art1 and generate images. The script uses scans of glyphs from an Olivetti Te-318 teleprinter. (In the future, I hope to use high resolution scans of the the 1403's character set for a more faithful reproduction.) Four sets of the characters provide some variation that is typical of a mechanical print. The final images are 600dpi and would normally be printed on 14-7/8" by 11" white tractor feed paper.

## COMMANDS / WORKFLOW

Required tools:
- A Fortran compiler. GNU Fortran works fine.
- Python 3.X
- Python's Pillow image libraries 

Process:
1. Compile `cart1.f` (the modified `art1.f` program)
2. Create a `fort.25` input file. See William's instructions and examples.
3. Run the executable: `a.out > output.txt`
4. Generate images of the output: `python3 ibm1408fort.py output.txt`
5. Rock computer art like it's 1969

## ACKNOWLEDGMENTS

Thanks to Patrick Frank for providing a copy of Richard William's mimeographed instructions and the Archive of American Art for their scans of Frederick Hammersley papers, including his original punch cards, Art1 output, and printed computer work.

## REFERENCES

1. Patrick Frank, 2020. Sharing Code: Art1, Frederick Hammersley, and the Dawn of Computer Art. Museum of New Mexico Press: Santa Fe, New Mexico.
2. Jasia Reichardt, 1971. The Computer in Art. Von Nostrand Reinhold Publishing: New York.

### OTHER RESOURCES
- [Frederick Hammersley papers, Series 12: Artwork and Artifacts, 1934-2009](https://www.aaa.si.edu/collections/frederick-hammersley-papers-7270/series-12) Includes Computer Drawings, Handwritten Calculations and Formulas, circa 1973, Computer Punch Cards, circa 1970, and other archived materials.
- [Frederick Hammersley Foundation](http://www.hammersleyfoundation.org/index.php/artwork/computer-drawings) Computer Drawings
- [Sharing Code](http://www.mnmpress.org/?p=allBooks&id=270) by Patrick Frank, Museum of New Mexico Press
- [IBM System/360 Fortran IV Language](https://archive.org/details/bitsavers_ibm360fortVLanguage1966_8202220) Bitsavers IBM Fortran IV systems reference library from 1966.

[![Art1 output](samechg2.jpg)](samechg2.jpg)
