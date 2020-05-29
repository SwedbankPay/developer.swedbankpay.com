---
title: Data Protection
sidebar:
  navigation:
  - title: Resources
    items:
    - url: /resources/
      title: Introduction
    - url: /resources/sdk-modules
      title: SDKs and Modules
    - url: /resources/test-data
      title: Test Data
    - url: /resources/demoshop
      title: Demoshop
    - url: /resources/development-guidelines
      title: Open Source Development Guidelines
    - url: /resources/release-notes
      title: Release Notes
    - url: /resources/terminology
      title: Terminology
    - url: /resources/data-protection
      title: Data Protection
    - url: /resources/public-migration-key
      title: Public Migration Key
---

## Paymentorder consumer data

When creating a payment order and checking in a consumer the consumer may opt to
create a profile.
This will store certain data (listed below) to their profile.
However if a consumer choose to not create a profile we store the consumer data
as the provided data is only possible to input during this stage.
To have access to this when completing a payment order, such as capturing it
when shipping the order the address and name must be available on a profile,
to achieve this we store the information temporarily to make sure it is available.
This data is deleted after **28 days**.

### Data stored temporarily or on a profile

*   Billing address
*   Country code
*   First name
*   Last name
*   Legal address
*   Social security number
*   Social security number country code
