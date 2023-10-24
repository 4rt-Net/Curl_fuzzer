#!/bin/bash

#Change url as needed, remember to include trailing '/' depending on wordlist. 
BASE_URL="http://example.com/"

#Change wordlist path as needed
INPUT_FILE="Directories.txt"

#Change output filename as needed.
OUTPUT_FILE="found_directories.txt"

TOTAL_LINES=$(wc -l < "$INPUT_FILE")

CURRENT_LINE=0

[ -e "$OUTPUT_FILE" ] && rm "$OUTPUT_FILE"

while IFS= read -r directory; do
    # Increment the current line count
    CURRENT_LINE=$((CURRENT_LINE + 1))
    
    echo "$CURRENT_LINE/$TOTAL_LINES - ${BASE_URL}${directory}"
    
    response=$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}${directory}")

    if [ "$response" -eq 200 ]; then
        echo "Directory '$directory' exists on ${BASE_URL}"
        echo "$directory" >> "$OUTPUT_FILE"
    fi
    
    # Change delay as needed depending on network sensitivity
    sleep 2
done < "$INPUT_FILE"

echo "Found directories written to $OUTPUT_FILE"
