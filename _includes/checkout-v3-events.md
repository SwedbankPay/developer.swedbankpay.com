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
body="Adding an event
handler to one of the following events **overrides** the default event handler,
meaning your custom event handler will have to do what the default event handler
did. If you don’t, the behavior of the event is going to be undefined.
Just adding an event handler for logging purposes is therefore not possible, the
event handler will have to perform some functionality similar to the
event handler you are overriding." %}

### `OnAborted`

This event triggers when the payer clicks on the "Abort" redirect page link in
the Payment Menu. It will be raised with the following event argument object:

{:.code-view-header}
**onAborted event object**

```json
{
    "event": "OnAborted",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "redirectUrl": "https://example.com/cancelled"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                     |
| :------------ | :------- | :-------------------------------------------------------------  |
| `event`       | `string` | The name of the event raised.                                   |
| `id`          | `string` | {% include field-description-id.md %}                           |
| `redirectUrl` | `string` | The URL the user will be redirect to after a cancelled payment. |

### `onCheckoutLoaded`

This event triggers when the payment menu is rendered after being opened. If no
callback method is set, no handling action will be done. It will be raised with
the following event argument object:

{:.code-view-header}
**onCheckoutLoaded event object**

```json
{
    "event": "onCheckoutLoaded",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "bodyHeight": "[clientHeight of iframe content]"
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`      | `string` | The name of the event raised.                                         |
| `id`         | `string` | {% include field-description-id.md %}                                 |
| `bodyHeight` | `string` | The height of the client's iframe content.                            |

### `onCheckoutResized`

This event triggers every time a reconfiguration leads to resizing of the
payment menu. If no callback method is set, no handling action will be done. It
will be raised with the following event argument object:

{:.code-view-header}
**onCheckoutResized event object**

```json
{
    "event": "onCheckoutResized",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "bodyHeight": "[clientHeight of iframe content]"
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`      | `string` | The name of the event raised.                                         |
| `id`         | `string` | {% include field-description-id.md %}                                 |
| `bodyHeight` | `string` | The height of the client's iframe content.                            |

### `onError`

This event triggers during terminal errors or if the configuration fails
validation. If no callback method is set, no handling action will be done. It
will be raised with the following event argument object:

{:.code-view-header}
**onError event object**

```json
{
    "event": "onError",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "details": "English descriptive text of the error"
}
```

{:.table .table-striped}
| Field       | Type     | Description                                                            |
| :---------- | :------- | :-------------------------------------------------------------         |
| `event`     | `string` | The name of the event raised.                                          |
| `id`        | `string` | {% include field-description-id.md %}                                  |
| `details`   | `string` | A human readable and descriptive text of the error.                    |

### `onEventNotification`

This event triggers whenever any other public event is called. It does not
prevent their handling. The `onEventNotification` event is raised with the
following event argument object:

{:.code-view-header}
**onEventNotification event object**

```json
{
    "event": "OnEventNotification",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "sourceEvent": "OnCheckoutLoaded | OnCheckoutResized | OnError |
     OnPayerIdentified | OnInstrumentSelected | OnPaid | OnAborted |
     OnOutOfViewRedirect | OnTermsOfServiceRequested | OnOutOfViewOpen"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                |
| :--------     | :------- | :--------------------------------------------------------- |
| `sourceEvent` | `string` | A human readable and descriptive text with the event name. |

### `onInstrumentSelected`

This event triggers when a user actively changes payment instrument in the
Payment Menu. If no callback method is set, no handling action will be done. It
will be raised with the following event argument object:

{:.code-view-header}
**onInstrumentSelected event object**

```json
{
    "event": "onInstrumentSelected",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "instrument": "creditcard | vipps | swish | invoice",
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`     | `string` | The name of the event raised.                                          |
| `id`        | `string` | {% include field-description-id.md %}                                  |
| `instrument` | `string` | `Creditcard`, `vipps`, `swish`, `invoice`. The instrument selected by
the user.                                                                                         |

### `onOutOfViewRedirect`

This event triggers when a user is directed to a separate web page, like
3D-Secure or BankID signing. If no callback method is set, you will be
redirected to the relevant url. It will be raised with the following event
argument object:

{:.code-view-header}
**onOutOfViewRedirect event object**

```json
{
    "event": "onOutOfViewRedirect",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "redirectUrl": "https://example.com/external"
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`      | `string` | The name of the event raised.                                         |
| `id`         | `string` | {% include field-description-id.md %}                                 |
| `redirectUrl` | `string` | The external URL where the user will be redirected.                  |

### `onOutOfViewOpen`

This event triggers when another tab is opened in the browser, like the
information page for onboarding of stored cards, or Swedbank Pay's owner TOS. It
cannot be opened as a modal since the payer needs to see that this is a link on
Swedbank Pay's domain. If no callback method is set, the url will be opened in a
new tab. It will be raised with the following event argument object:

{:.code-view-header}
**onOutOfViewRedirect event object**

```json
{
    "event": "onOutOfViewRedirect",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "openUrl": "https://example.com/external"
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                           |
| :----------- | :------- | :--------------------------------------                               |
| `event`      | `string` | The name of the event raised.                                         |
| `id`         | `string` | {% include field-description-id.md %}                                 |
| `openUrl` | `string` | The external URL where the user will be redirected.                      |

### `OnPaid`

This event triggers when the payer successfully completes or cancels the
payment. It will be raised with the following event argument object:

{:.code-view-header}
**onPaid event object**

```json
{
    "event": "OnPaid",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "redirectUrl": "https://example.com/success"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                         |
| :------------ | :------- | :-------------------------------------------------------------      |
| `event`       | `string` | The name of the event raised.                                       |
| `id`          | `string` | {% include field-description-id.md %}                               |
| `redirectUrl` | `string` | The URL the user will be redirect to after completing the payment.  |

{% if documentation_section contains "checkout/v3/payments" %}

### `onPaymentAttemptStarted`

This event triggers when a user has selected a payment instrument and actively
attempts to perform a payment. The `onPaymentAttemptStarted` event is raised
with the following event argument object:

{:.code-view-header}
**onPaymentAttemptStarted event object**

```json
{
    "event": "OnPaymentAttemptStarted",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "instrument": "creditcard",
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                                                     |
| :----------- | :------- | :---------------------------------------------------------------------------------------------- |
| `event`     | `string` | The name of the event raised.                                          |
| `id`         | `string` | {% include field-description-id.md %}                                                           |
| `instrument` | `string` | `Creditcard`, `vipps`, `swish`, `invoice`. The instrument selected when initiating the payment. |

{% endif %}

{% if documentation_section contains "checkout/v3/standard" %}

### `onPayerIdentified`

This event triggers when a payer has been identified. It will be raised with the
following event argument object:

{:.code-view-header}
**onPayerIdentified event object**

```json
{
    "event": "OnPayerIdentified",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "payer": "/psp/paymentorders/{{ page.payment_id }}/payers",
}
```

{:.table .table-striped}
| Field       | Type     | Description                                                            |
| :---------- | :------- | :-------------------------------------------------------------         |
| `event`     | `string` | The name of the event raised.                                          |
| `id`        | `string` | {% include field-description-id.md %}                                  |
| `payer`     | `string` | The `url` of the resource containing information about the payer.      |

{% endif %}

### `OnTermsOfServiceRequested`

This event triggers when the user clicks on the "Display terms and conditions"
link. Will be handled with callback function if origin is "merchant". If no
callback method is set, terms and conditions will be displayed in an overlay or
a new tab. It will be raised with the following event argument object:

{:.code-view-header}
**onTermsOfServiceRequested event object**

```json
{
    "origin": "owner",
    "openUrl": "https://example.com/terms-of-service"
}
```

{:.table .table-striped}
| Field     | Type     | Description                                                                             |
| :-------- | :------- | :-------------------------------------------------------------------------------------- |
| `origin`  | `string` | `owner`, `merchant`. The value is always `merchant` unless Swedbank Pay hosts the view. |
| `openUrl` | `string` | The URL containing Terms of Service and conditions.                                     |
