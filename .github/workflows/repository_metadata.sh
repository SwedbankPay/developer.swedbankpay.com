#!/bin/bash

if [[ "$EVENT_NAME" == "pull_request" && "$PULL_REPO_NAME" != "$REPO_NAME" ]]; then
    # We have a pull-request from a forked repository. Not sure this actually works.
    GITHUB_BRANCH="${HEAD_REF}"
    GITHUB_REPOSITORY_URL="$PULL_REPO_URL"
elif [[ -n "$HEAD_REF" ]]; then
    # Use the head_ref on merge commits
    GITHUB_BRANCH="${HEAD_REF}"
else
    # Use the branch head reference on regular commits
    GITHUB_BRANCH="${REF#refs/heads/}"
fi

if [[ $GITHUB_BRANCH == refs/tags* ]]; then
    # Default to the master branch on tags
    GITHUB_BRANCH="master"
fi

echo "::set-output name=branch::${GITHUB_BRANCH}"
echo "::set-output name=url::${GITHUB_REPOSITORY_URL}"
