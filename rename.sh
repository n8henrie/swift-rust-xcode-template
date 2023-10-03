#!/bin/bash

set -euf -o pipefail
set -x

# Force use of MacOS built-in tooling, which should always be available. This
# avoids issues for users that are using GNU coreutils by default via homebrew
# or nixpkgs.
PATH=$(getconf PATH)

OLDNAME='{{project-name}}'
NEWNAME='{{crate_name}}'

find . -type f -not -name 'rename.sh' -not -path "./.git/*" -exec sed -i '' -e "s|${OLDNAME}|${NEWNAME}|g" {} +

find . -name "*${OLDNAME}*" -exec bash -c '[ -e "${1}" ] && mv "${1}" "${1//"${2}"/${3}}"' _ {} "${OLDNAME}" "${NEWNAME}" \;
