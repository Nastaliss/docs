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

# Remove additional build artifacts
rm -rf src/frontend/node_modules/.cache
rm -rf .github crowdin gitlint .gitlint .sops.yaml
rm -rf src/frontend/node_modules/@vitest src/frontend/node_modules/vitest
rm -rf src/frontend/node_modules/@playwright src/frontend/node_modules/playwright*
rm -rf src/frontend/node_modules/eslint* src/frontend/node_modules/@eslint
rm -rf src/frontend/node_modules/@testing-library src/frontend/node_modules/jest*
rm -rf src/frontend/node_modules/@storybook src/frontend/node_modules/storybook
rm -rf src/frontend/node_modules/webpack src/frontend/node_modules/terser
rm -rf src/frontend/node_modules/@cuningham
rm -rf src/frontend/node_modules/react-dom src/frontend/node_modules/react
rm -rf src/frontend/node_modules/@react-pdf src/frontend/node_modules/pdfjs-dist

du -ch | sort -rh | head -n 50
