---
title: After Payment
permalink: /:path/after-payment/
redirect_from: /payments/card/after-payment
description: |
  Apart from capturing the authorized funds, there are still a couple of options
  available to you after a payment. Authorizations can cancelled, captures can
  be both partially and fully reversed. Read more about the options here.
menu_order: 900
---

## Options After Posting A Payment

When you detect that the payer reach your `completeUrl` , you need to do a `GET`
request on the payment resource, containing the `paymentID` generated in the
first step, to receive the state of the transaction. You will also be able to
see the available operations after posting a payment.

*   *Abort:* It is possible to abort the process if the payment has no successful
  transactions. See the [`Abort` description here][abort].
*   If the payment shown above is done as a two phase (`Authorization`), you will
  need to implement the `Capture` and `Cancel` requests.
*   For `reversals`, you will need to implement the [Reversal request][reversal].
*   If `CallbackURL` is set: Whenever changes to the payment occur a [Callback
  request][callback] will be posted to the `callbackUrl`, which was generated
  when the payment was created.

## Cancellations

`Cancel` can only be done on a authorized transaction. If you do cancel after
doing a part-capture you will cancel the difference between the capture amount
and the authorization amount.

## Cancel Request

{% capture request_header %}POST /psp/creditcard/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "description": "Test Cancellation",
        "payeeReference": "ABC123"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{:.table .table-striped}
|     Required     | Field                    | Type          | Description                                                                              |
| :--------------: | :----------------------- | :------------ | :--------------------------------------------------------------------------------------- |
| {% icon check %} | `transaction`            | `object`      | The `object` representation of the generic [transaction resource][transaction-resource]. |
| {% icon check %} | {% f description %}    | `string`      | A textual description of the reason for the `cancellation`.                              |
| {% icon check %} | {% f payeeReference %} | `string(50)` | {% include fields/payee-reference.md %}          |

## Cancel Response

The `cancel` resource contains information about a cancellation transaction
made against a payment.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "cancellation": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/cancellations/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Cancellation",
            "state": "Initialized",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test Cancellation",
            "payeeReference": "ABC123",
            "failedReason": "",
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

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- payment (root sibling) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The relative URL of the payment this <code>cancellation</code> transaction belongs to.</div></div>
  </details>

  <!-- cancellation (root with children) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f cancellation, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The <code>cancellation</code> resource contains information about the <code>cancellation</code> transaction made against a card payment.</div></div>

    <div class="api-children">
      <!-- cancellation.id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The relative URL of the created <code>cancellation</code> transaction.</div></div>
      </details>

      <!-- transaction (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f transaction %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        {% capture transaction_md %}{% include fields/transaction.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ transaction_md | markdownify }}</div></div>

        <div class="api-children">
          <!-- transaction.id -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The relative URL of the current  transaction  resource.</div></div>
          </details>

          <!-- created -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f created, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>date(string)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the transaction was created.</div></div>
          </details>

          <!-- updated -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f updated, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>date(string)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the transaction was updated.</div></div>
          </details>

          <!-- type -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the transaction type.</div></div>
          </details>

          <!-- state -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f state, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Initialized ,  Completed  or  Failed . Indicates the state of the transaction</div></div>
          </details>

          <!-- number -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            {% capture number_md %}{% include fields/number.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <!-- amount -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            {% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
          </details>

          <!-- vatAmount -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            {% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
          </details>

          <!-- description -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture description_md %}{% include fields/description.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ description_md | markdownify }}</div></div>
          </details>

          <!-- payeeReference -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            {% capture payee_reference_md %}{% include fields/payee-reference.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>

          <!-- isOperational -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f isOperational, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>boolean</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>true</code>  if the transaction is operational; otherwise  <code>false</code> .</div></div>
          </details>

          <!-- operations -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f operations, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
            </summary>
            {% capture operations_md %}{% include fields/operations.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ operations_md | markdownify }}</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## List Cancel Transactions

The `cancellations` resource lists the cancellation transactions on a specific
payment.

{% capture request_header %}GET /psp/creditcard/payments/{{ page.payment_id }}/cancellations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% include transaction-list-response.md transaction="cancellation" %}

