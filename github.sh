#!/bin/bash

# This scripts uses jq 
# Tried an attempt to handle this within the script but if doesn't work please download jq
# Resource for downloading jq https://stedolan.github.io/jq/download/


# Using color codes for beautifying the script
RED="\\033[1;31m"
GREEN="\\033[1;32m"
PURPLE="\\033[1;35m"
YELLOW="\\033[1;33m"
NOCOLOR="\\033[0m"

# Color codes work only when using source before running the scripts (tested this on MacOS)

# General tokens that are to be declared
PRIVATE_TOKEN="" # Your access token to download the artifact
ARTIFACT_URL="https://api.github.com/repos/<organization_name>/<repo_name>/releases/latest" # Project URL from which the artifact is to be downloaded.

# How to get the project artifact on github read here 
# https://docs.github.com/en/rest/reference/repos#get-the-latest-release

# Checking jq is installed or not if not, We will be downloading it based on platform
if jq --version
then 
    if [ "$PRIVATE_TOKEN" != ""]
    then 
        echo -e "\\n $GREEN Fetching latest release from source. $NOCOLOR"
        LATEST_ASSEST=$(CURL -u username:$PRIVATE_TOKEN $ARTIFACT_URL | jq -r '.assets[].url')
        if [ "$LATEST_ASSEST" != ""]
        then 
            echo -e "$GREEN Downloading latest release from the source. $NOCOLOR"
            CURL --verbose -L  -u username:$PRIVATE_TOKEN --header 'Accept: application/octet-stream' $LATEST_ASSEST
            echo "\\n $GREEN Latest release successfully downloaded from source $NOCOLOR"
        else 
            echo -e "\\n $RED Downloading for latest release failed: Invalid download URL found. $NOCOLOR"
        fi
    else 
        echo -e "\\n $RED Private token is missing, Unable to fetch latest release from source. $NOCOLOR"
    fi
else 
    echo -e "\\n $PURPLE Script dependency is missing, Do you wish to install the dependency (yes,no) $NOCOLOR"
    read INSTALL_DEPENDENCY
    if [ "$INSTALL_DEPENDENCY" == "yes" ]
    then
        echo -e "\\n $GREEN Installing dependency $NOCOLOR"
        # Checking OS type
        if [[ "$OSTYPE" == "linux-gnu"* ]]
        then 
            sudo apt-get install jq
            source github.sh
        elif [[ "$OSTYPE" == "darwin"* ]]
        then 
            brew install jq
            source github.sh
        fi
    elif [ "$INSTALL_DEPENDENCY" == "no" ]
    then
        echo -e "
            \\n $YELLOW Opted no for installing dependency. Please manually install the dependency to run this script.
            \\n Use this link to download the the dependency https://stedolan.github.io/jq/download/
            $NOCOLOR
        "
    else
        echo -e "\\n $RED No valid option selecting. Aborting downloading of dependency $NOCOLOR"
    fi
fi