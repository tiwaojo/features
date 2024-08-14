#!/bin/bash

set -e

source dev-container-features-test-lib

# Feature-specific tests
# Checks if the mcap binary is installed and if the version matches the latest version.
LATEST_VERSION=$(curl https://api.github.com/repos/foxglove/mcap/releases/latest | jq -r '.tag_name')
LATEST_VERSION=$(echo ${LATEST_VERSION} | sed 's/releases\/mcap-cli\///g') # extract version number

check "mcap latest" bash -c "mcap version | grep ${LATEST_VERSION}"

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
