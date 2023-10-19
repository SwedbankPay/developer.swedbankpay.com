---
section: Nexo Retailer
title: Swedbank Pay Nexo Retailer v3.1
description: |
    Use the Nexo Retailer integration if you are unable to use .NET or Java SDK. This interface requires a greater effort for both users and Swedbank Pay.
---
The interface is based on Nexo Retailer version 3.1 and uses XML message formats over HTTP/TCP.
For reference it may be a good idea to download the Nexo specifications from `www.nexo-standards.org`, but the essentials will be described here.
Remember that Nexo Retailer is huge and we are far from giving support for everything.

*   **nexo Sale to POI Protocol Specifications Version 3.1**
*   **nexo Sale to POI Transport Protocols v3.1**

Download the full NIS V4.0 package to find the documents and schema files as well.

### Communication

The terminals are communicating over IP LAN or WLAN and the intended style is
that both the integrating party and the terminal implements a server and a client.
There is however, a solution to let the sale system act as a client only.

{% include card-list.html %}
