#!/bin/bash

# Utility script for batch renaming files and replacing references to those
# filenames. You hopefully *don't* need to use this anymore, but still helpful
# to have around for development.

set -euf -o pipefail
set -x

# Force use of MacOS built-in tooling, which should always be available. This
# avoids issues for users that are using GNU coreutils by default via homebrew
# or nixpkgs.
PATH=$(getconf PATH)

OLDNAME='{{project-name}}'
NEWNAME='{{crate_name}}'

find . -type f -not -name 'rename.sh' -not -path "./.git/*" -exec sed -i '' -e "s|${OLDNAME}|${NEWNAME}|g" {} +

find . -name "*${OLDNAME}*" -execdir bash -c 'mv "${1}" "${1//"${2}"/${3}}"' _ {} "${OLDNAME}" "${NEWNAME}" \;
