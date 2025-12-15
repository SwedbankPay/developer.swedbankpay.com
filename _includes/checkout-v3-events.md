<!-- Captures for tables -->
{%- capture id_md -%}{% include fields/id.md resource="paymentOrder" %}{%- endcapture -%}
<!-- Captures for tables -->

{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

{% if api_resource == "paymentorders" %}
    {% assign product="Payment Menu" %}
{% else %}
    {% assign product="Seamless View" %}
{% endif %}

## {{ product }} Events

During operation in the {{ product }}, several events can occur. They are
described below.

{% include alert.html type="warning" icon="info" header="Event Overrides"
body="When you add an event handler to any of these events, you are
**overriding** the original event. This means you can't simply add an event
for logging purposes. You have to either add back the original behavior, or
replace it with your own custom logic. If you do not do this, you may risk
undefined behavior or, at worst, a broken payment flow." %}

## onAborted

{% include events/on-aborted.md %}

This event mirrors `onPaymentCanceled` from Checkout v2.

This event can be overridden if you want to handle the payer aborting their
payment attempt in the Swedbank Pay payment frame. Do note that only the
Redirect integration provides a cancel button. Using a Seamless integration,
you will have to provide your own button, link or method to allow the payer
to cancel the payment from your site.

If you do not override the event, the payer will be redirected to the
`cancelUrl` in the same tab if possible.

This is the object that is provided if you override the event:

{% capture response_content %}{
    "event": "OnAborted",
    "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
    "redirectUrl": "https://example.com/cancelled"
}{% endcapture %}

{% include code-example.html
    title='onAborted event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-1">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f redirectUrl, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The URL the user will be redirect to after a cancelled payment.
      </div>
    </div>
  </details>
</div>

## onCheckoutLoaded

{% include events/on-checkout-loaded.md %}

Subscribe to this event if you need total control over the height of Swedbank
Pay's payment frame. This is the initial height of the frame when loaded.

If no callback method is set, no handling action will be done. It will be raised
with the following event argument object:

{% capture response_content %}{
    "event": "OnCheckoutLoaded",
    "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
    "bodyHeight": 800
}{% endcapture %}

{% include code-example.html
    title='onCheckoutLoaded event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f bodyHeight, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The height of the client's iframe content.
      </div>
    </div>
  </details>
</div>

## onCheckoutResized

{% include events/on-checkout-resized.md %}

This event mirrors `onApplicationConfigured` from Checkout v2.

This event can be overridden if you need to know when the height of the Swedbank
Pay's payment frame. This will be the new height after a resizing is performed.
This event is triggered every time a resizing is needed.

If you do not override the event, no action will be done. This event is only
provided for informational purposes.

This is the object that is provided if you override the event:

{% capture response_content %}{
    "event": "OnCheckoutResized",
    "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
    "bodyHeight": 800
}{% endcapture %}

{% include code-example.html
    title='onCheckoutResized event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f bodyHeight, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The height of the client's iframe content.
      </div>
    </div>
  </details>
</div>

## onError

{% include events/on-error.md %}

This event can be overridden if you want the details if an error occurs during
the payment flow. This will be provided in a human readable format.

If you do not override the event, no action will be done. This event is only
provided for informational purposes.

This is the object that is provided if you override the event:

{% capture response_content %}{
    "event": "OnError",
    "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
    "details": "Some error"
}{% endcapture %}

{% include code-example.html
    title='onError event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f details, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        A human readable and descriptive text of the error.
      </div>
    </div>
  </details>
</div>

## onEventNotification

{% include events/on-event-notification.md %}

This event can be overridden if you want a better overview of the payment flow.
Whenever one of the events in the example below is triggered, a message with
the name of the event is provided.

If you do not override the event, no action will be done. This event is only
provided for informational purposes.

This is the object that is provided if you override the event:

 {% capture response_content %}{
     "event": "OnEventNotification",
     "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
     "sourceEvent": "OnPaid"
 }{% endcapture %}

{% include code-example.html
    title='onEventNotification event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f sourceEvent, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        A human readable and descriptive text with the event name.  <code>OnFailed</code> | <code>OnAborted</code> | <code>OnPaymentAttemptAborted</code> |
      <code>OnOutOfViewReidrect</code> | <code>OnTermsOfServiceRequested</code> | <code>OnCheckoutResized</code> |
      <code>OnCheckoutLoaded</code> | <code>OnConsumerGuestSelected</code> | <code>OnInstrumentSelected</code> |
      <code>OnError</code> | <code>OnPaymentAttemptStarted</code> | <code>OnPaymentAttemptFailed</code>
      </div>
    </div>
  </details>
</div>

## onInstrumentSelected

{% include events/on-instrument-selected.md %}

This event mirrors `onPaymentMenuInstrumentSelected` from Checkout v2.

This event can be overridden if you want to know when the payer selects a
payment method in the Swedbank Pay payment frame.

If you do not override the event, no action will be done. This event is only
provided for informational purposes.

This is the object that is provided if you override the event:

{% capture response_content %}{
    "event": "OnInstrumentSelected",
    "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
    "instrument": "creditcard"
}{% endcapture %}

{% include code-example.html
    title='onInstrumentSelected event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f instrument, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        <code>Creditcard</code>, <code>vipps</code>, <code>swish</code>, <code>invoice</code>. The payment method selected by the user.
      </div>
    </div>
  </details>
</div>

## onOutOfViewOpen

{% include events/on-out-of-view-open.md %}

This event can be overridden if you want to handle openeing a redirect intended
to be opened up in a new window or tab. This is ideal if you want to handle
this type of redirects yourself, such as opening up the link inside of a
modal.

If you do not override the event, we will attempt to open up the link in a new
tab or window, if possible.

This is the object that is provided if you override the event:

{% capture response_content %}{
    "event": "OnOutOfViewOpen",
    "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
    "openUrl": "https://example.com/external"
}{% endcapture %}

{% include code-example.html
    title='onOutOfViewOpen event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f openUrl, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The external URL where the user will be redirected.
      </div>
    </div>
  </details>
</div>

## onOutOfViewRedirect

{% include events/on-out-of-view-redirect.md %}

This event mirrors `onExternalRedirect` from Checkout v2.

This event can be overridden if you want to handle redirects to another page
yourself. This is ideal if you want to show any alerts or warnings before
passing the payer to the next page or if you want to show a status on your page
before redirecting.

If you do not override the event, the redirect will happen in the same tab if
possible.

This is the object that is provided if you override the event:

{% capture response_content %}{
    "event": "OnOutOfViewRedirect",
    "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
    "redirectUrl": "https://example.com/external"
}{% endcapture %}

{% include code-example.html
    title='onOutOfViewRedirect event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f redirectUrl, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The external URL where the user will be redirected.
      </div>
    </div>
  </details>
</div>

## onPaid

{% include events/on-paid.md %}

This event mirrors `onPaymentCompleted` from Checkout v2.

This event can be overridden if you want to handle redirects on completed
payments yourself, for example if you want to close the payment window to
display a receipt for the payment or want to handle closing the page first
before sending the payer to the `paymentComplete` url. If you do this, we
highly recommend you perform a `GET` on the payment to check the actual
payment status and act accordingly.

If you do not override the event, the redirect will happen in the same tab if
possible.

This is the object that is provided if you override the event:

{% capture response_content %}{
    "event": "OnPaid",
    "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
    "redirectUrl": "https://example.com/success"
}{% endcapture %}

{% include code-example.html
    title='onPaid event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f redirectUrl, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The URL the user will be redirected to after completing the payment.
      </div>
    </div>
  </details>
</div>

## onPaymentAttemptAborted

This event mirrors `onPaymentAborted` from Checkout v2.

This event can be overridden if you want a notification when the payer cancels
a payment attempt. This does not mean that the payer can't attempt another
payment, or switch to another payment method, just that they canceled one of
their attempts.

If you do not override the event, no action will be done. This event is only
provided for informational purposes.

This is the object that is provided if you override the event:

{% capture response_content %}{
    "event": "OnPaymentAttemptAborted",
    "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
    "redirectUrl": "https://example.com/cancelled"
}{% endcapture %}

{% include code-example.html
    title='onPaymentAttemptAborted event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f redirectUrl, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The URL the user will be redirected to after a cancelled payment.
      </div>
    </div>
  </details>
</div>

## onPaymentAttemptFailed

This event mirrors `onPaymentTransactionFailed` from Checkout v2.

This event can be overridden if you want a notification when a payment attempt
has failed. An error message will also appear in the payment UI, where the payer
can either try again or choose another payment method.

If you do not override the event, no action will be done. This event is only
provided for informational purposes.

This is the object that is provided if you override the event:

{% capture response_content %}{
    "event": "OnPaymentAttemptFailed",
    "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
    "details": "Some error"
}{% endcapture %}

{% include code-example.html
    title='onPaymentAttemptFailed event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Description</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f details, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        A human readable and descriptive text of the error.
      </div>
    </div>
  </details>
</div>

## onPaymentAttemptStarted

This event mirrors `onPaymentCreated` from Checkout v2.

This event can be overridden if you want a notification when a payment attempt
is started. It contains the name of the payment method started.

If you do not override the event, no action will be done. This event is only
provided for informational purposes.

This is the object that is provided if you override the event:

{% capture response_content %}{
    "event": "OnPaymentAttemptStarted",
    "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}" 
    },
    "instrument": "creditcard"
}{% endcapture %}

{% include code-example.html
    title='onPaymentAttemptStarted event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Description</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f instrument, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        <code>Creditcard</code>, <code>vipps</code>, <code>swish</code>, <code>invoice</code>. The payment method selected when initiating the payment.
      </div>
    </div>
  </details>
</div>

## onTermsOfServiceRequested

{% include events/on-terms-of-service-requested.md %}

This event mirrors `onPaymentToS` from Checkout v2.

This event can be ovrriden if you want to handle opening the `termsOfServiceUrl`
on your own. This could be if you want to open it inside of a modal, inside of
an iFrame on your own page or otherwise.

If you do not override the event, we will attempt to open up the
`termsOfServiceUrl` inside of a new tab in the same browser, if possible.

This is the object that is provided if you override the event:

 {% capture response_content %}{
     "event": "OnTermsOfServiceRequested",
     "paymentOrder": { 
        "id": "/psp/paymentorders/{{ page.payment_id }}"
     },
     "termsOfServiceUrl": "https://example.org/terms.html"
 }{% endcapture %}

{% include code-example.html
    title='onTermsOfServiceRequested event object'
    header=response_header
    json= response_content
    %}

<div class="api-compact" aria-label="Response">
  <div class="header">
    <div>Field</div>
    <div>Type</div>
    <div>Description</div>
  </div>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f event, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The name of the event raised.
      </div>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f paymentOrder, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>object</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The paymentOrder object
      </div>
    </div>
    <div class="api-children">
      <details class="api-item" data-level="1">
        <summary>
            <span class="field">{% f id, 1 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
            <span class="type"><code>string</code></span>
        </summary>
        <div class="desc"><div class="indent-1">{{ id_md | markdownify }}</div></div>
      </details>
    </div>
  </details>

  <details class="api-item" data-level="0">
    <summary>
      <span class="field">{% f termsOfServiceUrl, 0 %}<i aria-hidden="true" class="chev swepay-icon-plus-add"></i></span>
      <span class="type"><code>string</code></span>
    </summary>
    <div class="desc">
      <div class="indent-0">
        The URL containing Terms of Service and conditions.
      </div>
    </div>
  </details>
</div>
