#!/usr/bin/env bash


SCRIPT_PATH=`dirname ${BASH_SOURCE[0]}`
. "$SCRIPT_PATH/lib.sh"


# Check 'variables.yaml' file exists.
# This file contains sensetive variables, thus it should not be commited.
for file in "$@"; do
  if [ "$file" == "folder1/variables.yaml" ]; then
    cecho "RED" "Found 'folder1/variables.yaml' file. Please remove it before commit."
    exit 1
  fi
done