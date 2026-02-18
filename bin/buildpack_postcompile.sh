#!/bin/bash

set -o errexit    # always exit on error
set -o pipefail   # don't ignore exit codes when piping output

echo "-----> Running post-compile script"

# Remove directories not needed at runtime
rm -rf deploy docker docs env.d gitlint .github crowdin .gitlint .sops.yaml
rm -rf src/mail
rm -rf src/frontend/apps src/frontend/packages

# Remove node headers (keep bin/node for y-provider)
rm -rf src/frontend/.scalingo/node/include

# Remove large frontend-only node_modules (keep packages needed by y-provider)
rm -rf src/frontend/node_modules/.cache
rm -rf src/frontend/node_modules/@next src/frontend/node_modules/next
rm -rf src/frontend/node_modules/react-icons src/frontend/node_modules/@gouvfr-lasuite
rm -rf src/frontend/node_modules/@swc src/frontend/node_modules/typescript
rm -rf src/frontend/node_modules/prettier src/frontend/node_modules/@babel
rm -rf src/frontend/node_modules/caniuse-lite src/frontend/node_modules/@types
rm -rf src/frontend/node_modules/@vitest src/frontend/node_modules/vitest
rm -rf src/frontend/node_modules/@playwright src/frontend/node_modules/playwright*
rm -rf src/frontend/node_modules/eslint* src/frontend/node_modules/@eslint
rm -rf src/frontend/node_modules/@testing-library src/frontend/node_modules/jest*
rm -rf src/frontend/node_modules/@storybook src/frontend/node_modules/storybook
rm -rf src/frontend/node_modules/webpack src/frontend/node_modules/terser
rm -rf src/frontend/node_modules/@cuningham
rm -rf src/frontend/node_modules/react-dom src/frontend/node_modules/react
rm -rf src/frontend/node_modules/@react-pdf src/frontend/node_modules/pdfjs-dist
rm -rf src/frontend/node_modules/emoji-datasource-apple
rm -rf src/frontend/node_modules/@napi-rs
rm -rf src/frontend/node_modules/@img
rm -rf src/frontend/node_modules/@react-aria
rm -rf src/frontend/node_modules/posthog-js
rm -rf src/frontend/node_modules/@emoji-mart

# du -ch | sort -rh | head -n 50
