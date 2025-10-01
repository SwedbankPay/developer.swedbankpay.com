## Capture

The capture transaction is where you ensure that the funds are charged from
the payer. This step usually takes place when the product has exchanged
possession. You must first do a `GET` request on the payment to find the
`create-capture` operation.

Please note that you have a maximum of 5 **consecutive** failed attempts at a
capture. The payment will be locked after this, and you need to contact us for
another attempt.

## Create Capture Transaction

To create a `capture` transaction to withdraw money from the payer's card, you
need to perform the `create-capture` operation.

## Capture Request

{% capture request_header %}POST /psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "amount": 1500,
        "vatAmount": 250,
        "description": "Test Capture",
        "payeeReference": "ABC123"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{:.table .table-striped}
|     Required     | Field                    | Type          | Description                                                                                                   |
| :--------------: | :----------------------- | :------------ | :------------------------------------------------------------------------------------------------------------ |
| {% icon check %} | `transaction`            | `object`      | {% include fields/transaction.md %}                        |
| {% icon check %} | {% f amount %}         | `integer`     | Amount Entered in the lowest momentary units of the selected currency. E.g. 10000 100.00 NOK, 5000 50.00 SEK. |
| {% icon check %} | {% f vatAmount %}      | `integer`     | Amount Entered in the lowest momentary units of the selected currency. E.g. 10000 100.00 NOK, 5000 50.00 SEK. |
| {% icon check %} | {% f description %}    | `string`      | A textual description of the capture transaction.                                                             |
| {% icon check %} | {% f payeeReference %} | `string(30)` | {% include fields/payee-reference.md documentation_section=include.documentation_section %}                               |

## Capture Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/{{ include.api_resource }}/payments/{{ page.payment_id }}",
    "capture": {
        "id": "/psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/captures/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Capture",
            "state": "Completed",
            "number": 1234567890,
            "amount": 1500,
            "vatAmount": 250,
            "description": "Test Capture",
            "payeeReference": "ABC123",
            "isOperational": false,
            "operations": []
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

<div class="api-compact" role="table" aria-label="Capture – Resource">
  <div class="header" role="row">
    <div role="columnheader">Property</div>
    <div role="columnheader">Type</div>
  </div>

  <!-- LEVEL 0: payment -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f payment, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-1">The relative URL of the payment this <code>capture</code> transaction belongs to.</div></div>
  </details>

  <!-- LEVEL 0: capture -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f capture, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-1">The <code>capture</code> resource contains information about the <code>capture</code> transaction made against a card payment.</div></div>

    <!-- LEVEL 1: children of capture -->
    <div class="api-children">
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f id %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-2">The relative URL of the created <code>capture</code> transaction.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f transaction %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-2">{% include fields/transaction.md %}</div></div>

        <!-- LEVEL 2: children of transaction -->
        <div class="api-children">
          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f id, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-3">The relative URL of the current <code>transaction</code> resource.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f created, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-3">The ISO-8601 date and time of when the transaction was created.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f updated, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-3">The ISO-8601 date and time of when the transaction was updated.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f type, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-3">Indicates the transaction type.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f state, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-3">{% include fields/state.md %}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f number, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-3">{% include fields/number.md %}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f amount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc">
              <div class="indent-3">
                Amount is entered in the lowest monetary units of the selected currency.
                E.g. <code>10000</code> = 100.00 NOK, <code>5000</code> = 50.00 SEK.
              </div>
            </div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f vatAmount, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc">
              <div class="indent-3">
                If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only).
                Set to <code>0</code> (zero) if this is not relevant.
              </div>
            </div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f description, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc">
              <div class="indent-3">A human readable description of maximum 40 characters of the transaction.</div>
            </div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f payeeReference, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-3">{% include fields/payee-reference.md documentation_section=include.documentation_section %}</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f failedReason, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-3">The human readable explanation of why the payment failed.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f isOperational, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>boolean</code></span>
            </summary>
            <div class="desc"><div class="indent-3"><code>true</code> if the transaction is operational; otherwise <code>false</code>.</div></div>
          </details>

          <details class="api-item" role="rowgroup" data-level="2">
            <summary role="row">
              <span class="field" role="rowheader">{% f operations, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>array</code></span>
            </summary>
            <div class="desc"><div class="indent-3">{% include fields/operations.md resource="transaction" %}</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## List Capture Transactions

The `captures` resource list the capture transactions (one or more) on a
specific payment.

{% capture request_header %}GET /psp/{{ include.api_resource }}/payments/{{ page.payment_id }}/captures HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% include transaction-list-response.md api_resource=include.api_resource documentation_section=include.documentation_section transaction="capture" %}

## Capture Sequence Diagram

`Capture` can only be done on an authorized transaction. It is possible to do a
partial capture where you only capture a part of the authorized amount. You can
do more captures on the same payment up to the total authorization amount later.

```mermaid
sequenceDiagram
  activate Merchant
  Merchant->>-SwedbankPay: POST [{{ include.api_resource }} captures]
  activate SwedbankPay
  SwedbankPay-->>-Merchant: transaction resource
```
