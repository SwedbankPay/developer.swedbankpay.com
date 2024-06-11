---
title: Contributing
permalink: /:path/contributing/
menu_order: 1000
---

To make it clear exactly how outside contributors should provide their
contributions to the project, a CONTRIBUTING.md file should be created at the
root of the repository. Once such a file exists, GitHub will present it to
users creating new pull requests, issues, etc. in the repository. Here's an
example of how such a file can look like:

## How to contribute

To contribute to the Swedbank Pay Development Guidelines, there's just a few
things you need to know.

## Getting Started

*   Read and make sure you agree with the [Code of Conduct][coc]{:target="_blank"}.
*   Make sure you have a [GitHub account][github]{:target="_blank"}.
*   Then, you have three options:
    1.  Submit a ticket for your issue, assuming one does not already exist.
        *   Clearly describe the issue including steps to reproduce when it is a
            bug.
        *   Make sure you fill in the earliest version that you know has the
            issue.
    2.  Edit the file you want to change directly on GitHub.
    3.  Fork the repository on GitHub.

If you choose option 3 (forking the repository), then please read on.

## Making Changes

*   Create a new [branch][branching]{:target="_blank"} from where you want to
    base your work.
    *   This is usually the `master` or `develop` branch.
    *   Please avoid working directly on the `master` and `develop` branch.
*   Make [commits][commit]{:target="_blank"} of logical units in the new branch.
*   Check for unnecessary space with `git diff --check` before committing.
*   Make sure your [commit messages][commit-practice] are well written and in
    the proper format.
*   [Push][push]{:target="_blank"} the branch to your
    [forked repository (remote)][remote]{:target="_blank"}.
*   Submit a pull request for the pushed branch.

[coc]: /checkout-v3/modules-sdks/development-guidelines/code-of-conduct
[github]: https://github.com/join
[branching]: https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell
[commit]: https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository
[commit-practice]: /checkout-v3/modules-sdks/development-guidelines/good-commit-practice
[push]: https://git-scm.com/docs/git-push
[remote]: https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes
