#!/usr/bin/python

import struct
import sys

# Converts an unsigned int representing a float in binary to an unsigned short which represents the corresponding half-precision floating point number
def main(argv):
    if len(argv) != 1:
        print("Argument Error: Expecting an unsigned int representing a float in binary.")
        sys.exit(2)
    print(struct.unpack("<H", struct.pack("<e", struct.unpack("<f", struct.pack("<I", int(argv[0])))[0]))[0])
if __name__ == "__main__":
   main(sys.argv[1:])
