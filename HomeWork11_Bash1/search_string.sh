#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <string_to_search> <directory>"
  exit 1
fi

# Variables
search_string=$1
directory=$2

# Check if the directory exists
if [ ! -d "$directory" ]; then
  echo "Error: Directory '$directory' does not exist."
  exit 1
fi

# Function to search for the string in all files of the directory
search_in_directory() {
  local dir=$1
  for item in "$dir"/*; do
    if [ -f "$item" ]; then
      if grep -q "$search_string" "$item" 2>/dev/null; then
        file_size=$(stat --printf="%s" "$item" 2>/dev/null)
        echo "File: $(realpath "$item")"
        echo "Size: $file_size bytes"
        echo "----------------------------"
      fi
    elif [ -d "$item" ]; then
      if [ -r "$item" ]; then
        search_in_directory "$item"
      else
        echo "Access error: $(realpath "$item")"
      fi
    fi
  done
}

# Start the search
search_in_directory "$directory"
