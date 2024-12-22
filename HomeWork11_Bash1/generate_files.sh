#!/bin/bash

# Check if the correct number of arguments is passed
if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <number_of_files>"
    exit 1
fi

directory="$1"
num_files="$2"

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Directory $directory does not exist."
    exit 1
fi

# Create files with different extensions
for i in $(seq 1 "$num_files"); do
    # Create .txt file
    echo "This is a sample text file #$i" > "$directory/file$i.txt"
    
    # Create .png file (empty placeholder, can be replaced with actual image generation if needed)
    touch "$directory/file$i.png"
    
    # Create .docx file (empty placeholder, can be replaced with actual document generation if needed)
    touch "$directory/file$i.docx"
done

echo "$num_files files created in $directory with .txt, .png, and .docx extensions."
