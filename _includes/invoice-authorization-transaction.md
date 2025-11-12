## Create Invoice Authorization Transaction

The `redirect-authorization` operation redirects the payer to Swedbank Pay
Payments where the payment is authorized.

{% capture request_header %}POST /psp/invoice/payments/{{ page.payment_id }}/authorizations HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% capture request_content %}{
    "transaction": {
        "activity": "FinancingConsumer"
    },
    "consumer": {
        "socialSecurityNumber": "{{ page.consumer_ssn_no }}",
        "customerNumber": "123456",
        "email": "olivia.nyhuus@swedbankpay.com",
        "msisdn": "+4798765432",
        "ip": "127.0.0.1"
    },
    "legalAddress": {
        "addressee": "Olivia Nyhuus",
        "streetAddress": "SaltnesToppen 43",
        "zipCode": "1642",
        "city": "Saltnes",
        "countryCode": "no"
    },
    "billingAddress": {
        "addressee": "Olivia Nyhuus",
        "streetAddress": "SaltnesToppen 43",
        "zipCode": "1642",
        "city": "Saltnes",
        "countryCode": "no"
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

  <!-- Level 0 (all nodes CLOSED by default; original order retained) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f transaction, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
      <span class="req">{% icon check %}</span>
    </summary>
    <div class="desc"><div class="indent-0">The transaction object.</div></div>

    <div class="api-children">
      <!-- activity -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f activity %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">Only the value <code>"FinancingConsumer"</code> or <code>"AccountsReceivableConsumer"</code>.</div></div>
      </details>

      <!-- consumer (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f consumer %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The payer object.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f socialSecurityNumber %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The social security number of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f customerNumber %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">Customer number of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f email %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The customer email address.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f msisdn %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The MSISDN of the payer.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f ip %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The IP address of the payer.</div></div>
          </details>
        </div>
      </details>

      <!-- legalAddress (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f legalAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The Address object.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f addressee %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The full name of the addressee of this invoice</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f coAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The co Address of the addressee.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f streetAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The street address of the addresse. Maximum 50 characters long.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f zipCode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The zip code of the addresse.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f city %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The city name  of the addresse.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f countryCode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The country code of the addresse.</div></div>
          </details>
        </div>
      </details>

      <!-- billingAddress (object) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f billingAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>object</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1">The BillingAddress object for the billing address of the addresse.</div></div>

        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f addressee %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The full name of the billing address adressee.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f coAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The co address of the billing address adressee.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f streetAddress %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The street address of the billing address adressee. Maximum 50 characters long.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f zipCode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The zip code of the billing address adressee.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f city %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The city name of the billing address adressee.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f countryCode %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
              <span class="type"><code>string</code></span>
              <span class="req"></span>
            </summary>
            <div class="desc"><div class="indent-2">The country code of the billing address adressee.</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>

## Invoice Authorization Response

{% capture response_content %}{
    "payment": "/psp/invoice/payments/{{ page.payment_id }}",
    "authorization": {
        "id": "/psp/invoice/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id }}",
        "consumer": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/consumer"
        },
        "legalAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/legaladdress"
        },
        "billingAddress": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/billingaddress"
        },
        "transaction": {
            "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
            "created": "2016-09-14T01:01:01.01Z",
            "updated": "2016-09-14T01:01:01.03Z",
            "type": "Authorization",
            "state": "Failed",
            "number": 1234567890,
            "amount": 1000,
            "vatAmount": 250,
            "description": "Test transaction",
            "payeeReference": "AH123456",
            "failedReason": "ExternalResponseError",
            "failedActivityName": "Authorize",
            "failedErrorCode": "ThirdPartyErrorCode",
            "failedErrorDescription": "ThirdPartyErrorMessage",
            "isOperational": "TRUE",
            "activities": {
                "id": "/psp/invoice/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}/activities"
            },
            "operations": [
                {
                    "href": "{{ page.api_url }}/psp/invoice/payments/{{ page.payment_id }}",
                    "rel": "edit-authorization",
                    "method": "PATCH"
                }
            ]
        }
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

<!-- Captures for markdown-includes -->
{%- capture payment_id_sub_md -%}{% include fields/id.md sub_resource="authorization" %}{%- endcapture -%}
{%- capture auth_id_md -%}{% include fields/id.md resource="authorization" %}{%- endcapture -%}
{%- capture number_md -%}{% include fields/number.md %}{%- endcapture -%}
{%- capture amount_md -%}{% include fields/amount.md %}{%- endcapture -%}
{%- capture vat_amount_md -%}{% include fields/vat-amount.md %}{%- endcapture -%}
{%- capture description_md -%}{% include fields/description.md %}{%- endcapture -%}
{%- capture payee_reference_md -%}{% include fields/payee-reference.md describe_receipt=true %}{%- endcapture -%}
{%- capture operations_md -%}{% include fields/operations.md resource="transaction" %}{%- endcapture -%}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <!-- Level 0 (original order; all nodes CLOSED by default) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f payment, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc"><div class="indent-0">{{ payment_id_sub_md | markdownify }}</div></div>
  </details>

  <!-- authorization (object) -->
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f authorization, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc"><div class="indent-0">The transaction object.</div></div>

    <div class="api-children">
      <!-- Level 1 children of authorization (exact markdown order) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f id %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ auth_id_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f created %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date and time of when the transaction was created. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f updated %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>date(string)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The ISO 8601 date and time of when the transaction was updated. Written in the format YYYY-MM-DDTHH:MM:SSZ, where Z indicates UTC.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f type %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates the transaction type.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f state %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>Initialized</code>, <code>Completed</code> or <code>Failed</code>. Indicates the state of the transaction.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f number %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ number_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f amount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f vatAmount %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>integer</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ vat_amount_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f description %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ description_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f payeeReference %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string(30)</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ payee_reference_md | markdownify }}</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f failedReason %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">The human readable explanation of why the payment failed.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f isOperational %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>true</code> if the transaction is operational; otherwise <code>false</code>.</div></div>
      </details>

      <!-- operations (array) -->
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f operations %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
          <span class="type"><code>array</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ operations_md | markdownify }}</div></div>
      </details>
    </div>
  </details>
</div>

The `authorization` resource contains information about an authorization
transaction made towards a payment, as previously described.
