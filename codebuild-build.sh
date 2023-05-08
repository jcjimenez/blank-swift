#!/bin/bash

# This script represents the build phase of a CodeBuild build run. For more
# information, see the buildspec.yml file.

set -e

export SCRIPT_NAME=`basename $0`

echo Hello from the $SCRIPT_NAME script.
