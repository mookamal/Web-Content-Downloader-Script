#!/bin/bash

# Check if the required argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <links_file>"
    exit 1
fi

links_file="$1"

# Check if the links file exists
if [ ! -f "$links_file" ]; then
    echo "Error: Links file '$links_file' not found."
    exit 1
fi

# Function to download content from a given link and save to a file
download_and_save() {
    local link="$1"
    local output_file="$2"

    # Use curl to make an HTTP GET request and save the content to the output file
    curl -s "$link" >> "$output_file"

    if [ $? -eq 0 ]; then
        echo "Downloaded content from $link."
    else
        echo "Failed to download content from $link."
    fi
}

# Create an empty output file or clear existing content
output_file="downloaded_content.txt"
> "$output_file"

# Read links from the file and download content for each link
while IFS= read -r link || [ -n "$link" ]; do
    download_and_save "$link" "$output_file"
done < "$links_file"

echo "All content downloaded and saved to $output_file."
