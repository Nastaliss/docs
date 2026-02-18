#!/bin/bash

set -o errexit    # always exit on error
set -o pipefail   # don't ignore exit codes when piping output

echo "-----> Running post-compile script"

rm -rf deploy docker docs env.d gitlint
rm -rf src/frontend/apps src/frontend/packages

# Remove large frontend-only node_modules (keep packages needed by y-provider)
rm -rf src/frontend/node_modules/@next src/frontend/node_modules/next
rm -rf src/frontend/node_modules/react-icons src/frontend/node_modules/@gouvfr-lasuite
rm -rf src/frontend/node_modules/@swc src/frontend/node_modules/typescript
rm -rf src/frontend/node_modules/prettier src/frontend/node_modules/@babel
rm -rf src/frontend/node_modules/caniuse-lite src/frontend/node_modules/@types

# du -ch | sort -rh | head -n 100
