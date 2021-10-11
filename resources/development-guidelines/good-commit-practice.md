---
title: Good Commit Practice
estimated_read: 15
---

The following document is a fork of
[OpenStack's Git Commit Good Practice][good-practice], rewritten to suit
Swedbank Pay needs. It is based on experience doing code development, bug
troubleshooting and code review across a number of projects using Git.
Examination of other open source projects suggested they all follow a fairly
common practice. It is motivated by a desire to improve the quality of the
Git history in any repository. Quality is a hard term to define in computing;
one person's "Thing of Beauty" is another's "Evil Hack". We can, however,
come up with some general guidelines for what to do, or conversely what not
to do, when publishing Git commits for merge with a project. This topic can
be split into two areas of concern:

1.  The structured set/split of the code changes
2.  The information provided in the commit message

## Executive Summary

The points and examples that will be raised in this document ought to clearly
demonstrate the value in splitting up changes into a sequence of individual
commits, and the importance in writing good commit messages to go along with
them. If these guidelines were widely applied it would result in a significant
improvement in the quality of the  Git history. Both a carrot and a stick will
be required to effect changes. This document intends to be the carrot by
alerting people to the benefits, while for anyone doing  code reviews, it
can act as the stick.

In other words, when reviewing a change, do not simply look at the correctness
of the code. Review the commit message itself and request improvements to its
content. Look out for commits which are mixing multiple logical changes and
require the submitter to split them into separate commits. Ensure whitespace
changes are not mixed in with functional changes. Ensure no-op code
refactoring is done separately from functional changes. And so on.

Software source code is "read mostly, write occassionally" and thus the most
important criteria is to improve the long term maintainability by the large
pool of developers in the community, and not to sacrifice too much for the
sake of the single author who may never touch the code again.

And now the long detailed guidelines and examples of good and bad practice.

## Structural split of changes

The cardinal rule for creating good commits is to ensure there is only one
"logical change" per commit. There are many reasons why this is an important
rule:

*   The smaller the amount of code being changed, the quicker and easier it is
    to review and identify potential flaws.
*   If a change is found to be flawed later, it may be necessary to revert the
    broken commit. This is much easier to do if there are not other unrelated
    code changes entangled with the original commit.
*   When troubleshooting problems using Git's [bisect][bisect] capability, small
    well defined changes will aid in isolating exactly where the code problem
    was introduced.
*   When browsing history using Git annotate/blame, small well defined changes
    also aid in isolating exactly where & why a piece of code came from.

## Things to avoid when creating commits

With that in mind, there are some commonly encountered examples of bad things
to avoid:

### Mixing formatting changes with functional code changes

The formatting (code style, whitespace, etc.) changes will obscure the
important functional changes, making it harder for a reviewer to correctly
determine whether the change is correct.
**Solution**: Create 2 commits, one with the formatting changes and one with
the functional changes. Typically the formatting change would be done first,
but that need not be a hard rule.

### Mixing two unrelated functional changes

Again the reviewer will find it harder to identify flaws if two unrelated
changes are mixed together. If it becomes necessary to later revert a broken
commit, the two unrelated changes will need to be untangled, with further risk
of bug creation.

### Sending large new features in a single giant commit

It may well be the case that the code for a new feature is only useful when
all of it is present. This does not, however, imply that the entire feature
should be provided in a single commit. To group related code changes that for
the reasons explained here are split up into several separate commits,
intuitively named branches should be used instead.

New features often entail refactoring existing code. It is highly desirable
that any refactoring is done in commits which are separate from those
implementing the new feature. This helps reviewers and test suites validate
that the refactoring has no unintentional functional changes.

Even the newly written code can often be split up into multiple pieces that
can be independently reviewed. For example, changes which add new internal
APIs/classes, can be in self-contained commits. Again this leads to easier
code review. It also allows other developers to cherry-pick small parts of
the work, if the entire new feature is not immediately ready for merge.

Addition of new public HTTP APIs or RPC interfaces should be done in commits
separate from the actual internal implementation. This will encourage the
author & reviewers to think about the generic API/RPC design, and not simply
pick a design that is easier for their currently chosen internal
implementation. If patch impacts a public HTTP, use the APIImpact flag
(see [including external references](#including-external-references)).

The basic rule to follow is:

> If a code change can be split into a sequence of patches/commits, then it
> should be split. **Less is *not*   more. More is more**.

### Examples of bad practice

Now for some illustrations from Nova history. NB, although commit hashes are
quoted for reference, author names are removed, since no single person needs
to be blamed/picked on. Almost everybody is guilty of violating these good
practice rules at some time or another. In addition the people who reviewed
and approved these commits are just as guilty as the person who wrote/submitted
them.

{:.code-view-header}
**Example 1**

```http
commit ae878fc8b9761d099a4145617e4a48cbeb390623
Author: [removed]
Date:   Fri Jun 1 01:44:02 2012 +0000

    Refactor libvirt create calls

*   minimizes duplicated code for create
*   makes wait_for_destroy happen on shutdown instead of undefine
*   allows for destruction of an instance while leaving the domain
*   uses reset for hard reboot instead of create/destroy
*   makes resume_host_state use new methods instead of hard_reboot
*   makes rescue/unrescue not use hard reboot to recreate domain

    Change-Id: I2072f93ad6c889d534b04009671147af653048e7
```

There are at least two independent changes made in this commit.

1.  The switch to use the new `reset` API for the `hard_reboot` method.
2.  The adjustment to internal driver methods to not use `hard_reboot`.

What is the problem with this?

*   First there is no compelling reason why these changes needed to be made at
  the same time. A first commit could have included the changes to stop calling
  `hard_reboot` in various places. A second commit could have re-written the
  `hard_reboot` impl.
*   Second, as the switch to using the libvirt ##reset## method was buried in
  the large code refactoring, reviewers missed the fact that this was
  introducing a dependency on a newer libvirt API version. This commit was
  identified as the culprit reasonably quickly, but a trivial revert is not
  possible, due to the wide variety of unrelated changes included.

{:.code-view-header}
**Example 2**

```http
commit e0540dfed1c1276106105aea8d5765356961ef3d
Author: [removed]
Date:   Wed May 16 15:17:53 2012 +0400

    blueprint lvm-disk-images

    Add ability to use LVM volumes for VM disks.

    Implements LVM disks support for libvirt driver.

    VM disks will be stored on LVM volumes in volume group
    specified by `libvirt_images_volume_group` option.
    Another option `libvirt_local_images_type` specify which storage
    type will be used. Supported values are `raw`, `lvm`, `qcow2`,
    `default`. If `libvirt_local_images_type` = `default`, usual
    logic with `use_cow_images` flag is used.
    Boolean option `libvirt_sparse_logical_volumes` controls which type
    of logical volumes will be created (sparsed with virtualsize or
    usual logical volumes with full space allocation). Default value
    for this option is `False`.
    Commit introduce three classes: `Raw`, `Qcow2` and `Lvm`. They contain
    image creation logic, that was stored in
    `LibvirtConnection._cache_image` and `libvirt_info` methods,
    that produce right `LibvirtGuestConfigDisk` configurations for
    libvirt. `Backend` class choose which image type to use.

    Change-Id: I0d01cb7d2fd67de2565b8d45d34f7846ad4112c2
```

This is introducing one major new feature, so on the surface it seems
reasonable to use a single commit, but looking at the patch, it clearly has
entangled a significant amount of code refactoring with the new LVM feature
code. This makes it hard to identify likely regressions in support for
QCow2/Raw images. This should have been split into at least four separate
commits:

1.  Replace the `use_cow_images` config FLAG with the new FLAG
    `libvirt_local_images_type`, with back-compat code for support of legacy
    `use_cow_images` FLAG 2. Creation of internal "Image" class and subclasses
    for Raw & QCow2 image type impls.
2.  Refactor libvirt driver to replace raw/qcow2 image management code, with
    calls to the new `Image` class APIs.
3.  Introduce the new "LVM" `Image` class implementation.

### Examples of good practice

{:.code-view-header}
**Example 1**

```http
commit 3114a97ba188895daff4a3d337b2c73855d4632d
Author: [removed]
Date:   Mon Jun 11 17:16:10 2012 +0100

    Update default policies for KVM guest PIT & RTC timers

commit 573ada525b8a7384398a8d7d5f094f343555df56
Author: [removed]
Date:   Tue May 1 17:09:32 2012 +0100

    Add support for configuring libvirt VM clock and timers
```http

Together these two changes provide support for configuring the KVM guest
timers. The introduction of the new APIs for creating libvirt XML configuration
have been clearly separated from the change to the KVM guest creation policy,
which uses the new APIs.

{:.code-view-header}
**Example 2**

```http
commit 62bea64940cf629829e2945255cc34903f310115
Author: [removed]
Date:   Fri Jun 1 14:49:42 2012 -0400

    Add a comment to rpc.queue_get_for().
    Change-Id: Ifa7d648e9b33ad2416236dc6966527c257baaf88

commit cf2b87347cd801112f89552a78efabb92a63bac6
Author: [removed]
Date:   Wed May 30 14:57:03 2012 -0400

    Add shared_storage_test methods to compute rpcapi.
    ...snip...
    Add get_instance_disk_info to the compute rpcapi.
    ...snip...
    Add remove_volume_connection to the compute rpcapi.
    ...snip...
    Add compare_cpu to the compute rpcapi.
    ...snip...
    Add get_console_topic() to the compute rpcapi.
    ...snip...
    Add refresh_provider_fw_rules() to compute rpcapi.
    ...many more commits...
```

This sequence of commits refactored the entire RPC API layer inside nova to
allow pluggable messaging implementations. With such a major change in a core
piece of functionality, splitting up the work into a large sequence of commits
was key to be able to do meaningful code review, and track / identify possible
regressions at each step of the process.

## Information in commit messages

As important as the content of the change, is the content of the commit message
describing it. When writing a commit message there are some important things
to remember:

### Do not assume the reviewer understands what the original problem was

When reading bug reports, after a number of back & forth comments, it is often
as clear as mud, what the root cause problem is. The commit message should
have a clear statement as to what the original problem is. The bug is merely
interesting historical background on *how*   the problem was identified. It
should be possible to review a proposed patch for correctness without needing
to read the bug ticket.

### Do not assume the reviewer has access to external web services/site

In 6 months time when someone is on a train/plane/coach/beach/pub
troubleshooting a problem & browsing Git history, there is no guarantee they
will have access to the online bug tracker, or online blueprint documents. The
great step forward with distributed SCM is that you no longer need to be
"online" to have access to all information about the code repository. The
commit message should be totally self-contained, to maintain that benefit.

### Do not assume the code is self-evident/self-documenting

What is self-evident to one person, might be clear as mud to another person.
Always document what the original problem was and how it is being fixed, for
any change except the most obvious typos, or whitespace only commits.

### Describe *why* a change is being made

A common mistake is to just document how the code has been written, without
describing *why*   the developer chose to do it that way. By all means describe
the overall code structure, particularly for large changes, but more
importantly describe the intent/motivation behind the changes.

### Read the commit message to see if it hints at improved code structure

Often when describing a large commit message, it becomes obvious that a commit
should have in fact been split into 2 or more parts. Don't be afraid to go
back and rebase the change to split it up into separate commits.

### Ensure sufficient information to decide whether to review

When Gerrit sends out email alerts for new patch submissions there is minimal
information included, principally the commit message and the list of files
changes. Given the high volume of patches, it is not reasonable to expect all
reviewers to examine the patches in detail. The commit message must thus
contain sufficient information to alert the potential reviewers to the fact
that this is a patch they need to look at.

### The first commit line is the most important

In Git commits the first line of the commit message has special significance.
It is used as email subject line, git annotate messages, gitk viewer
annotations, merge commit messages and many more places where space is at a
premium. As well as summarizing the change itself, it should take care to
detail what part of the code is affected. eg if it affects the libvirt driver,
mention 'libvirt' somewhere in the first line.

### Describe any limitations of the current code

If the code being changed still has future scope for improvements, or any
known limitations then mention these in the commit message. This demonstrates
to the reviewer that the broader picture has been considered and what
tradeoffs have been done in terms of short term goals vs. long term wishes.

### Do not include patch set-specific comments

In other words, if you rebase your change please don't add
"Patch set 2: rebased" to your commit message.  That isn't going to be
relevant once your change has merged.  Please *do*   make a note of that in
Gerrit as a comment on your change, however.  It helps reviewers know what
changed between patch sets.  This also applies to comments such as
"Added unit tests", "Fixed localization problems", or any other such patch
set to patch set changes that don't affect the overall intent of your commit.

The main rule to follow is:

> The commit message must contain all the information required to fully
> understand & review the patch for correctness.
> **Less is *not* more. More is more.**

### Including external references

The commit message is primarily targeted towards human interpretation,
but there is always some metadata provided for machine use. For source code
hosted on GitHub, a reference to an issue can be made by simply writing
 `#<issue-number>`.

All machine targeted metadata is of secondary consequence to humans and thus
it should preferably be grouped together at the end of the commit message. For
simple references like GitHub issues, this is not required.

Note: Although it is common practice across many open source projects using
Git to include a `Signed-off-by` tag (generated by 'git commit -s'), this is
not required. Prior to gaining the ability to submit code, it should rather be
required that all contributors sign a CLA, which serves an equivalent purpose.

We encourage the use of `Co-Authored-By: name <name@example.com>` in commit
messages to indicate people who worked on a particular patch. It's a
convention for recognizing multiple authors, and our projects would encourage
the stats tools to observe it when collecting statistics.

### Summary of Git commit message structure

*   Provide a brief description of the change in the first line.
*   Insert a single blank line after the first line.
*   Provide a detailed description of the change in the following lines,
    breaking paragraphs where needed.
*   The first line should be limited to 50 characters and should not end with
*   a period.
*   Subsequent lines should be wrapped at 72 characters.
*   vim (the default `$EDITOR` on most distros) can wrap automatically lines for
    you. In most cases you just need to copy the example vimrc file (which can
    be found somewhere like `/usr/share/vim/vim74/vimrc_example.vim`) to
    `/.vimrc` if you don't have one already.
*   After editing a paragraph, you can re-wrap it by pressing escape, ensuring
    the cursor is within the paragraph and typing `gqip`.
*   Put external references at the very end of the commit message.

{:.code-view-header}
For example:

```http
Switch libvirt get_cpu_info method over to use config APIs

The get_cpu_info method in the libvirt driver currently uses
XPath queries to extract information from the capabilities
XML document. Switch this over to use the new config class
LibvirtConfigCaps. Also provide a test case to validate
the data being returned.

DocImpact
Closes-Bug: #1003373
Implements: blueprint libvirt-xml-cpu-model
Change-Id: I4946a16d27f712ae2adf8441ce78e6c0bb0bb657
```

### Some examples of bad practice

Now for some illustrations from Nova history, again with authors names
removed since no one person is to blame for these.

{:.code-view-header}
**Example 1**

```http
commit 468e64d019f51d364afb30b0eed2ad09483e0b98
Author: [removed]
Date:   Mon Jun 18 16:07:37 2012 -0400

    Fix missing import in compute/utils.py

    Fixes bug 1014829


Problem: this does not mention what imports where missing and why they were
needed. This info was actually in the bug tracker, and should have been copied
into the commit message, so that it would provide a self-contained
description. e.g.:


    Add missing import of 'exception' in compute/utils.py

    nova/compute/utils.py makes a reference to exception.NotFound,
    however exception has not been imported.
```

{:.code-view-header}
**Example 2**

```http
commit 2020fba6731634319a0d541168fbf45138825357
Author: [removed]
Date:   Fri Jun 15 11:12:45 2012 -0600

    Present correct ec2id format for volumes and snaps

    Fixes bug 1013765

*   Add template argument to ec2utils.id_to_ec2_id() calls

    Change-Id: I5e574f8e60d091ef8862ad814e2c8ab993daa366


Problem: this does not mention what the current (broken) format is, nor what
the new fixed format is. Again this info was available in the bug tracker and
should have been included in the commit message. Furthermore, this bug was
fixing a regression caused by an earlier change, but there is no mention of
what the earlier change was. e.g.:


Present correct ec2id format for volumes and snaps

During the volume uuid migration, done by changeset XXXXXXX,
ec2 id formats for volumes and snapshots was dropped and is
now using the default instance format (i-xxxxx). These need
to be changed back to vol-xxx and snap-xxxx.

Adds a template argument to ec2utils.id_to_ec2_id() calls

Fixes bug 1013765
```

{:.code-view-header}
**Example 3**

```http
commit f28731c1941e57b776b519783b0337e52e1484ab
Author: [removed]
Date:   Wed Jun 13 10:11:04 2012 -0400

    Add libvirt min version check.

    Fixes LP Bug #1012689.

    Change-Id: I91c0b7c41804b2b25026cbe672b9210c305dc29b

Problem: This commit message is merely documenting what was done, and not why
it was done. It should have mentioned what earlier changeset introduced the
new min libvirt version. It should also have mentioned what behaviour is when
the check fails. e.g.:

    Add libvirt version check, min 0.9.7

    The commit XXXXXXXX introduced use of the 'reset' API
    which is only available in libvirt 0.9.7 or newer. Add a check
    performed at startup of the compute server against the libvirt
    connection version. If the version check fails the compute
    service will shutdown.

    Fixes LP Bug #1012689.
    Change-Id: I91c0b7c41804b2b25026cbe672b9210c305dc29b
```

<!--lint disable no-duplicate-headings-->

### Examples of good practice

{:.code-view-header}
**Example 1**

```http
commit 3114a97ba188895daff4a3d337b2c73855d4632d
Author: [removed]
Date:   Mon Jun 11 17:16:10 2012 +0100

    Update default policies for KVM guest PIT & RTC timers

    The default policies for the KVM guest PIT and RTC timers
    are not very good at maintaining reliable time in guest
    operating systems. In particular Windows 7 guests will
    often crash with the default KVM timer policies, and old
    Linux guests will have very bad time drift

    Set the PIT such that missed ticks are injected at the
    normal rate, ie they are delayed

    Set the RTC such that missed ticks are injected at a
    higher rate to "catch up"

    This corresponds to the following libvirt XML

      <clock offset='utc'>
        <timer name='pit' tickpolicy='delay'/>
        <timer name='rtc' tickpolicy='catchup'/>
      </clock>

    And the following KVM options

      -no-kvm-pit-reinjection
      -rtc base=utc,driftfix=slew

    This should provide a default configuration that works
    acceptably for most OS types. In the future this will
    likely need to be made configurable per-guest OS type.

    Closes-Bug: #1011848

    Change-Id: Iafb0e2192b5f3c05b6395ffdfa14f86a98ce3d1f
```

Some things to note about this example commit message

*   It describes what the original problem is (bad KVM defaults)
*   It describes the functional change being made (the new PIT/RTC policies)
*   It describes what the result of the change is (new the XML/QEMU args)
*   It describes scope for future improvement (the possible per-OS type config)
*   It uses the Closes-Bug notation

{:.code-view-header}
**Example 2**

```http
commit 31336b35b4604f70150d0073d77dbf63b9bf7598
Author: [removed]
Date:   Wed Jun 6 22:45:25 2012 -0400

    Add CPU arch filter scheduler support

    In a mixed environment of running different CPU architecutres,
    one would not want to run an ARM instance on a X86_64 host and
    vice versa.

    This scheduler filter option will prevent instances running
    on a host that it is not intended for.

    The libvirt driver queries the guest capabilities of the
    host and stores the guest arches in the permitted_instances_types
    list in the cpu_info dict of the host.

    The Xen equivalent will be done later in another commit.

    The arch filter will compare the instance arch against
    the permitted_instances_types of a host
    and filter out invalid hosts.

    Also adds ARM as a valid arch to the filter.

    The ArchFilter is not turned on by default.

    Change-Id: I17bd103f00c25d6006a421252c9c8dcfd2d2c49b
```

Some things to note about this example commit message

*   It describes what the problem scenario is (mixed arch deployments)
*   It describes the intent of the fix  (make the schedular filter on arch)
*   It describes the rough architecture of the fix (how libvirt returns arch)
*   It notes the limitations of the fix (work needed on Xen)

[good-practice]: https://wiki.openstack.org/wiki/GitCommitMessages
[bisect]: https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git
