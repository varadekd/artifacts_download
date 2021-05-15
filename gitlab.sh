#!/bin/bash

# Using color codes for beautifying the script
RED="\\033[1;31m"
GREEN="\\033[1;32m"
PURPLE="\\033[1;35m"
NOCOLOR="\\033[0m"

# Color codes work only when using source before running the scripts (tested this on MacOS)

# General tokens that are to be declared
PRIVATE_TOKEN="" # Your access token to download the artifact
ARTIFACT_URL="" # Project URL from which the artifact is to be downloaded.

# How to get the project artifact on gitlab read here 
# https://docs.gitlab.com/ee/ci/pipelines/job_artifacts.html#access-the-latest-job-artifacts-by-url

if [ "$PRIVATE_TOKEN" != "" ]
then 
    echo "\\n $GREEN Downloading artifact from source $NOCOLOR"
    CURL --verbose -L --output artifacts.zip --header "PRIVATE-TOKEN:$PRIVATE_TOKEN" $ARTIFACT_URL
    echo "\\n $GREEN Artifact successfully downloaded from source $NOCOLOR"
else 
    echo -e "\\n $RED Private token is missing, Unable to download the artifact from source. $NOCOLOR"
fi

