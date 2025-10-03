## Items

The `items` field of the `paymentOrder` is an `array` containing items that will
affect how the payment is performed.

{% include alert.html type="warning" icon="warning" header="MobilePay"
body="Please note that by adding the `shoplogoUrl` field, the default logo-url configured during contract setup will be overridden for this transaction. If logo-url is missing in the contract setup, it must be provided as an input parameter." %}

<div class="api-compact" role="table" aria-label="Request">
  <div class="header" role="row">
    <div role="columnheader">Field</div>
    <div role="columnheader">Type</div>
    <div role="columnheader">Required</div>
  </div>

  <!-- Level 0 (original order; all nodes CLOSED by default) -->

  <!-- creditCard (object) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f creditCard, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req"></span>
    </summary>
    <div class="desc"><div class="indent-0">The card object.</div></div>

    <div class="api-children">
      <!-- children of creditCard (level 1) -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f rejectDebitCards %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>true</code> if debit cards should be declined; otherwise <code>false</code> per default. Default value is set by Swedbank Pay and can be changed at your request.</div></div>
      </details>

      <!-- duplicate row preserved per source markdown -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f rejectDebitCards %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>true</code> if debit cards should be declined; otherwise <code>false</code> per default. Default value is set by Swedbank Pay and can be changed at your request.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f rejectCreditCards %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>true</code> if credit cards should be declined; otherwise <code>false</code> per default. Default value is set by Swedbank Pay and can be changed at your request.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f rejectConsumerCards %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>true</code> if consumer cards should be declined; otherwise <code>false</code> per default. Default value is set by Swedbank Pay and can be changed at your request.</div></div>
      </details>

      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f rejectCorporateCards %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>true</code> if corporate cards should be declined; otherwise <code>false</code> per default. Default value is set by Swedbank Pay and can be changed at your request.</div></div>
      </details>
    </div>
  </details>

  <!-- swish (object) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f swish, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req"></span>
    </summary>
    <div class="desc"><div class="indent-0">The Swish object.</div></div>

    <div class="api-children">
      <!-- child of swish -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f enableEcomOnly %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc"><div class="indent-1"><code>true</code> to enable Swish in e-commerce view only.</div></div>
      </details>
    </div>
  </details>

  <!-- mobilePay (object) -->
  <details class="api-item" role="rowgroup" data-level="0">
    <summary role="row">
      <span class="field" role="rowheader">{% f mobilePay, 0 %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>object</code></span>
      <span class="req"></span>
    </summary>
    <div class="desc"><div class="indent-0">The MobilePay object.</div></div>

    <div class="api-children">
      <!-- child of mobilePay -->
      <details class="api-item" role="rowgroup" data-level="1">
        <summary role="row">
          <span class="field" role="rowheader">{% f shoplogoUrl %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
          <span class="req"></span>
        </summary>
        <div class="desc">
          <div class="indent-1">
            URI to the logo that will be visible at MobilePay Online. For it to be displayed correctly in the MobilePay app, the image must be 250x250 pixels, a png or jpg served over a secure connection using https, and be publicly available.
            This URI will override the value configured in the contract setup.
          </div>
        </div>
      </details>
    </div>
  </details>
</div>
