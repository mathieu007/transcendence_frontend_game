#!/bin/bash

# Check if node_modules directory is empty
# if [ -z "$(ls -A /app/node_modules)" ]; then
#   echo "node_modules is empty. Running 'yarn install'..."
#   yarn install
# fi
echo "node_modules is empty. Running 'yarn install'..."
yarn install

# Execute the CMD from the Dockerfile
exec "$@"