## Cancel Sequence Diagram

```mermaid
sequenceDiagram
  activate Merchant
  Merchant->>-SwedbankPay: POST [creditcard cancellactions]
  activate SwedbankPay
  SwedbankPay-->>-Merchant: transaction resource
```

## Reversals

This transaction is used when a captured payment needs to be reversed.

## Reversal Request

{% capture request_header %}POST /psp/creditcard/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "amount": 1500,
        "vatAmount": 0,
        "description": "Test Reversal",
        "payeeReference": "ABC123"
    }
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

<div class="api-compact" aria-label="Request">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Required</div>
  </div>

  <!-- transaction -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f transaction, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The <code>object</code> representation of the generic transaction resource</a>.</div></div>

    <div class="api-children">
        <!-- amount -->
        <details class="api-item" data-level="1">
            <summary>
                <span class="field">{% f amount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                <span class="type"><code>integer</code></span>
                <span class="req">{% icon check %}</span>
            </summary>
            {% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
        </details>

        <!-- vatAmount -->
        <details class="api-item" data-level="1">
            <summary>
                <span class="field">{% f vatAmount, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                <span class="type"><code>integer</code></span>
                <span class="req">{% icon check %}</span>
            </summary>
            {% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
        </details>

        <!-- description -->
        <details class="api-item" data-level="1">
            <summary>
                <span class="field">{% f description, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                <span class="type"><code>string</code></span>
                <span class="req">{% icon check %}</span>
            </summary>
            <div class="desc"><div class="indent-1">A textual description of the <code>reversal</code>.</div></div>
        </details>

        <!-- payeeReference -->
        <details class="api-item" data-level="1">
            <summary>
                <span class="field">{% f payeeReference, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
                <span class="type"><code>string(50)</code></span>
                <span class="req">{% icon check %}</span>
            </summary>
            {% capture payee_reference_md %}{% include fields/payee-reference.md %}{% endcapture %}
            <div class="desc"><div class="indent-1">{{ payee_reference_md | markdownify }}</div></div>
        </details>
      </div>
  </details>
</div>

## Reversal Response

The `reversal` resource contains information about the newly created reversal
transaction.

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "reversal": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/reversal/{{ page.transaction_id }}",
        "transaction": {
            "id": "/psp/creditcard/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Reversal",
            "state": "Completed",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "failedReason": "",
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

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- payment (root sibling) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The relative URL of the payment this <code>reversal</code> transaction belongs to.</div></div>
  </details>

  <!-- reversal (root with children) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f reversal, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The <code>reversal</code> resource contains information about the <code>reversal</code> transaction made against a card payment.</div></div>

    <div class="api-children">
      <!-- reversal.id -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The relative URL of the created <code>reversal</code>transaction.</div></div>
      </details>

      <!-- transaction (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f transaction %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
        </summary>
        {% capture transaction_md %}{% include fields/transaction.md %}{% endcapture %}
        <div class="desc"><div class="indent-1">{{ transaction_md | markdownify }}</div></div>

        <div class="api-children">
          <!-- transaction.id -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f id, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The relative URL of the current  transaction  resource.</div></div>
          </details>

          <!-- created -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f created, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>date(string)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the transaction was created.</div></div>
          </details>

          <!-- updated -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f updated, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>date(string)</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>{:target="_blank"} date and time when the transaction was updated.</div></div>
          </details>

          <!-- type -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f type, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">Indicates the transaction type.</div></div>
          </details>

          <!-- state -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f state, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture state_md %}{% include fields/state.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ state_md | markdownify }}</div></div>
          </details>

          <!-- number -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f number, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture number_md %}{% include fields/number.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ number_md | markdownify }}</div></div>
          </details>

          <!-- amount -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f amount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            {% capture amount_md %}{% include fields/amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ amount_md | markdownify }}</div></div>
          </details>

          <!-- vatAmount -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f vatAmount, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>integer</code></span>
            </summary>
            {% capture vat_amount_md %}{% include fields/vat-amount.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ vat_amount_md | markdownify }}</div></div>
          </details>

          <!-- description -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f description, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            {% capture description_md %}{% include fields/description.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ description_md | markdownify }}</div></div>
          </details>

          <!-- payeeReference -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f payeeReference, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string(30)</code></span>
            </summary>
            {% capture payee_reference_md %}{% include fields/payee-reference.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ payee_reference_md | markdownify }}</div></div>
          </details>

          <!-- failedReason -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f failedReason, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">The human readable explanation of why the payment failed.</div></div>
          </details>

          <!-- isOperational -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f isOperational, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>boolean</code></span>
            </summary>
            <div class="desc"><div class="indent-2"><code>true</code>  if the transaction is operational; otherwise  <code>false</code> .</div></div>
          </details>

          <!-- operations -->
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f operations, 2 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>array</code></span>
            </summary>
            {% capture operations_md %}{% include fields/operations.md %}{% endcapture %}
            <div class="desc"><div class="indent-2">{{ operations_md | markdownify }}</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## List Reversal Transactions

