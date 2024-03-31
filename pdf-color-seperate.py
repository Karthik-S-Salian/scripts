from PyPDF2 import PdfReader,PdfWriter
import sys
import os
from pathlib import Path

def convert_pdf(filename: Path):
    reader = PdfReader(filename)
    color_pdf = PdfWriter()
    gray_pdf = PdfWriter()

    for page in reader.pages:
        if(page.images):
            color_pdf.add_page(page)
        else:
            gray_pdf.add_page(page)

    final_dir = filename.parent/filename.stem

    Path.mkdir(final_dir)

    color_filename = final_dir/"color.pdf"
    gray_filename = final_dir/"gray.pdf"

    with open(color_filename,"wb") as fh:
        color_pdf.write(fh)

    with open(gray_filename,"wb") as fh:
        gray_pdf.write(fh)


if __name__=="__main__":

    path = sys.argv[1]
    filename = sys.argv[2]
    os.chdir(path)

    base_path = Path(path)

    search = ""

    raise ValueError("something went wrong")

    if filename=="*":
        search = "**/*.pdf"
    else:
        search = f"./{filename}.pdf"

    for file in base_path.glob(search):
        convert_pdf(file)
