<!-- Captures for tables -->
{%- capture id_md -%}{% include fields/id.md resource="paymentOrder" %}{%- endcapture -%}
<!-- Captures for tables -->

{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

{% if api_resource == "paymentorders" %}
    {% assign product="Payment Menu" %}
{% else %}
    {% assign product="Seamless View" %}
{% endif %}

## {{ product }} Commands

During operation in the {{ product }}, you have several options on interacting
with the client script, as described below.

## Initialization / Configuration

After placing the client script onto your website, you can start to use the
commands to load in the payment UI, but before you can open up the UI you need
to configure it.
This involves giving the payment UI a place to load in the iFrame.
Provide the location where we can embed our iFrame INSIDE OF, by adding the
ID as the "container" in the object. See the example below.

{:.code-view-header}
**Configuring the UI**

```js
payex.hostedView.checkout({
    container: "string",
    culture: "string",
    style: { "object" },
    theme: "string",
    integration: "string"
});
```

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f container, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Required: The ID of the DOM element you want to embed the Payment UI
        inside of.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f culture, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Locale identifier string for the language the Payment UI should launch
        with.
        Examples includes: sv-SE, nb-NO and en-US
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f style, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Key/Value object with the details of the colors and borders you want for
        the various components of the payment button.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f theme, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Used to define which style set the Payment UI should use.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f integration, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Specify the integration used for the UI. Values include "HostedView",
        "Redirect" and "App".
      </div>
    </div>
  </details>
</div>

If you want more details about how to style the Payment UI, check out our
section on the [Custom Styling][custom-styling] (only for merchants with a
special agreement with us).

## Open

This command is used to open up the Payment UI inside of the specified
container.

{:.code-view-header}
**Opening the Checkout UI**

```javascript
payex.hostedView.checkout().open();
```

Take care not to run this command multiple times, as this will open up multiple
payment windows at the same time.

## Update

Allows you to update the language and/or the style of the Payment UI.

{:.code-view-header}
**Changing the configuration after initialization**

```javascript
payex.hostedView.checkout().update({
    culture: "string",
    style: { "object" },
    theme: "string"
});
```

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f culture, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Locale identifier string for the language the Payment UI should launch
        with.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f style, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Key/Value object with the details of the colors and borders you want for
        the various components of the payment button.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f theme, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Deprecated: Used to define which style set the Payment UI should use.
      </div>
    </div>
  </details>
</div>

If you want more details about how to style the Payment UI, check out our
section on the [Custom Styling][custom-styling] (only for merchants with a
special agreement with us).

## Refresh

Used to refresh the UI in case you have updated the Payment, like
adding / removing items from the `OrderItems` section, or updating the total
cost of the purchase.

{:.code-view-header}
**Refreshing the UI after updating the payment**

```javascript
payex.hostedView.checkout().refresh();
```

## Close

Used to close the Payment UI. This removes the iFrame, but not the script,
allowing you to `open()` it up again if you need to.

{:.code-view-header}
**Closing the Checkout UI**

```javascript
payex.hostedView.checkout().close();
```

## Cancel

Used to cancel the payment. Equivalent to pressing the `cancel` link in
`Redirect` mode.

{:.code-view-header}
**Canceling the payment with the client script**

```javascript
payex.hostedView.checkout().cancel();
```

## Resume

Allows you to resume the payment flow in cases where you have subscribed to the
`onPaymentButtonPressed` function. If you do, you HAVE to send the `resume`
command to be able to finish the payment flow.

If you do not run the command with valid input before `2 minutes` has passed,
`resume` will be called automatically with the `confirmation` value of `false`.

{:.code-view-header}
**Resuming the payment with a onPaymentButtonPressed flow**

```javascript
payex.hostedView.checkout().resume({
    paymentOrderId: "string",
    confirmation: true
});
```

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrderId, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        The PaymentOrderId of the purchase you want to resume.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f confirmation, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        Boolean value that determines if the payment should continue or if you
        want to stop the payment flow due to validation issues or otherwise.
      </div>
    </div>
  </details>
</div>

[custom-styling]: /checkout-v3/features/customize-ui/custom-styling
