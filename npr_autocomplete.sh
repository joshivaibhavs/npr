#!/bin/bash

# This script will add autocomplete to the "npm run" command.
# It will autocomplete the names of the scripts in the package.json file.

PACKAGE_JSON=""

# Get the list of scripts from the package.json file
NODE_SCRIPTS=""

# Declare the npr function
npr() {
    # If there are no arguments, just list the scripts
    if [ $# -eq 0 ]; then
        echo $NODE_SCRIPTS
        return
    fi
    
    # If there is only one argument, autocomplete it
    if [ $# -eq 1 ]; then
        COMPREPLY=($(compgen -W "$NODE_SCRIPTS" -- "${COMP_WORDS[1]}"))
    fi
    
    # If there are more than one argument, just run the command
    npm run "$@"
}

_npr() {
    PACKAGE_JSON="$(pwd)/package.json"
    if [ ! -f "$PACKAGE_JSON" ]; then
        return
    fi
    NODE_SCRIPTS=$(node -e "console.log(Object.keys(require('$PACKAGE_JSON').scripts || {}).join(' '))")
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W "$NODE_SCRIPTS" -- "$cur"))
}

complete -F _npr npr
