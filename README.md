# Art1

Art1 is a program that was written by Richard Williams in 1968. Its purpose was to give artists access to an IBM System/360 Model 40 at the University of New Mexico in order to explore artistic and aesthetic uses of the machine. Williams, an engineer at Sandia National Laboratory, collaborated with Charles Mattox, Frederick Hammersley, Kathernine Nash, and others. This early period of computer art is described in Patrick Frank's recent book, "Sharing Code: Art1, Frederick Hammersley and the Dawn of Computer Art." [1] Art1 was disseminated to other institutions, especially by the efforts of Kathernine Nash, including to the University of Minnesota, the Computer Arts Society in the UK, the Univeristy of Puerto Rico, and the University of Iowa. Williams' description of Art1 appears in Jasia Reichardt's 1971 book, "The Computer in Art." [2]

Art1 was written in Fortran IV. It provided seven elementary "drawing" routines and a composition space of two 50x105 character arrays. The Art1 program running on the IBM System/360 received input from the user by a set of punch cards. The program's output, which included runtime information, was printed on an IBM 1403 line printer. Because Art1 works are composed of printed characters, they are an early example of "ASCII art", albeit within a more abstract art space. Hammersley in particular systematically explored the Art1 program and machine. His extensive archives [3] document a meticulous study of aesthetic results during the period spanning from late 1968 through early 1971. Hammersley's use of overprint and especially simple overlapping shapes produced several sublime pieces.

Using an available listing of the original Fortran code, the Art1 program can be compiled by the modern Fortran compiler with only a few minor modifications. Instead of reading a stack of punch cards, the modified program `cart1.f` will read a Fortran unit file, `fort.25`. The structure of the input is described in Williams' mimeographed instructions, which can be found in the `docs` diretory. Sample "card stacks" for generating a few of Hammersley's works are located under `cards`. Each line in the file represents one IBM 80-column card. The output of Art1 is sent to the standard output with Fortran carriage control characters, +, 0, and 1, to denote carriage return, line feed, and form feed. The BSD Unix command `asa` can be used to convert this to use more common ASCII control characters.

Art1 makes use of overstriking, the ability to print characters on top of each other by issuing a carriage return without a line feed. Text output in a terminal will separate lines that would be overprinted in a printer, or only render the second line. Since most of us don't have an IBM 1403 line printer handy, the Python script "ibm1403fort.py" will process the text from Art1 and generate images. The script uses high resolution scans of glyphs from an Olivetti Te-318 teleprinter. (In the future, I hope to use scans of the the 1403's character set for a more faithful reproduction.) Four separate sets of the characters in the directory provide some variation that is typical of mechanical printing. The final images are 600dpi and would normally be printed on 14-7/8" by 11" white tractor feed paper.

## COMMANDS / WORKFLOW

Required tools:
- A Fortran compiler. GNU Fortran works fine.
- A line printer, teleprinter, daisy wheel printer, or...
- Python 3.X and the Pillow image library

Process:
1. Compile `cart1.f` (the modified `art1.f` program)
2. Create a `fort.25` input file. See Williams' instructions and examples.
3. Run the executable: `a.out > output.txt`
4. Send to your hardcopy printer (after converting the Fortran carriage control characters)
5. Or, generate images of the output: `python3 ibm1408fort.py output.txt`
6. Rock computer art like it's 1969

## ACKNOWLEDGMENTS

Thanks to Patrick Frank for providing a copy of Richard Williams' mimeographed instructions and the Archive of American Art for their scans of Frederick Hammersley papers, including his original punch cards, Art1 output, and printed computer work.

## REFERENCES

1. Patrick Frank, 2020. Sharing Code: Art1, Frederick Hammersley, and the Dawn of Computer Art. Museum of New Mexico Press: Santa Fe, New Mexico.
2. Jasia Reichardt, 1971. The Computer in Art. Von Nostrand Reinhold Publishing: New York.
3. Frederick Hammersley papers, circa 1860-2009, bulk 1940-2009. Archives of American Art, Smithsonian Institution.

## OTHER RESOURCES
- [Frederick Hammersley papers, Series 12: Artwork and Artifacts, 1934-2009](https://www.aaa.si.edu/collections/frederick-hammersley-papers-7270/series-12) The Archive of American Art's scans of Computer Drawings, Handwritten Calculations and Formulas, Computer Punch Cards, and other materials.
- [Computer Drawings](http://www.hammersleyfoundation.org/index.php/artwork/computer-drawings) Courtesy of the Frederick Hammersley Foundation
- [Sharing Code](http://www.mnmpress.org/?p=allBooks&id=270) by Patrick Frank, Museum of New Mexico Press
- [IBM System/360 Fortran IV Language](https://archive.org/details/bitsavers_ibm360fortVLanguage1966_8202220) Bitsavers scan of the IBM Fortran IV systems reference library volume from 1966.

[![Art1 output](samechg2.jpg)](samechg2.jpg)
