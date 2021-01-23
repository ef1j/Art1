# Art1

Art1 is a program that was written by Richard Williams in 1968. It's purpose was to enable artists to use an IBM System 360/40 at the University of New Mexico to explore artistic and aesthetic uses of the machine. Williams collaborated with Frederick Hammersley, Kathernine Nash, and others. This early period of computer art is described and discussed in Patrick Frank's recent book, "Sharing Code: Art1, Frederick Hammersley and the Dawn of Computer Art" (Museum of New Mexico Press, Santa Fe, NM, 2020). Art1 was disseminated to other institutions, mainly through the efforts of Kathernine Nash, including to the University of Minnesota, the Computer Arts Society in the UK, the Univeristy of Puerto Rico, and the University of Iowa.

Art1 was written in Fortran IV. It provides seven elementary routines. A running Art1 program received input by a set of punch cards. The output and runtime information of the program was then printed on an IBM 1403 line printer. Art1 output is therefore printed characters -- an early example of "ASCII art".

Using an available listing of the original Fortran code, the program can be compiled by the modern Fortran compiler with minor modifications. Instead of reading a stack of punch cards, the program will read the "fort.25" file. The structure of this file is described in Williams mimeographed instructions, which can be found in the docs diretory. Sample "card stacks" for generating a few of Hammersley's works are located in "cards." The output of Art1 is sent to the standard output with Fortran carriage control characters, +, 0, and 1, to denote carriage return, line feed, and form feed. The BSD Unix command "asa" can be used to convert this to use more familiar line printer control characters.

Art1 makes use of overstriking, the ability to print characters on top of each other by issuing a carriage return without a line feed. Since most of us don't have an IBM 1403 line printer handy, the Python script "ibm1403fort.py" will process the text from art1 and generate images. The script uses scans of glyphs from an Olivetti Te-318 teleprinter. (In the future, I hope to use the 1403's character set for a more faithful reproduction.) Four sets of the characters provide some variation that is typical of a mechanical print. The final image is 600dpi.

COMMANDS / WORKFLOW
Required tools:
- A Fortran compiler. GNU Fortran works fine.
- Python 3.X
- Python's Pillow image libraries installed

1. Compile cart1.f (the modified art1.f program)
2. a.out > output.txt
3. python3 ibm1408fort.py output.txt

THANKS AND ACKNOWLEDGMENTS
Patrick Frank for providing a copy of Richard William's mimeographed instructions and the Archive of American Art for their scans of Frederick Hammersley papers, including his original punch cards, Art1 output, and printed computer work.

REFERENCES
Patrick Frank, 2020. Sharing Code: Art1, Frederick Hammersley, and the Dawn of Computer Art. New Mexico Museum of Art Press, Santa Fe, New Mexico.
Jasia Reichardt, 1971. The Computer in Art. Von Nostrand Reinhold Publishing, New York.
