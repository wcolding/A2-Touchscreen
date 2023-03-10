import sys
import os

full_dir = os.getcwd()
working_index = full_dir.rfind("\\") + 1
dir = full_dir[working_index:]

is_pyTOSC_folder = dir == "pyTOSC"

if (is_pyTOSC_folder):
    print("Program must be run from containing project directory. Run 'python init.py' first!")
    exit()

from pyTOSC.unpack import Unpack
from pyTOSC.pack import Pack
from configparser import ConfigParser

config = ConfigParser()
config.read("config.ini")

UNPACK_FILE = config["pyTOSC"]["UnpackTarget"]
BUILD_FILE  = config["pyTOSC"]["BuildXML"]

help_string = """Usage: 'python pyTOSC.py [argument]'    
Arguments:
    -u, --unpack      unpack .tosc file
    -b, --build       build .tosc file(s)
    -c, --clean       clean build directory
    -l, --clean-lua   clean lua directory
    Anything else     show these arguments
"""

def Clean():
    print("Clean selected")
    build_files = os.listdir("Build")
    for file in build_files:
        if file != ".gitignore":
            os.remove(f'Build\\{file}')
    print("Build directory cleaned!")

def CleanLua():
    print("Clean Lua selected")
    lua_files = os.listdir("Lua")
    for file in lua_files:
        if file != "Submodules":
            os.remove(f'Lua\\{file}')
        else:
            sub_files = os.listdir("Lua\\Submodules")
            for sub in sub_files:
                os.remove(f'Lua\\Submodules\\{sub}')
    print("Lua directory cleaned!")

def Help():
    print(help_string)

if (len(sys.argv) < 2):
    print("Expected argument\n")
    Help()
    exit()
else:
    match sys.argv[1]:
        case "-u":
            Unpack(UNPACK_FILE)
        case "--unpack":
            Unpack(UNPACK_FILE)
        case "-b":
            Pack(BUILD_FILE)
        case "--build":
            Pack(BUILD_FILE)
        case "-c":
            Clean()
        case "--clean":
            Clean()
        case "-l":
            CleanLua()
        case "--clean-lua":
            CleanLua()
        case _:
            Help()

