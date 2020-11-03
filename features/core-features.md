---
title: Core Features
redirect_from:
estimated_read: 30
description: |
  Welcome to Core Features - a subsection of Credit Card.
  This section has extented code examples and features that were not
  covered by the other subsections.
menu_order: 1000
---

{% include payment-resource.md api_resource="creditcard"
documentation_section="card" show_status_operations=true %}

{% include 3d-secure-2.md api_resource="creditcard" documentation_section="card" %}

{% include settlement-reconciliation.md documentation_section="card" %}

{% include iterator.html prev_href="index" prev_title="Introduction"
next_href="optional-features" next_title="Optional Features" %}