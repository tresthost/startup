#!/bin/bash

# Check if URL is provided as argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <URL>"
    exit 1
fi

# Define the URL provided as argument
url="$1"

# Path to the startup script
startup_script="/home/container/startup.sh"

# Generate a random file name for the downloaded script
temp_script=$(mktemp)

# Download the script from the provided URL
echo "Downloading script from $url..."
wget -q "$url" -O "$temp_script"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Download successful."

    # Check if the startup script already exists
    if [ -f "$startup_script" ]; then
        echo "Startup script already exists. Overwriting..."
    else
        echo "Startup script does not exist. Creating..."
    fi

    # Make the downloaded script executable
    chmod +x "$temp_script"

    # Overwrite the existing script or move the downloaded script to the startup location
    mv -f "$temp_script" "$startup_script"

    echo "Executing the script..."
    "$startup_script"  # Execute the script

    # Check if the script execution was successful
    if [ $? -eq 0 ]; then
        echo "Script executed successfully."
    else
        echo "Script execution failed."
        exit 1
    fi
else
    echo "Download failed."
    exit 1
fi

echo "Server startup process completed."