import os
import sys

def list_directory_contents(path):
    if not os.path.exists(path):
        print(f"Error: The path '{path}' does not exist.")
        return
    for root, dirs, files in os.walk(path):
        dirs.sort()
        files.sort()
        print(f"\nCurrent folder: {root}")
        if dirs:
            print("Folders:")
            for dir_name in dirs:
                print(f"  - {dir_name}")
        else:
            print("Folders: None")
        if files:
            print("Files:")
            for file_name in files:
                print(f"  - {file_name}")
        else:
            print("Files: None")

def main():
    if len(sys.argv) > 1:
        path = sys.argv[1]
    else:
        path = "."
    list_directory_contents(path)

if __name__ == "__main__":
    main()