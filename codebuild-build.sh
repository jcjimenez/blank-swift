#!/bin/bash

# This script represents the build phase of a CodeBuild build run. For more
# information, see the buildspec.yml file.

set -e

export SCRIPT_NAME=`basename $0`
export EXECUTION_IDENTIFIER=`cat /proc/sys/kernel/random/uuid`

echo Hello from the $SCRIPT_NAME script.

echo Listing contents:
find .

echo Starting $PIPELINE_NAME pipeline execution with $EXECUTION_IDENTIFIER
aws codepipeline start-pipeline-execution --name $PIPELINE_NAME --client-request-token $EXECUTION_IDENTIFIER
echo Execution of $PIPELINE_NAME pipeline started with $EXECUTION_IDENTIFIER
