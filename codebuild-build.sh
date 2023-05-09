#!/bin/bash

# This script represents the build phase of a CodeBuild build run. For more
# information, see the buildspec.yml file.

set -e

export SCRIPT_NAME=`basename $0`
export SCRIPT_IDENTIFIER=`cat /proc/sys/kernel/random/uuid`

echo Hello from the $SCRIPT_NAME script.
if [ -z "$SCRIPT_IDENTIFIER" ]
then
   echo Unable to generate SCRIPT_IDENTIFIER 1>&2;
   exit 1
fi

echo Collecting contents
export SOURCE_ZIP=$SCRIPT_IDENTIFIER.zip
zip -r $SOURCE_ZIP .
aws s3api put-object --bucket $BUCKET_NAME --key $OBJECT_KEY --body $SOURCE_ZIP

echo Starting $PIPELINE_NAME pipeline execution
export PIPELINE_EXECUTION_IDENTIFIER=`aws codepipeline start-pipeline-execution --name $PIPELINE_NAME --client-request-token $SCRIPT_IDENTIFIER --output text`
echo $?
echo Execution of $PIPELINE_NAME pipeline started with $PIPELINE_EXECUTION_IDENTIFIER

echo Waiting for pipeline to complete
while aws codepipeline get-pipeline-execution --pipeline-name $PIPELINE_NAME --pipeline-execution-id $PIPELINE_EXECUTION_IDENTIFIER --query pipelineExecution.status | grep -q InProgress;
do
    echo Pipeline execution in progress, waiting...
    sleep 5
done

# Succeeded
if aws codepipeline get-pipeline-execution --pipeline-name $PIPELINE_NAME --pipeline-execution-id $PIPELINE_EXECUTION_IDENTIFIER --query pipelineExecution.status | grep -q Succeeded;
then
    echo Pipeline execution succeeded
    exit 0
else
    echo Detected non-successful pipeline execution for pipeline $PIPELINE_NAME $PIPELINE_EXECUTION_IDENTIFIER 1>&2;
    exit 20
fi

