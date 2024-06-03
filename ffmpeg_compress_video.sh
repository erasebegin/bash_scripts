#!/bin/bash

# Define the compression levels
declare -A VIDEO_BITRATES
VIDEO_BITRATES=( [1]="5000k" [2]="4500k" [3]="4000k" [4]="3500k" [5]="3000k" [6]="2500k" [7]="2000k" [8]="1500k" [9]="1000k" [10]="500k" )

declare -A AUDIO_BITRATES
AUDIO_BITRATES=( [1]="320k" [2]="288k" [3]="256k" [4]="224k" [5]="192k" [6]="160k" [7]="128k" [8]="96k" [9]="64k" [10]="32k" )

# Prompt the user to enter the video file path
echo "Please enter the path to your video file:"
read VIDEO_FILE

# Prompt the user to enter the desired compression level
echo "Please enter the desired compression level (1-10, 1 being the least compression and 10 being the most):"
read COMPRESSION_LEVEL

# Get the directory and base name of the video file
VIDEO_DIR=$(dirname "$VIDEO_FILE")
VIDEO_BASE_NAME=$(basename "$VIDEO_FILE")

# Create a new directory for the compressed video
mkdir -p "$VIDEO_DIR/compressed"

# Compress the video using ffmpeg and save it in the 'compressed' directory
ffmpeg -i "$VIDEO_FILE" -vf "scale=iw/2:ih/2" -b:v ${VIDEO_BITRATES[$COMPRESSION_LEVEL]} -b:a ${AUDIO_BITRATES[$COMPRESSION_LEVEL]} "$VIDEO_DIR/compressed/$VIDEO_BASE_NAME"
