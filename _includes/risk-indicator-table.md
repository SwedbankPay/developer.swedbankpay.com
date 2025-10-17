{%- capture features_url -%}{%- include utils/documentation-section-url.md href='/features' -%}{%- endcapture -%}
{%- capture documentation_section -%}{%- include utils/documentation-section.md -%}{%- endcapture -%}
{%- capture 3ds2link -%}{%- include utils/documentation-section-url.md href="/features/customize-payments/frictionless-payments" -%}{%- endcapture -%}

<div class="api-compact" aria-label="Request">
  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f riskIndicator %}<span class="chev" aria-hidden="true">▸</span></span>
      <span class="type"><code>array</code></span>
    </summary>
    <div class="desc"><div class="indent-0">This **optional** object consist of information that helps verifying the payer. Providing these fields decreases the likelihood of having to prompt for 3-D Secure 2.0 authentication of the payer when they are authenticating the purchase.</div></div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f deliveryEmailAdress, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">For electronic delivery, the email address to which the merchandise was delivered. Providing this field when appropriate decreases the likelihood of a 3-D Secure authentication for the payer.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f deliveryTimeFrameIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates the merchandise delivery timeframe. <br>`01` (Electronic Delivery) <br>`02` (Same day shipping) <br>`03` (Overnight shipping) <br>`04` (Two-day or more shipping)</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f preOrderDate, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">For a pre-ordered purchase. The expected date that the merchandise will be available. Format: `YYYYMMDD`</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f preOrderPurchaseIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates whether the payer is placing an order for merchandise with a future availability or release date. <br>`01` (Merchandise available) <br>`02` (Future availability)</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f shipIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates shipping method chosen for the transaction. <br>`01` (Ship to cardholder's billing address) <br>`02` (Ship to another verified address on file with merchant)<br>`03` (Ship to address that is different than cardholder's billing address)<br>`04` (Ship to Store / Pick-up at local store. Store address shall be populated in shipping address fields)<br>`05` (Digital goods, includes online services, electronic giftcards and redemption codes) <br>`06` (Travel and Event tickets, not shipped) <br>`07` (Other, e.g. gaming, digital service)</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f giftCardPurchase, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>bool</code></span>
        </summary>
        <div class="desc"><div class="indent-1">`true` if this is a purchase of a gift card.</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f reOrderPurchaseIndicator, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">Indicates whether the cardholder is reordering previously purchased merchandise. <br>`01` (First time ordered) <br>`02` (Reordered).</div></div>
      </details>

      <details class="api-item" data-level="1">
        <summary>
          <span class="field">{% f pickUpAddress %}<span class="chev" aria-hidden="true">▸</span></span>
          <span class="type"><code>object</code></span>
        </summary>
        <div class="desc"><div class="indent-1">If `shipIndicator` set to `04`, then prefill this with the payers `pickUpAddress` of the purchase to decrease the risk factor of the purchase.</div></div>
        <div class="api-children">
          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f name, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `name` of the purchase to decrease the risk factor of the purchase.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f streetAddress, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `streetAddress` of the purchase to decrease the risk factor of the purchase. Maximum 50 characters long.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f coAddress, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `coAddress` of the purchase to decrease the risk factor of the purchase.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f city, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `city` of the purchase to decrease the risk factor of the purchase.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f zipCode, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `zipCode` of the purchase to decrease the risk factor of the purchase.</div></div>
          </details>

          <details class="api-item" data-level="2">
            <summary>
              <span class="field">{% f countryCode, 2 %}<span class="chev" aria-hidden="true">▸</span></span>
              <span class="type"><code>string</code></span>
            </summary>
            <div class="desc"><div class="indent-2">If `shipIndicator` set to `04`, then prefill this with the payers `countryCode` of the purchase to decrease the risk factor of the purchase.</div></div>
          </details>
        </div>
      </details>
    </div>
  </details>
</div>
