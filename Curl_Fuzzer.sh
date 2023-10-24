#!/bin/bash

BASE_URL="http://example.com/" #Change URL as needed, remember to include trailing '/'

OUTPUT_FILE="found_directories.txt" #Change output filename as needed. 

[ -e "$OUTPUT_FILE" ] && rm "$OUTPUT_FILE"

while IFS= read -r directory; do
    response=$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}${directory}")

    if [ "$response" -eq 200 ]; then
        echo "Directory '$directory' exists on ${BASE_URL}"
        echo "$directory" >> "$OUTPUT_FILE"
    fi
    sleep 2 #Delay between requests set to 2 seconds by default. 
done < path_to_directories_wordlist #Change path to wordlist file as needed.

echo "Found directories written to $OUTPUT_FILE"
