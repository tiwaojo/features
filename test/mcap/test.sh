#!/bin/bash

set -e

source dev-container-features-test-lib

# Feature-specific tests
# Checks if the mcap binary is installed and if the version matches the expected version(0.0.34).
check "mcap version" bash -c "mcap version | grep 'v0.0.34'"

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults