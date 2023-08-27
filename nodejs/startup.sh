#!/bin/bash

# Check if URL is provided as argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <URL>"
    exit 1
fi

# Define the URL provided as argument
url="$1"

# Generate a random file name for the downloaded script
temp_script=$(mktemp)

# Download the script from the provided URL
echo "Downloading script from $url..."
wget -q "$url" -O "$temp_script"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Download successful. Executing the script..."
    chmod +x "$temp_script"  # Make the downloaded script executable
    "$temp_script"           # Execute the script

    # Check if the script execution was successful
    if [ $? -eq 0 ]; then
        echo "Script executed successfully. Deleting the downloaded script..."
        rm "$temp_script"
    else
        echo "Script execution failed."
        rm "$temp_script"
        exit 1
    fi
else
    echo "Download failed."
    exit 1
fi

echo "Server startup process completed."
