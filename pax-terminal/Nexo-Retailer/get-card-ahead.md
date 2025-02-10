---
title: Advanced loyalty
permalink: /:path/get-card-ahead/
description: Possibility to read one or more cards prior to payment request, makes it possible to give a discount for members at time of payment
icon:
  content: credit_card
  outlined: true
menu_order: 30
---

The possibility to read one or more cards before the payment is actually made, makes it possible to know the customer and give a discount on the sale being made. With the possibility comes just a little bit more complexity and logic around messages.

{% include alert.html type="warning" icon="warning" header="Heads up!" body="To use this feature the POS side needs to implement a server. Print request might be generated when aborting."%}

{:.code-vie-header}
**Easy flow reading card before payment request**

```mermaid
sequenceDiagram
participant POS
participant Terminal
    POS->>Terminal: EnableService Request StartTransaction
    Terminal->>POS: EnableService Response success
    activate Terminal
    loop open all readers for card read
        POS->>Terminal: CardAcquisition Request
        Terminal->>POS: CardAcquisition Response
        Note left of Terminal: Response contains<br/>CNA,<br/>Masked PAN,<br/>Card type,<br/>Card product name
        Note left of Terminal: Terminal shows "please wait"
    end
    POS->>Terminal: Payment Request
    deactivate Terminal
    Note right of POS: Normal procedure for payment request.<br/>Last payment card read is used
```

The messages `EnableService` and `CardAcquisition` are key to this feature, but when aborting in different situations different messages are used depending on state.
A CardAcquisition is aborted using an `AbortRequest` but the enabled service is aborted using the `EnableServiceRequest AbortTransaction`.

{:.code-vie-header}
**Abort while waiting for a card**

```mermaid
sequenceDiagram
participant POS
participant Terminal
    POS->>Terminal: EnableService Request StartTransaction
    Terminal->>POS: EnableService Response success
    activate Terminal
    POS->>Terminal: CardAcquisition Request
    POS->>Terminal: AbortRequest
    Terminal-->>POS: Http response 204
    deactivate Terminal
    Terminal->>POS: CardAcquisition Response
    Note left of Terminal: Terminal shows transaction aborted
    Note left of Terminal: Terminal goes to idle state
```

The enabled service Transaction state lasts from the EnableService response until it is aborted or a PaymentRequest is sent. During that state several cardacquisitions may be issued, but if abort is desired after a card acquisition response there is no ongoing request and the state is terminated by the `EnableServiceRequest AbortTransaction`

{:.code-vie-header}
**Abort sequence after card has been read**

```mermaid
sequenceDiagram
participant POS
participant Terminal
    POS->>Terminal: EnableService Request StartTransaction
    Terminal->>POS: EnableService Response success
    activate Terminal
    POS->>Terminal: CardAcquisition Request
    Terminal->>POS: CardAcquisition Response
    POS->>Terminal: EnableServiceRequest AbortTransaction
    Terminal->>POS: EnableServiceResponse success
    deactivate Terminal
    alt payment card was read
        Note left of Terminal: Terminal shows transaction aborted
        Terminal->>POS: PrintRequest with receipt information
    end
    Note left of Terminal: Terminal goes to idle state
```

## EnableService

{:.code-view-header}
**Request**

```xml
<SaleToPOIRequest>
  <MessageHeader ProtocolVersion="3.1" MessageClass="Service" MessageCategory="EnableService" MessageType="Request" ServiceID="3" SaleID="1" POIID="A-POIID" />
  <EnableServiceRequest TransactionAction="StartTransaction">
    <ServicesEnabled>CardAcquisition</ServicesEnabled>
  </EnableServiceRequest>
</SaleToPOIRequest>
```

{:.table .table-striped}
| Name | Lev | Attribute | Description |
| :------------- | :---: | :-------------- |:--------------- |
| EnableServiceRequest | 1 | TransactionAction | StartTransaction or AbortTransaction. |
| ServiceEnabled | 2 | | Only value used is CardAcquisition. |

{:.code-view-header }
**Response**

```xml
<SaleToPOIResponse>
  <MessageHeader MessageClass="Service" MessageCategory="EnableService" MessageType="Response" ServiceID="3" SaleID="1" POIID="A-POIID" />
    <EnableServiceResponse>
      <Response Result="Success" />
    </EnableServiceResponse>
</SaleToPOIResponse>
```

Next request following a successful EnableServiceResponse for TransactionAction StartTransaction, is `CardAcquisition` or `EnableService` with `TransactionAction AbortTransaction`.

## CardAcquisition

{% include pax-cardacquisition-request.md %}

{% include pax-cardacquisition-response.md %}

### Proceed after card read

Following a successful CardAcquisitionResponse the terminal will show "Please wait" and any of the messages `EnableServiceRequest AbortTransaction`, `CardAcquisitionRequest`, `PaymentRequest`, `DisplayRequest` or `InputRequest` is feasible. If the amount is still not available a `DisplayRequest` with text set to `continue_processing` will exit the enabled service state and let the terminal proceed with PIN dialog if appropriate.

{:.code-view-header}
**Proceed with PIN dialog if appropriate**

```mermaid
sequenceDiagram
participant POS
participant Terminal
POS->>Terminal: CardAcquisitionRequest
Terminal->>POS: CardAcquisitionResponse Success
Note left of Terminal: Terminal shows "Please wait"
POS->>Terminal: DisplayRequest "continue_processing"
alt Contactless 
Note left of Terminal: Terminal shows "Awaiting amount"
else Chip inserted
Note left of Terminal: Terminal shows "Enter PIN"
end
```
