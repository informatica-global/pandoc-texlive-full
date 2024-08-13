#!/bin/bash

LOCAL_DIR="./texlive/tlnet"
REMOTE_URL="rsync://tug.ctan.org/CTAN/systems/texlive/tlnet/"
LAST_SYNC_FILE="./texlive/last_sync"

# Function to perform rsync and handle errors
perform_rsync() {
  rsync -a --delete $REMOTE_URL $LOCAL_DIR
  if [ $? -ne 0 ]; then
    echo "Error: rsync failed."
    exit 1
  fi
  touch $LAST_SYNC_FILE
}

# Check if the local directory exists
if [ ! -d "$LOCAL_DIR" ]; then
  mkdir -p "$LOCAL_DIR"
  echo "Directory created, performing initial rsync..."
  perform_rsync
  exit 0
fi

# Check if the last-sync file exists
if [ ! -f "$LAST_SYNC_FILE" ]; then
  echo "Last-sync file not found, performing initial rsync..."
  perform_rsync
  exit 0
fi

# Get the current time in seconds since the epoch
current_time=$(date +%s)

# Get the modification time of the last-sync file in seconds since the epoch
last_sync_time=$(stat -c %Y "$LAST_SYNC_FILE")

# Calculate the difference in seconds
time_diff=$((current_time - last_sync_time))

# Check if the difference is greater than one day (86400 seconds)
if [ $time_diff -gt 86400 ]; then
  echo "Updating TeX Live repository..."
  perform_rsync
else
  echo "TeX Live repository is up to date."
fi
