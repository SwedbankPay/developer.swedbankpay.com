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

<div class="api-compact" aria-label="Capture Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- LEVEL 0: transaction -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field"><code>transaction</code><i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">{% include fields/transaction.md %}</div></div>

    <!-- LEVEL 1: children of transaction -->
    <div class="api-children">

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Amount is entered in the lowest monetary units of the selected currency.
            E.g. <code>10000</code> = 100.00 NOK, <code>5000</code> = 50.00 SEK.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            Amount is entered in the lowest monetary units of the selected currency.
            E.g. <code>10000</code> = 100.00 NOK, <code>5000</code> = 50.00 SEK.
          </div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">A textual description of the capture transaction.</div>
        </div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(30)</code></span>
          <span class="req">{% icon check %}</span>
        </summary>
        <div class="desc">
          <div class="indent-1">{% include fields/payee-reference.md documentation_section=include.documentation_section %}</div>
        </div>
      </details>

    </div>
  </details>
</div>


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

<div class="api-compact" aria-label="Capture Response">
  <div class="header">
    <div>Property</div>
    <div>Type</div>
  </div>

  <!-- LEVEL 0: payment -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The relative URL of the payment this <code>capture</code> transaction belongs to.</div></div>
  </details>

  <!-- LEVEL 0: capture -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f capture, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The <code>capture</code> resource contains information about the <code>capture</code> transaction made against a card payment.</div></div>

    <!-- LEVEL 1: children of capture -->
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The relative URL of the created <code>capture</code> transaction.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f transaction %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{% include fields/transaction.md %}</div></div>

        <!-- LEVEL 2: children of transaction -->
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The relative URL of the current <code>transaction</code> resource.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f created, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>date(string)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a> date and time when the transaction was created.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f updated, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>date(string)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a> date and time when the transaction was updated.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the transaction type.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f state, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/state.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/number.md %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                Amount is entered in the lowest monetary units of the selected currency.
                E.g. <code>10000</code> = 100.00 NOK, <code>5000</code> = 50.00 SEK.
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">
                If the amount given includes VAT, this may be displayed for the user in the payment page (redirect only).
                Set to <code>0</code> (zero) if this is not relevant.
              </div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc">
              <div class="indent-2">A human readable description of maximum 40 characters of the transaction.</div>
            </div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/payee-reference.md documentation_section=include.documentation_section %}</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f failedReason, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable explanation of why the payment failed.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f isOperational, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>boolean</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>true</code> if the transaction is operational; otherwise <code>false</code>.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f operations, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
            </summary>
            <div class="desc"><div class="indent-2">{% include fields/operations.md resource="transaction" %}</div></div>
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
