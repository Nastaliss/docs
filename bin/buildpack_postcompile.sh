#!/bin/bash

set -o errexit    # always exit on error
set -o pipefail   # don't ignore exit codes when piping output

echo "-----> Running post-compile script"

rm -rf deploy docker docs env.d gitlint
rm -rf src/frontend/apps src/frontend/packages
rm -rf src/frontend/node_modules

# du -ch | sort -rh | head -n 100
