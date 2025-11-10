#!/bin/bash

set -e

# Generate the OpenAPI client
echo "Generating the OpenAPI client..."
openapi-generator generate -i ./api/openapi.json -g dart-dio -o ./openapi --skip-validate-spec

# Build the client
echo "Building the OpenAPI client..."
cd openapi
dart run build_runner build --delete-conflicting-outputs

# Done
echo "Done!"