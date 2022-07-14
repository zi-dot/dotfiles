#!/bin/bash

echo -n "Please enter project name: "
read PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
    echo " 🙄 Please enter your project name" 1>&2
    exit 1
fi

PROJECT_PATH=~/Documents/$PROJECT_NAME-project

mkdir -p $PROJECT_PATH
mkdir -p $PROJECT_PATH/docs

echo -n "Enter your git repo url: "
read GITHUB_REPO_URL

if [ -z "$GITHUB_REPO_URL" ]; then
    echo "Skipped git clone"
else
    git clone $GITHUB_REPO_URL $PROJECT_PATH/code
fi
