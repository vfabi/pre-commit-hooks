#!/usr/bin/env bash

# Purpose: pre-commit framework hook to perform operations for configuration files templating.
# Requirements:
#   - pre-commit framework
#   - python3
# Author: vfabi


SCRIPT_PATH=`dirname ${BASH_SOURCE[0]}`
. "$SCRIPT_PATH/lib.sh"


function files_templates_rollback {
  # Perform template files templating rollback.

  PWD="$(pwd)/configuration/tools"
  VARIABLES_FILE="configuration/tools/variables.yaml"
  MESSAGE="[INFO] files_templating_rollback: rollback file templates."

  if [ -f "$VARIABLES_FILE" ]; then
    cecho "GREEN" "$MESSAGE"
    python3 $PWD/templater.py rollback -v $VARIABLES_FILE
  else
    cecho "RED" "[WARNING] files_templating_rollback: can't rollback template files. Templates variables file '$VARIABLES_FILE' not found."
    exit 1
  fi
}


function file_variables_yaml {
  # Encrypt 'variables.yaml' file, that contains sensitive template files variables.

  PWD="$(pwd)/configuration/tools"
  VARIABLES_FILE="configuration/tools/variables.yaml"
  MESSAGE="[INFO] file_variables_yaml: found '$VARIABLES_FILE' file updates. Encrypting it."

  for file in "$@"; do
    if [ "$file" == "$VARIABLES_FILE" ]; then
      cecho "GREEN" "$MESSAGE"
      python3 $PWD/cryptor.py --action encrypt_file --key-filename $PWD/secret.key --file $PWD/variables.yaml
    fi
  done
}


files_templates_rollback
file_variables_yaml $@
