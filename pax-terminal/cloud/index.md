---
section: Cloud Connection
title: Cloud Connected Terminal
permalink: /:path/
description: |
    The cloud connected terminal is by far the easiest way of installaing a terminal at customer.
menu_order: 2300
---

For using a cloud connected terminal the authorization protocol OAuth2 with client credential grant type is used. There will be one client id and client credential per integrator, but there may be situations depending on customer, that an integrator may have more than one. The credentials for test and production are different and valid for 24 months. Make sure it is stored safely and make sure it is easy to update. Credentials are received from Swedbank Pay on request.

The message protocol and flow of messages is described under [nexo Retailer][nexoretailer]{:target="_blank" } and is the same for all connection methods.

```mermaid
sequenceDiagram
participant POS
participant Cloud as Swedbank Pay Cloud
    POS->>Cloud: Retrieve an AccessToken
    Note over POS: Use token url to send <br/>client id and client credential.
    Cloud->>POS: Response holding access token
    Note over Cloud: Response with an AccessToken<br/>that is valid for 24h.
    POS->>Cloud: Pairing, connecting the POS to the terminal
    Note over Cloud,POS: "Note! Pairing is needed once per terminal
    Note over POS: Using the pairing url and the<br/>access token as bearer in header<br/>Authorization. Data is the pairing<br/>code shown on the terminal.
    Cloud->>POS: Pairing response
    Note over Cloud: Response includes a channel id <br/>to be used in the URL<br/>for all nexo messages.
```

## Detailed information

Please check out our [Swagger site][swagger]{:target="_blank"} for more details.

[swagger]: https://cloudconnect.stage.swedbankpay.com/swagger-ui/index.html
[nexoretailer]: /pax-terminal/Nexo-Retailer/
