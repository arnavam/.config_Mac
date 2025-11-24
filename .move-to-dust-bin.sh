#!/bin/bash

# Check if .dust_bin exists, if not create it
if [ ! -d "$HOME/.dust_bin" ]; then
    mkdir "$HOME/.dust_bin"
fi

# Move the file or directory to .dust_bin
for file in "$@"; do
    # Check if the source file/directory exists
    if [ ! -e "$file" ]; then
        echo "Error: $file does not exist."
        continue
    fi

    # Set the target file path
    target="$HOME/.dust_bin/$(basename "$file")"

    # Check if the target file exists and append numbers if necessary
    counter=1
    while [ -e "$target" ]; do
        target="$HOME/.dust_bin/$(basename "$file")_$counter"
        ((counter++))
    done

    # Move the file to the new target
    mv "$file" "$target"
    echo "$file has been moved to $target."
done
