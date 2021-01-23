"""
ibm1403fort.py
Input a text ascii image and generate the simulated printout using character images.
This version will make an image size to reproduce IBM 1403 output and will respond
to form feed characters and Fortran carriage control characters
Based on earlier programs "makeimage2.py" and "ibm1403.py".
 
e.m.f. January 2021

1/5/2021   Implemented image blending for overstrike of single characters
1/11/2021  Added notes on page size; save images as 1200dpi
1/17/2021  Rewritten to use an object class "PrintPage", enable printing title at bottom
1/22/2021  Removed code to print at bottom of page
           introduced pagewidth and pageheight, able to print multiple pages
1/23/2021  Interpret fortran carriage control characters 0, 1, +
"""


from PIL import Image, ImageEnhance, ImageChops
Image.MAX_IMAGE_PIXELS = 110486672 # my image size exceeds the DOS warning
import sys, math

"""
A PrintPage is an image object that represents hardcopy paper at 1200dpi.
The cursor position is stored by column and row. 
Methods of the class include adding ("printing") a character image to the page.
"""
class PrintPage:
    # IBM1403 paper is 14-7/8" wide and 11" high
    pagerows = 66
    pagecols = 150
    pagewidth = pagecols*120 # each char image is 120x200
    pageheight = pagerows*200
    
    def __init__(self,number):
        # page number
        self.number = number
        # make blank image page (10chars/in, 6 rows/in)
        mode, size, color = 'L', (self.pagewidth, self.pageheight), 255
        self.img = Image.new(mode, size, color)

        # start at top left corner of page
        self.column = 0
        self.row = 0

        # offset to center a 4x3 image
        self.voffset = 2
        self.hoffset = 7

    def printchar(self,char):
        # I have 4 versions of the character set for some variation, so files are nnNN
        # nn = 0-3, NN = ASCII value
        charfile = "chars/" + "{0:02n}".format(self.row % 3) + "{0:02n}".format(char) + ".jpg"
        try:
            with Image.open(charfile) as charimg:
                width, height = charimg.size
                imgx = (self.column+self.hoffset)*width
                imgy = (self.row+self.voffset)*height
                tempimg = self.img.crop((imgx,imgy,imgx+width,imgy+height))
                tempimg = ImageChops.darker(tempimg, charimg)
                self.img.paste(tempimg,(imgx,imgy,imgx+width,imgy+height))
                self.column += 1
        except OSError:
            print("Error opening character file", charfile)

            
"""
 Main program
"""
if __name__ == '__main__':
    """ 
    The text file for an ASCII image is typically 132 columns wide and 66 rows long
    the paper is 14 7/8" wide and 11" long. So the initial indent should be 8 chars
    """
    
    # I'm expecting the text file as the first agument
    # open the file as a binary to capture the CR's
    if len(sys.argv) == 2:
        filename = sys.argv[1]
        try:
            with open(filename, mode='rb') as textfile:
                # initialize the page
                numpage = 1
                page = PrintPage(numpage)
                output = []
                
                # process each line of the text file
                # Rewrite to use the FORTRAN carriage control characters
                for line in textfile:
                    # process each character in line
                    for byte in line:
                        if byte == 32: # space character
                            page.column += 1 # advance carriage, do not strike!
                        elif byte == 10 or (page.column == 0 and byte == 48): # new line (0)
                            page.row += 1
                            page.column = 0
                            if page.row == page.pagerows - page.voffset:
                                output.append(page)
                                numpage += 1 # add a page
                                page = PrintPage(numpage)
                        elif byte == 13: # carriage return - overstrike
                            page.column = 0
                        elif page.column == 0 and byte == 43: # fortran carriage return - overstrike (+)
                            page.row -= 1 # the + means to remove the previous LF and insert CR, so back up
                            page.column = 1 
                        elif byte == 12 or (page.column == 0 and byte == 49): # form feed (1)
                            output.append(page)
                            numpage += 1
                            page = PrintPage(numpage)
                            page.column = 0
                            page.row = 0
                        else:
                            # draw each character on the page
                            char = int(byte)
                            page.printchar(char)

                # flush the last page to the output
                if numpage > 0:
                    output.append(page)

                for page in output:
                    print("Printing page ", page.number, " of ", numpage)
                    page.img = page.img.resize((page.pagewidth//2,page.pageheight//2))
                    page.img.save(filename.split('.')[0] + str(page.number) + ".jpg", "JPEG", dpi=(600,600))

                textfile.close()
                
        except OSError:
            print("Error opening", filename)
    else:
        print("\nusage: makeimage.py filename [title]\n")
