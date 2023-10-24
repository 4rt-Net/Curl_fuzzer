#!/bin/bash

# URL to check directories against
BASE_URL="http://example.com/"

# Output file to store the found directories
OUTPUT_FILE="found_directories.txt"

# Remove the output file if it already exists
[ -e "$OUTPUT_FILE" ] && rm "$OUTPUT_FILE"

# Read each line from Directories.txt and check if the directory exists
while IFS= read -r directory; do
    # Use curl to check if the directory exists (HTTP status code 200 indicates success)
    response=$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}${directory}")

    # If the directory exists, output it and write to the output file
    if [ "$response" -eq 200 ]; then
        echo "Directory '$directory' exists on ${BASE_URL}"
        echo "$directory" >> "$OUTPUT_FILE"
    fi
    
    # Add a 2-second delay before the next request
    sleep 2
done < path_to_directories_wordlist

echo "Found directories written to $OUTPUT_FILE"
