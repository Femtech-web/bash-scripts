#!/bin/bash

login_user() {
  aws configure sso --profile "$1"
  aws sso login --profile "$1"
}

# Check if a filename is provided as an argument
check_arg() {
  if [ $# -lt 2 ]; then
    echo "Usage: $0 <AWS profile name> <file name/path>"
    exit 1
  fi
}

# Upload file
upload_file() {
  # Store the filename provided as the second argument
  FILENAME="$2"

  # Check if the file exists
  if [ -f "$FILENAME" ]; then
    echo "File $FILENAME exists. Uploading..."
    # Upload to s3 bucket
    aws s3 cp "$FILENAME" s3://my-test-storage-bucket/ --profile "$1"
  else
    echo "File $FILENAME does not exist."
  fi
}

# Main script starts here
login_user "$1"
check_arg "$@"
upload_file "$1" "$2"
