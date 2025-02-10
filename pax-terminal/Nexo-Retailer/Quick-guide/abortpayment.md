---
title: AbortRequest
permalink: /:path/abortpayment/
description: Any request may be aborted using AbortRequest
menu_order: 50
---

AbortRequest may be sent for any ongoing request.

{:.code-view-header }
**Sample abort payment**

```xml
<SaleToPOIRequest>
    <MessageHeader MessageCategory="Abort" MessageClass="Service" MessageType="Request" POIID="A-POIID" SaleID="ECR1" ServiceID="1524253498"/>
    <AbortRequest>
        <MessageReference MessageCategory="Payment" POIID="A-POIID" SaleID="ECR1" ServiceID="1524253497"/>
        <AbortReason>Abort by Sale System</AbortReason>
    </AbortRequest>
</SaleToPOIRequest>
```

{:.table .table-striped}
| Name | Attributes | Description |
| :------------- | :-------------- |:--------------- |
| MessageReference | MessageCategory | Category of the request being aborted. |
| | POIID | POIID used in the request that is being aborted. |
| | SaleID | SaleID that was used in the request that is being aborted. |
| | ServiceID | ServiceID in the request that is being aborted. |
| AbortReason | | Text explaining the reason for the abortion. |

{% include alert.html type="warning" icon="warning" header="warning"
body= "The AbortRequest does not give a nexo message response. The Http status code will be 204-No content, but the actual request that is aborted will get a response with Result Failure."
%}

```mermaid
sequenceDiagram
participant POS
participant Terminal
    POS->>+Terminal: Http POST PaymentRequest
    POS->>+Terminal: Http POST AbortRequest
    Terminal->>-POS: rsp 204 - no content
    Terminal->>-POS: rsp 200 PaymentResponse Failure
```

{% include iterator.html prev_href="/pax-terminal/Nexo-Retailer/Quick-guide/make-payment" prev_title="Back to PaymentRequest" %}
