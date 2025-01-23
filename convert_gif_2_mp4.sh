#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <path-to-gif-file>"
  exit 1
fi

input_file="$1"

if [ ! -f "$input_file" ]; then
  echo "Error: File '$input_file' not found!"
  exit 1
fi

dir_name=$(dirname "$input_file")
base_name=$(basename "$input_file" .gif)
output_file="$dir_name/$base_name.mp4"

ffmpeg -stream_loop 2 -i "$input_file" -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "$output_file"

if [ $? -eq 0 ]; then
  echo "Conversion successful! MP4 saved to: $output_file"
else
  echo "Conversion failed!"
fi

