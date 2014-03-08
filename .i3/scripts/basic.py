#!/usr/bin/env python

import os
#import i3
import sys
import pickle

def showHelp():
    print(sys.argv[0] + " <new_name>")

def main():
    if len(sys.argv) < 2:
        showHelp()
        sys.exit(1)

    new_name = sys.argv[1]
        
    print ("Renaming current workspace to %s" % new_name)
    sys.exit(0)
    

if __name__ == '__main__':
    main()
    
