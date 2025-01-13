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


    # If the first argument is "install" or "init", just run the command
    
    if [ "$1" == "install" ] || [ "$1" == "init" ]; then
        echo "npm $@"
        npm "$@"
        return
    fi
    if [ "$1" == "file" ]; then
        COMMANDS="${@//file/}"
        echo "node $COMMANDS"
        node $COMMANDS
        return
    fi

    # If there are more than one argument, just run the command
    echo "npm run $@"
    npm run "$@"
}

_npr() {
    PACKAGE_JSON="$(pwd)/package.json"
    if [ ! -f "$PACKAGE_JSON" ]; then
        NODE_SCRIPTS="init file"
    else
        NODE_SCRIPTS=$(node -e "console.log(Object.keys(require('$PACKAGE_JSON').scripts || {}).join(' '), 'install', 'file')")
    fi

    local cur=${COMP_WORDS[COMP_CWORD]}
    
    if [[ "${COMP_WORDS[1]}" == "file" ]]; then
        COMPREPLY=($(compgen -f -- "$cur"))
    else
        COMPREPLY=($(compgen -W "$NODE_SCRIPTS" -- "$cur"))
    fi
}

complete -F _npr npr
