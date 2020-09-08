---
title: Data Protection
estimated_read: 30
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
