#!/bin/bash

# Ask the user for the name of the file or folder
read -p "Enter name (end with / for folder or provide full path for files): " name

if [[ "$name" == */ ]]; then
    # Handle folder creation
    dirname="${name%/}"
    if [ -d "$dirname" ]; then
        read -p "Directory '$dirname' already exists. Overwrite? (y/n): " overwrite
        if [[ "$overwrite" == "y" ]]; then
            rm -rf "$dirname"  # Remove the existing directory
            mkdir -p "$dirname"
            echo "Directory '$dirname' overwritten."
        else
            echo "Directory creation canceled."
        fi
    else
        mkdir -p "$dirname"
        echo "Directory '$dirname' created."
    fi
else
    # Handle file creation
    if [ -f "$name" ]; then
        read -p "File '$name' already exists. Overwrite? (y/n): " overwrite
        if [[ "$overwrite" == "y" ]]; then
            touch "$name"  # Overwrite the file
            echo "File '$name' overwritten."
        else
            echo "File creation canceled."
        fi
    else
        mkdir -p "$(dirname "$name")"  # Create parent directories if they don't exist
        touch "$name"
        echo "File '$name' created."
    fi
fi
