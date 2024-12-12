import os, sys

# DESC: This script removes trailing whitespaces from all .py 
#       files in the directory its placed in (WIP).
# USAGE: Place the whitespace-hunter.py into the directory you 
#        want it to work in and run python3 whitespace-hunter.py
#        in the terminal.

art = r"""
.______________________________________________________|_._._._._._._._._._.
 \_____________________________________________________|_#_#_#_#_#_#_#_#_#_|
                WHITESPACE HUNTER by Sikko             l
"""
print(art)

# Get the current working directory
script_dir = os.path.dirname(os.path.abspath(__file__))
os.chdir(script_dir)
print(f"Current working directory is: {os.getcwd()}")

files: list[str] = []

print("Gathering Python files...")

for file in os.listdir(script_dir):
    if file == "whitespace-hunter.py":
        continue

    file_path = os.path.join(script_dir, file)

    if os.path.isfile(file) and file.endswith(".py"):
        files.append(file)

if not files:
    sys.stderr.write("ERROR: NO PYTHON FILES FOUND!\n" )
    sys.exit(1)

print("Python files found. Working...")

print("Clearing whitespaces...")

for file in files:
    with open(file, "r") as f:
        lines = f.readlines()

    with open(file, "w") as f:
        for line in lines: 
            f.write(line.rstrip() + "\n")


print("Successfully removed all whitespaces in programmes!")
sys.exit(0)