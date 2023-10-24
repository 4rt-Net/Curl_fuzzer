#!/bin/bash

# Change URL as needed
BASE_URL="http://example.com/"

# Change path to input file and wordlist as needed
INPUT_FILE="Wordlist.txt"

# Change output filename as needed
OUTPUT_FILE="found_directories.txt"

TOTAL_LINES=$(wc -l < "$INPUT_FILE")

CURRENT_LINE=0

[ -e "$OUTPUT_FILE" ] && rm "$OUTPUT_FILE"

while IFS= read -r directory; do
    CURRENT_LINE=$((CURRENT_LINE + 1))
    
    echo -n "$CURRENT_LINE/$TOTAL_LINES - ${BASE_URL}${directory} "

    response=$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}${directory}")

    if [ "$response" -eq 200 ]; then
        echo "Found!"
        echo "$directory" >> "$OUTPUT_FILE"
    else
        echo "Not Found"
    fi
    # Time delay added in case of network sensitivity. Change this value or comment out sleep delay depending on requirements. 
    sleep 2
done < "$INPUT_FILE"

echo "Found directories written to $OUTPUT_FILE"