The `reversals` resource lists the reversal transactions (one or more) on a
specific payment.

{% capture request_header %}GET /psp/creditcard/payments/{{ page.payment_id }}/reversals HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    %}

{% include transaction-list-response.md transaction="reversal" %}

## Reversal Sequence Diagram

```mermaid
sequenceDiagram
  activate Merchant
  Merchant->>-SwedbankPay: POST [creditcard reversals]
  activate SwedbankPay
  SwedbankPay-->>-Merchant: transaction resource
```

{% include abort-reference.md %}

## Remove Payment Token

If you, for any reason, need to delete a paymentToken you use the
`Delete payment token` request.

{% include alert.html type="warning"
                      icon="warning"
                      body="Please note that this call does not erase the card number stored at Swedbank
  Pay. A card number is automatically deleted six months after a successful
  `Delete payment token` request. If you want to remove card information
  beforehand, you need to contact
  [ehandelsetup@swedbankpay.dk](mailto:ehandelsetup@swedbankpay.dk),
  [verkkokauppa.setup@swedbankpay.fi](mailto:verkkokauppa.setup@swedbankpay.fi),
  [ehandelsetup@swedbankpay.no](mailto:ehandelsetup@swedbankpay.no) or
  [ehandelsetup@swedbankpay.se](mailto:ehandelsetup@swedbankpay.se); and supply
  them with the relevant transaction reference or payment token." %}

## Delete Token Request

{% capture request_header %}PATCH /psp/creditcard/payments/instrumentData/{{ page.payment_token }} HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
  "state": "Deleted",
  "tokenType" : "PaymentToken",
  "comment": "Comment on why the deletion is happening"
}{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

## Delete Token Response

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "instrumentData": {
        "id": "/psp/creditcard/payments/instrumentdata/{{ page.payment_token }}",
        "paymentToken": "{{ page.payment_token }}",
        "payeeId": "{{ page.merchant_id }}",
        "isDeleted": true,
        "isPayeeToken": false,
        "cardBrand": "MasterCard",
        "maskedPan": "123456xxxxxx1111",
        "expiryDate": "MM/YYYY"
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% include iterator.html prev_href="/old-implementations/payment-instruments-v1/card/mobile-card-payments" prev_title="Mobile Card Payments"
next_href="/old-implementations/payment-instruments-v1/card/features" next_title="Features" %}

[abort]: /old-implementations/payment-instruments-v1/card/after-payment#abort
[callback]: /old-implementations/payment-instruments-v1/card/features/core/callback
[reversal]: /old-implementations/payment-instruments-v1/card/features/core/reversal
[transaction-resource]: /old-implementations/payment-instruments-v1/card/technical-reference/transactions
