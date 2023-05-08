#!/bin/bash

# This script represents the build phase of a CodeBuild build run. For more
# information, see the buildspec.yml file.

set -e

export SCRIPT_NAME=`basename $0`
export EXECUTION_IDENTIFIER=`cat /proc/sys/kernel/random/uuid`

echo Hello from the $SCRIPT_NAME script.
if [ -z "$EXECUTION_IDENTIFIER" ]
then
   echo Unable to generate EXECUTION_IDENTIFIER 1>&2;
   exit 1
fi

echo Collecting contents
zip -r $EXECUTION_IDENTIFIER.zip .
aws s3api put-object --bucket $BUCKET_NAME --key $OBJECT_KEY --body $EXECUTION_IDENTIFIER.zip

echo Starting $PIPELINE_NAME pipeline execution with $EXECUTION_IDENTIFIER
aws codepipeline start-pipeline-execution --name $PIPELINE_NAME --client-request-token $EXECUTION_IDENTIFIER --output text
echo $?
echo Execution of $PIPELINE_NAME pipeline started with $EXECUTION_IDENTIFIER

echo TODO Waiting for pipeline to complete

