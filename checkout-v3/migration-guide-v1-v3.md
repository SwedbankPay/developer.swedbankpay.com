---
title: From Payment Methods v1 to Digital Payments v3.1
section: Migration Guides
permalink: /:path/migration-guide-v1-v3/
hide_from_sidebar: true
description: |
  The why and how to migrate from v1 to v3.1
menu_order: 10
---

## Why

The first main reason for migrating is the access to new development. All fresh
features and capabilities are exclusively released to Digital Payments, and will
not be available when using payment methods v1.

Likewise, new payment method additions like Google Pay, Apple Pay and Click to
Pay are only available when using the `paymentOrder` API, and can't be set up as
individual payment methods.

The second reason would be maintenance. With an integration made towards v1 and
each individual method's unique API, when new functionality, changes in behavior
or new instruments are introduced, they both come with their own separate need
for maintaining the existing integration.

By switching to Digital Payments v3.1, you will eliminate the need for
maintenance on multiple integrations due to the design of v3.1 and its one-size
fits all structure.

## How

Migrating from individual payment methods to Digital Payments v3 does require a
full new integration, but as we already mentioned, you only have to do it once!

Head over to [Get Started][get-started], and we'll walk the steps with you.

[get-started]: /checkout-v3/get-started/
