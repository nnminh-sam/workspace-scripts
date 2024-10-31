#!/bin/bash

# Usage: ./create_repo.sh <repo-name> <account> [local-folder-name]
# Example: ./create_repo.sh nestjs-mailing-service nnminh service.mailing

# Check if at least two arguments are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <repo-name> <account> [local-folder-name]"
    exit 1
fi

# Assign input arguments to variables
REPO_NAME=$1
ACCOUNT=$2
LOCAL_FOLDER_NAME=${3:-$REPO_NAME} # If the third parameter is provided, use it; otherwise, use REPO_NAME

# Set the GitHub user info and SSH host alias based on the account
if [ "$ACCOUNT" == "sam" ]; then
    GIT_USER_NAME="nnminh-sam"
    GIT_USER_EMAIL="nnminh.sam.1803@gmail.com"
    SSH_ALIAS="nnminh-sam"
elif [ "$ACCOUNT" == "haise" ]; then
    GIT_USER_NAME="nnminhhaise"
    GIT_USER_EMAIL="nnminh.haise@gmail.com"
    SSH_ALIAS="nnminh-haise"
else
    echo "Invalid account specified. Use 'sam' or 'haise'."
    exit 1
fi

# Create the local directory with the specified or default name and initialize the git repository
mkdir "$LOCAL_FOLDER_NAME"
cd "$LOCAL_FOLDER_NAME" || exit
git init

# Set the user info for the repository
git config user.name "$GIT_USER_NAME"
git config user.email "$GIT_USER_EMAIL"

# Create an initial README file
echo "# $REPO_NAME" > README.md
git add README.md
git commit -m "Batman: Initialize repo with README.md"

# Add the remote using the specified SSH alias
git remote add origin git@$SSH_ALIAS:$GIT_USER_NAME/$REPO_NAME.git

echo "Repository '$REPO_NAME' created in folder '$LOCAL_FOLDER_NAME' and configured for $ACCOUNT account."
echo "Ensure to create the '$REPO_NAME' on GitHub using the $GIT_USER_NAME of email: $GIT_USER_EMAIL."
echo "Push the initial commit with: git push -u origin main"