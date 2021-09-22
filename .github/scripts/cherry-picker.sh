#!/bin/bash
set -o errexit #abort if any command fails
me=$(basename "$0")

help_message="\
Usage: $me <branch-pattern>

Cherry-picks all commits matching <branch-pattern> onto the current branch."

initialize() {
    branch_pattern="$1"

    if [ -z "$branch_pattern" ]; then
        echo "Error: Missing <branch-pattern> argument."
        echo ""
        echo "$help_message" >&2
        exit 1
    fi
}

cherry_pick() {
    remote_branches=$(git branch --remote | grep "$branch_pattern")

    for remote_branch in $remote_branches; do
        ref=$(git rev-list --remove-empty --no-merges --first-parent --max-count=1 "$remote_branch")

        if git cherry-pick \
            --quiet \
            --strategy=recursive \
            --strategy-option=ours \
            --allow-empty \
            --allow-empty-message \
            --keep-redundant-commits \
            "$ref" \
            > /dev/null 2>&1; then
            echo "Success: Cherry-picked '$ref' ($remote_branch)."
        else
            echo "Error: Could not cerry-pick '$ref' ($remote_branch). Skipping." >&2
            git cherry-pick --abort
        fi
    done
}

main() {
    initialize "$@"
    cherry_pick
}

main "$@"
