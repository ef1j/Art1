# art1

Art1 was written by Richard Williams in 1968. It's purpose was to enable artists to use the IBM System 360/40 at the University of New Mexico to explore artistic and aesthetic uses of the machine. Williams collaborated with Frederick Hammersley, Kathernine Nash, and others. This early period of computer art is described and discussed in Patrick Frank's recent book, "Sharing Code: Art1, Frederick Hammersley and the Dawn of Computer Art" (Museum of New Mexico Press, Santa Fe, NM, 2020).

Art1 was written in Fortran IV. It received input via a set of programmed punch cards. The output and runtime information of the program was printed on an IBM 1403 line printer.

Using an available listing of the original Fortran code, the program can be compiled by the GNU Fortran compiler with minior modifications. Instead of reading a stack of punch cards, the program will read the "fort.25" file. The structure of this file is described by Williams mimeographed instructions, which can be found in the docs diretory. Sample "card stacks" for generating a few of Hammersley's works are located in "cards." The output of art1 is sent to the standard output with Fortran carriage control characters. The BSD unix command "asa" can be used to convert this to line printer control formats using line feed, carriage return, and form feed characters.

Art1 makes use of overstriking, the ability to print characters on top of each other by issuing a carriage return without a line feed. Since most won't have an IBM 1403 line printer handy, the Python script "ibm1403fort.py" will process the text from art1 and generate images. The script uses scans of glyphs from an Olivetti Te-318 teleprinter. (In the future, I hope to use the 1403's character set for a more faithful reproduction.)

COMMANDS / WORKFLOW HERE

HAMMERSLEY RESOURCES AT ARCHIVE OF AMERICAN ART

THANKS AND ACNOWLEDGMENTS
