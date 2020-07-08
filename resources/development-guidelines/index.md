---
title: Swedbank Pay Open Source Development Guidelines
sidebar:
  navigation:
  - title: Swedbank Pay Development Guidelines
    items:
    - url: /resources/development-guidelines
      title: Introduction
    - url: /resources/development-guidelines/code-of-conduct
      title: Code Of Conduct
    - url: /resources/development-guidelines/contributing
      title: Contributing
    - url: /resources/development-guidelines/good-commit-practice
      title: Good Commit Practice
    - url: /resources/development-guidelines/license
      title: License
---

## Introduction

Swedbank Pay is committed to creating a vibrant community around its open
source initiative on GitHub and will alongside its partners expose the Swedbank
Pay Payment APIs in high quality client modules and libraries. The development
of these modules and libraries should be as transparent and accessible to the
public as possible. The consequence and meaning of this will be explained in
the following chapters of this guideline.

Having the source code, tests, documentation, issues and such all in one place
makes the projects governing the modules and libraries easier to grasp and
understand for new users. GitHub is the world’s most popular developer and
source code hosting platform and offers everything we need in an easy to use
package. It is therefore a great choice for hosting the source code for the
open source modules and all of their related resources.

## Principles

For an open source project to become successful, it should follow a few core
principles:

### Transparency

Being transparent is one of the most important virtues of an open source
project. Being able to inspect the source code, read the documentation, view
potentially reported bugs and understand the development process in an
accessible and easy to understand way is critical to be able to assert the
quality of the project.

Being transparent also makes it apparent that we don’t have anything to hide,
underlining our confidence in the quality of what we publish, which of course
should be top notch.

### Quality

An important factor to ensure the quality of any given piece of code is to
test it. The test should preferably be automated and be run on every code
check-in. The automation can be done through a language-native test framework
like NUnit, JUnit or PHPUnit and then have a continuous integration system like
Travis or TeamCity execute these tests every time code is pushed to the
repository on GitHub.

Code quality of course depends on a lot of other factors too, such as:

*   Following best practice of the language and environment the code is being
    written in.
*   Adhering to established style guides.
*   Good understanding of
    [The Principles of Object Oriented Design][principles-of-object-oriented-design].
*   A good domain architecture, modelled after
    [Domain Driven Design][domain-driven-design].

### Accessibility

The perhaps most important measure of success for an open source project is
whether people outside of the project’s core development group contribute to
it or not. The contributions can be everything from reported issues to
correcting typographic errors in documentation to pull requests for minor or
major code contributions.

To be able to attract outside contributors, the project needs to be
accessible. While accessibility is an abstract term, it can be broken
down into smaller and more concrete parts that are easier to measure and
understand.

Is the development process for the project easy to understand? Where are
outstanding features listed, who are the developers working on which features
and where do they reside? How easy is it to fork the project and make a pull
request that has a high chance of being merged?

These are questions that should be asked and that can be answered confidently
if the project is managed in a good and orderly fashion. The following list
enumerates the most important aspects that a project should be governed by to
be perceived as accessible:

1.  Outstanding features and bugs should be easy to find in the list of “issues”
    in the project’s repository.
2.  The project’s documentation should be easily accessible in or linked to from
    the project’s `README` file.
3.  The `README` file and associated documentation should be written in simple
    [Markdown][markdown] markup so it is easy to correct by anyone simply by
    using GitHub’s online Markdown editing features.
4.  How to contribute should be clearly explained in a `CONTRIBUTING` file.
5.  The process of contributing should be as simple as possible.
    1.  The project should follow the norm and best practice of the language and
        environment it is written in.
    2.  There should be tests in the project that are easy to get up and running
        on a developer machine without installing any external services, tools or
        libraries, unless they are handled by a package manager like NuGet.
    3.  Contributed code should be checked by a
        [continuous integration][continuous-integration] server that labels the
        status of pull request accordingly. If a test fails, the contributor
        should be alerted of its failure through GitHub’s interface.
6.  All code contributions should be run through a public continuous integration
    server so build failures are visible to the contributor such that it can be
    fixed without any project manager’s involvement.
7.  The development and branching process should preferably be based on an
    existing scheme such as [GitFlow][gitflow] or [GitHub Flow][github-flow].
8.  All development should be done in public.
    1.  Code should be pushed to GitHub regularly, so it’s possible to see
        progress.
    2.  For incomplete features and bugfixes, [GitFlow][gitflow] with branch
        prefixes such as `feature/` and `hotfix/` should be used
    3.  All code in development should be pushed as often as possible.

