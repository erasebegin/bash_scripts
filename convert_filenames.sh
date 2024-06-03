#!/bin/bash

# Directory to loop through
dir_path="."

# Prompt the user to choose a case
echo "Please choose a case:"
echo "1) kebab-case"
echo "2) PascalCase"
echo "3) snake_case"
read -p "Enter your choice (1-3): " choice

# Loop through each file in the directory
for old_file in "$dir_path"/*
do
    # If this is not a file, skip to the next iteration
    if [ ! -f "$old_file" ]; then
        continue
    fi

    # Get the base name of the file
    file_name=$(basename "$old_file")

    # Remove leading and trailing spaces, and replace multiple spaces with a single space
    file_name=$(echo "$file_name" | sed -e 's/^ *//' -e 's/ *$//' -e 's/  */ /g')

    # Convert the file name based on the user's choice
    case $choice in
        1)  # kebab-case
            new_file_name=$(echo "$file_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
            # Condense consecutive hyphens into a single hyphen
            new_file_name=$(echo "$new_file_name" | tr -s '-')
            ;;
        2)  # PascalCase
            new_file_name=$(echo "$file_name" | tr '[:lower:]' '[:upper:]' | tr ' ' '')
            ;;
        3)  # snake_case
            new_file_name=$(echo "$file_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
            # Condense consecutive underscores into a single underscore
            new_file_name=$(echo "$new_file_name" | tr -s '_')
            ;;
        *)  # Invalid choice
            echo "Invalid choice. Please run the script again."
            exit 1
    esac

    # Construct the new file path
    new_file_path="${dir_path}/${new_file_name}"

    # Rename the file
    mv "$old_file" "$new_file_path"
done
