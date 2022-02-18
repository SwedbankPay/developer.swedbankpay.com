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

### `OnAborted`

This event triggers when the payer clicks "Abort" on the redirect page link in
the Payment Menu.

Subscribe to this event if an action is required before the payer is redirected
to the `CancelUrl`. Swedbank Pay returns the url sent in as `cancelUrl` in the
`paymentOrder` request.

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

### `onCheckoutLoaded`

This event triggers when the payment menu is rendered after being opened.

Subscribe to this event if you need total control over the height of Swedbank
Pay's payment frame. This is the initial height of the frame when loaded.

If no callback method is set, no handling action will be done. It will be raised
with the following event argument object:

{:.code-view-header}
**onCheckoutLoaded event object**

```json
{
    "event": "onCheckoutLoaded",
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

### `onCheckoutResized`

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
    "event": "onCheckoutResized",
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

### `onError`

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
    "event": "onError",
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

### `onEventNotification`

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

### `onInstrumentSelected`

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
    "event": "onInstrumentSelected",
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

### `onOutOfViewOpen`

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
    "event": "onOutOfViewOpen",
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

### `onOutOfViewRedirect`

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
    "event": "onOutOfViewRedirect",
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

### `OnPaid`

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

### `onPayerIdentified`

This event triggers when a payer has been identified. This event is required for
**Starter** to work, and there are two scenarios where it will occur.

*   The **first** is when the payer has finalized checkin, where this is the
expected merchant behavior:

*   Merchant calls GET on the `paymentOrder` to receive payer data (shipping
    address).

*   Merchant activates shipping cost calculation.

*   When shipping cost is calculated, updat the payment order with new price and
  open Payment Menu.

*   The **second** is when the payer has added or edited a shipping address. In
  those cases, this is the expected merchant behavior:

*   Merchant needs to decide if payment menu should be closed (the menu is
  already open).

*   Merchant calls GET on `payment0rder` again to receive new payer data
    (shipping address).

*   Merchant activates shipping cost calculation if required.

*   If a new shipping cost is calculated, update payment order with the new
    price and open Payment Menu.

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
| Field       | Type     | Description                                                            |
| :---------- | :------- | :-------------------------------------------------------------         |
| `event`     | `string` | The name of the event raised.                                          |
| `paymentOrder`        | `string` | {% include field-description-id.md %}                        |
| `payer`     | `string` | The `url` of the resource containing information about the payer.      |

### `onPayerUnidentified`

This event triggers when a payer clicks "Not you" when identified with Remember
Me, and it is required for **Starter** to work.

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
| `paymentOrder`  | `string` | {% include field-description-id.md %}                          |

{% endif %}

### `OnTermsOfServiceRequested`

This event triggers when the user clicks on the "Display terms and conditions"
link.

Subscribe to this event if you don't want the default handing of the
`termsOfServiceUrl`. Swedbank Pay will by default open the `termsOfServiceUrl`
in a new tab within the same browser.

If no callback method is set, terms and conditions will be displayed in an
overlay or a new tab. It will be raised with the following event argument
object:

{:.code-view-header}
**onTermsOfServiceRequested event object**

```json
{
    "origin": "owner",
    "termsOfServiceUrl": "https://example.com/terms-of-service"
}
```

{:.table .table-striped}
| Field     | Type     | Description                                                                             |
| :-------- | :------- | :-------------------------------------------------------------------------------------- |
| `origin`  | `string` | `owner`, `merchant`. The value is always `merchant` unless Swedbank Pay hosts the view. |
| `termsOfServiceUrl` | `string` | The URL containing Terms of Service and conditions.                                     |