### Security

All source code should be written in a secure way so it avoids the problems
enumerated in [OWASP Top 10][owasp-top-10] and [SANS 25][sans-25]. It should
preferably exist a test for each of these problems such that it is continually
verified that the code does not contain any of these problems now or in the
future.

No source code should contain secrets, passwords or otherwise sensitive
information. If such code is committed by accident, history should be
rewritten through interactive rebasing as soon as possible and force-pushed.

## Licensing

All of Swedbank Pay' open source software should be licensed under a liberal and
enterprise, closed source-compatible [software license][software-license].

## Copyright

The copyright for code written in Swedbank Pay's open source projects is shared
between Swedbank Pay and the individual authors of the source code. This should
be stated in the above mentioned LICENSE file as well as in each individual
source code file and other metadata (such as .NET assembly information, etc.):

`Copyright © Swedbank Pay and Project Contributors`

## How to Contribute

[Contributing][contributing] details how we ensure that contributors to a
project adheres to the rules and principles defined by the project.

## Code of Conduct

Every project governed by Swedbank Pay or in its name should have a
[Code of Conduct][code-of-conduct].

## Release Management

An essential part of any software project is having it released in one form or
another so other people can use it. To be able to release software efficiently,
several different strategies and methodologies need to exist and be followed.
They will be described in the following chapters.

### Versioning

To release software, it needs to be versioned. Swedbank Pay's open source
packages should be versioned according to [semantic
versioning][semantic-versioning]. This means that whenever backward
compatibility is broken, the major version should be incremented. When a new
feature is added, the minor version should be incremented and when bug fixes and
other minor changes are introduced, the revision number should be incremented.

A version of the software should correspond to a commit in the Git repository.
This commit should be tagged with the version number it represents and the
commit should be in the branch corresponding with what’s being released;
stable code should be in the master branch, while pre-release, alpha or beta
code should be in the develop branch or in a release/ prefixed branch.

If a stable version `1.2.5` of a project is to be released, the commit
representing that version should be tagged in Git with the value `1.2.5`
and the commit should exist in the master branch.

To help with automating versioning in .NET based projects,
[GitVersion][git-version] can be used. For most uses,
[GitVersionTask][gitversion-task] performs the job perfectly.
It understands [GitFlow][gitflow] and increments the version number
automatically based on which branch the code being built exists on.

### Branching strategy

To make versioning easier, the Git repository should follow [GitFlow][gitflow],
[GitHub Flow][github-flow] or derivates, so released and stable code is kept in
 the master branch, while unstable and pre-released code
  — if such is required — is kept in the develop branch.

While they can be considered optional since all ongoing development can be
done directly in the develop branch; features, hotfixes and such should
preferably be done in separate branches using the GitFlow-standard branch
prefixes `feature`, `hotfix/`, etc.

### Releases

Software written for an environment that has a marketplace or other
official storefront for applications
(or “modules”, “extensions” and what have you) such as
[Apple’s App Store][apple-app-store] or [Google Play][google-play],
should try to publish the released software in these marketplaces.

Releases should correspond to a tagged version number and a [Release][release]
for the version should be created on GitHub. The GitHub Release should
summarize all changes made since the last release and highlight new features,
possibly by referring to blog entries or similar that describes them in more
detail.

To help with writing release notes, projects can use the tool
[GitReleaseNotes][git-release-notes].

[apple-app-store]: https://appstore.com/
[code-of-conduct]: /resources/development-guidelines/code-of-conduct
[continuous-integration]: https://en.wikipedia.org/wiki/Continuous_integration
[contributing]: /resources/development-guidelines/contributing
[domain-driven-design]: https://martinfowler.com/tags/domain%20driven%20design.html
[git-release-notes]: https://github.com/GitTools/GitReleaseNotes
[git-version]: https://github.com/GitTools/GitVersion
[gitflow]: https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow/
[github-flow]: https://guides.github.com/introduction/flow/
[gitversion-task]: https://www.nuget.org/packages/GitVersionTask
[google-play]: https://play.google.com/store
[markdown]: https://help.github.com/articles/github-flavored-markdown/
[owasp-top-10]: https://owasp.org/www-project-top-ten/
[principles-of-object-oriented-design]: https://wiki.c2.com/?PrinciplesOfObjectOrientedDesign
[release]: https://help.github.com/articles/creating-releases/
[sans-25]: https://www.sans.org/top25-software-errors/
[semantic-versioning]: https://semver.org/
[software-license]: /resources/development-guidelines/license
