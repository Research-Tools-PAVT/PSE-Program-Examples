#!/usr/bin/python

import struct
import sys
import re

def convert(m):
    return str(struct.unpack("<H", struct.pack("<e", struct.unpack("<f", struct.pack("<I", int(m.group(0))))[0]))[0])

def main(argv):
    if len(argv) != 1:
        print("Argument Error: Expecting an unsigned int representing a float in binary.")
        sys.exit(2)
    with open(argv[0], 'r+') as f:
        txt = f.read()
        txt = re.sub('\d{10}', convert, txt)
        txt = re.sub('\d{9}', convert, txt)
        txt = re.sub('w32', 'w16', txt)
        f.seek(0)
        f.write(txt)
        f.truncate()

if __name__ == "__main__":
   main(sys.argv[1:])
