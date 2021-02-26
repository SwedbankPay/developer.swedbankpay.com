#!/bin/bash
set -o errexit #abort if any command fails
me=$(basename "$0")

help_message="\
Usage: echo $me <version>

Generates variables based on the provided environment variable GITHUB_CONTEXT
and <version> argument.

GITHUB_CONTEXT: An environment variable containing a JSON string of the GitHub
                context object. Typically generated with \${{ toJson(github) }}."

initialize() {
    github_context_json="$GITHUB_CONTEXT"

    if [[ -z "$github_context_json" ]]; then
        echo "Missing or empty GITHUB_CONTEXT environment variable." >&2
        echo "$help_message"
        exit 1
    fi

    repository=$(echo "$github_context_json" | jq --raw-output .repository)
    fork_repository=$(echo "$github_context_json" | jq --raw-output .event.pull_request.head.repo.full_name)
    ref=$(echo "$github_context_json" | jq --raw-output .ref)

    if [[ -n "$fork_repository" ]]; then
        # If $fork_repository is set (as it should be in pull requests), use that
        # as our $repository value instead of the main repository.
        repository="$fork_repository"
    fi

    if [[ -z "$repository" ]]; then
        echo "No 'repository' found in the GitHub context." >&2
        echo "$help_message"
        exit 1
    fi

    if [[ -z "$ref" ]]; then
        echo "No 'ref' found in the GitHub context." >&2
        echo "$help_message"
        exit 1
    fi
}

generate_variables() {
    # Remove the 'refs/*/' prefix from $ref to get the bare branch name.
    branch="${ref#refs/tags/}"
    branch="${branch#refs/heads/}"

    echo "Branch:     $branch"
    echo "Repository: $repository"
    echo "::set-output name=branch::$branch"
    echo "::set-output name=repository::$repository"
}

main() {
    initialize "$@"
    generate_variables
}

main "$@"
