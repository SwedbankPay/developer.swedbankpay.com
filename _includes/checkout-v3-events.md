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
body="Adding an event handler to one of the following events **overrides** the
default event handler, meaning your custom event handler will have to do what
the default event handler did. If you don’t, the behavior of the event is going
to be undefined. Just adding an event handler for logging purposes is therefore
not possible, the event handler will have to perform some functionality similar
to the event handler you are overriding." %}

## `onAborted`

This event triggers when the payer aborts the purchase from the payment menu. As
the Seamless View payment menu doesn't have a cancel button (present in the
Redirect integration), you need to provide this button for the payer at your
end. When the payer presses the cancel button, we recommend sending an API
request aborting the payment so it can't be completed at a later time. When we
receive the request, an abort event will be raised the next time the UI fetches
information from the server. Because of that, you should also refresh after
aborting, as this will trigger the event.

It will be raised with the following event argument object:

{:.code-view-header}
**onAborted event object**

```json
{
    "event": "OnAborted",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "redirectUrl": "https://example.com/cancelled"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                     |
| :------------ | :------- | :-------------------------------------------------------------  |
| `event`       | `string` | The name of the event raised.                                   |
| `paymentOrder`          | `string` | {% include field-description-id.md %}                 |
| `redirectUrl` | `string` | The URL the user will be redirect to after a cancelled payment. |

## `onCheckoutLoaded`

This event triggers when the payment menu is rendered after being opened.

Subscribe to this event if you need total control over the height of Swedbank
Pay's payment frame. This is the initial height of the frame when loaded.

If no callback method is set, no handling action will be done. It will be raised
with the following event argument object:

{:.code-view-header}
**onCheckoutLoaded event object**

```json
{
    "event": "OnCheckoutLoaded",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "bodyHeight": "[clientHeight of iframe content]"
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`      | `string` | The name of the event raised.                                         |
| `paymentOrder`         | `string` | {% include field-description-id.md %}                       |
| `bodyHeight` | `string` | The height of the client's iframe content.                            |

## `onCheckoutResized`

This event triggers every time a reconfiguration leads to resizing of the
payment menu.

Subscribe to this event if you need total control over the height of Swedbank
Pay's payment frame. The payment instruments requires individual heights when
rendering their content. This event triggers each time the iframe needs resizing
during a payment.

If no callback method is set, no handling action will be done. It
will be raised with the following event argument object:

{:.code-view-header}
**onCheckoutResized event object**

```json
{
    "event": "OnCheckoutResized",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "bodyHeight": "[clientHeight of iframe content]"
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`      | `string` | The name of the event raised.                                         |
| `paymentOrder`     | `string` | {% include field-description-id.md %}                           |
| `bodyHeight` | `string` | The height of the client's iframe content.                            |

## `onError`

This event triggers during terminal errors or if the configuration fails
validation.

Subscribe to this event if you want some action to occur on your site when an
error happens during the payment.

If no callback method is set, no handling action will be done. It
will be raised with the following event argument object:

{:.code-view-header}
**onError event object**

```json
{
    "event": "OnError",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "details": "English descriptive text of the error"
}
```

{:.table .table-striped}
| Field       | Type     | Description                                                            |
| :---------- | :------- | :-------------------------------------------------------------         |
| `event`     | `string` | The name of the event raised.                                          |
| `paymentOrder`        | `string` | {% include field-description-id.md %}                        |
| `details`   | `string` | A human readable and descriptive text of the error.                    |

## `onEventNotification`

This event triggers whenever any other public event is called. It does not
prevent their handling.

Subscribe to this event in order to log actions that are happening in the
payment flow at Swedbank Pay.

`onEventNotification` is raised with the following event argument object:

{:.code-view-header}
**onEventNotification event object**

```json
{
    "event": "OnEventNotification",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "sourceEvent": "OnCheckoutLoaded | OnCheckoutResized | OnError |
     OnPayerIdentified | OnInstrumentSelected | OnPaid | OnAborted |
     OnOutOfViewRedirect | OnTermsOfServiceRequested | OnOutOfViewOpen"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                |
| :--------     | :------- | :--------------------------------------------------------- |
| `event`     | `string` | The name of the event raised.                                |
| `paymentOrder`        | `string` | {% include field-description-id.md %}              |
| `sourceEvent` | `string` | A human readable and descriptive text with the event name. |

## `onInstrumentSelected`

This event triggers when a user actively changes payment instrument in the
Payment Menu.

Subscribe to this event if actions, e.g. showing an information text, are
required on your side if the payer changes payment instrument.

If no callback method is set, no handling action will be done. It
will be raised with the following event argument object:

{:.code-view-header}
**onInstrumentSelected event object**

```json
{
    "event": "OnInstrumentSelected",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "instrument": "creditcard | vipps | swish | invoice",
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`     | `string` | The name of the event raised.                                          |
| `paymentOrder`        | `string` | {% include field-description-id.md %}                        |
| `instrument` | `string` | `Creditcard`, `vipps`, `swish`, `invoice`. The instrument selected by
the user.                                                                                         |

## `onOutOfViewOpen`

This event triggers when another tab is opened in the browser, like the
information page for onboarding of stored cards, or Swedbank Pay's owner TOS. It
cannot be opened as a modal since the payer needs to see that this is a link on
Swedbank Pay's domain.

Subscribe to this event if you do not want the default handling of these links.
But e.g. want to redirect the payer to a new page, and not just another tab
within the same browser.

If no callback method is set, the url will be opened in a
new tab. It will be raised with the following event argument object:

{:.code-view-header}
**onOutOfViewOpen event object**

```json
{
    "event": "OnOutOfViewOpen",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "openUrl": "https://example.com/external"
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`      | `string` | The name of the event raised.                                         |
| `paymentOrder`         | `string` | {% include field-description-id.md %}                       |
| `openUrl`    | `string` | The external URL where the user will be redirected.                   |

## `onOutOfViewRedirect`

This event triggers when a user is redirected to a separate web page, like
3D-Secure or BankID signing.

Subscribe to this event if it's not possible to redirect the payer directly from
within Swedbank Pay's payment frame.

If no callback method is set, you will be redirected to the relevant url. It
will be raised with the following event argument object:

{:.code-view-header}
**onOutOfViewRedirect event object**

```json
{
    "event": "OnOutOfViewRedirect",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "redirectUrl": "https://example.com/external"
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`      | `string` | The name of the event raised.                                         |
| `paymentOrder`         | `string` | {% include field-description-id.md %}                       |
| `redirectUrl` | `string` | The external URL where the user will be redirected.                  |

## `onPaid`

This event triggers when the payer successfully completes or cancels the
payment.

Subscribe to this event if actions are needed on you side other than the default
handling of redirecting the payer to your `completeUrl`. Call GET on the
`paymentOrder` to receive the actual payment status, and take appropriate
actions according to it.

It will be raised with the following event argument object:

{:.code-view-header}
**onPaid event object**

```json
{
    "event": "OnPaid",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "redirectUrl": "https://example.com/success"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                         |
| :------------ | :------- | :-------------------------------------------------------------      |
| `event`       | `string` | The name of the event raised.                                       |
| `paymentOrder`          | `string` | {% include field-description-id.md %}                     |
| `redirectUrl` | `string` | The URL the user will be redirect to after completing the payment.  |

{% if documentation_section contains "checkout-v3/starter" %}

## `onPayerIdentified`

This event triggers when a payer has been identified. This event is required for
**Starter** to work, and there are two scenarios where it will occur.

*   The **first** is when the payer has finalized checkin, where this is the
expected merchant behavior:

*   Merchant calls GET on the `paymentOrder` to receive payer data (shipping
    address).

*   Merchant activates shipping cost calculation.

*   When shipping cost is calculated, update the payment order with new price
  and open Payment Menu.

*   The **second** is when the payer has added or edited a shipping address. In
  those cases, this is the expected merchant behavior:

*   Merchant needs to decide if payment menu should be closed (the menu is
  already open).

*   Merchant calls GET on `paymentOrder` again to receive new payer data
    (shipping address).

*   Merchant activates shipping cost calculation if required.

*   If a new shipping cost is calculated, update the payment order with the new
    price and open the Payment Menu.

It will be raised with the
following event argument object:

{:.code-view-header}
**onPayerIdentified event object**

```json
{
    "event": "OnPayerIdentified",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
    "payer": "/psp/paymentorders/{{ page.payment_id }}/payers",
}
```

{:.table .table-striped}
| Field          | Type     | Description                                                         |
| :------------- | :------- | :-------------------------------------------------------------      |
| `event`        | `string` | The name of the event raised.                                       |
| `paymentOrder` | `string` | {% include field-description-id.md %}                               |
| `payer`        | `string` | The `url` of the resource containing information about the payer.   |

## `onPayerUnidentified`

This event triggers when a payer clicks "Not you" when identified with "Remember
Me", and it is a mandatory event for **Starter** to work. It is a part of the
acceptance criteria, meaning you won't get the green light to go live with your
implementation without it.

Expected merchant behavior when it occurs is:

*   Merchant needs to close/hide/disable the payment menu iframe.

*   Merchant needs to close shipping calculation until a new `onPayerIdentified`
  is received, as the payer's shipping address could be updated after next
  checkin.

It will be raised with the following event argument object:

{:.code-view-header}
**onPayerUnidentified event object**

```json
{
    "event": "OnPayerUnidentified",
    "paymentOrder": { "id": "/psp/paymentorders/{{ page.payment_id }}" },
}
```

{:.table .table-striped}
| Field           | Type     | Description                                                  |
| :-------------  | :------- | :------------------------------------------------------      |
| `event`         | `string` | The name of the event raised.                                |
| `paymentOrder`  | `string` | {% include field-description-id.md %}                        |

{% endif %}

## `onTermsOfServiceRequested`

This event triggers when the user clicks on the "Display terms and conditions"
link.

Subscribe to this event if you don't want the default handling of the
`termsOfServiceUrl`. Swedbank Pay will open the `termsOfServiceUrl`
in a new tab within the same browser by default.

If no callback method is set, terms and conditions will be displayed in an
overlay or a new tab. It will be raised with the following event argument
object:

{:.code-view-header}
**onTermsOfServiceRequested event object**

```json
{
"event": "OnTermsOfServiceRequested",
"paymentOrder": { "id": "/psp/paymentorders/<paymentorderId>"},
"termsOfServiceUrl": "https://example.org/terms.html"
}
```

{:.table .table-striped}
| Field                | Type     | Description                                         |
| :--------            | :------- | :---------------------------------------------------|
| `event`              | `string` | The name of the event raised.                       |
| `paymentOrder`       | `string` | {% include field-description-id.md %}               |
| `termsOfServiceUrl`  | `string` | The URL containing Terms of Service and conditions. |
