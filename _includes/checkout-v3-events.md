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

{% include events/on-aborted.md %}

As the Seamless View payment menu doesn't have a cancel button (present in the
Redirect integration), you need to provide this button for the payer at your
end.

When the payer presses the cancel button, we recommend sending an API request
aborting the payment so it can't be completed at a later time. When we receive
the request, an abort event will be raised the next time the UI fetches
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
| {% f paymentOrder, 0 %}          | `string` | {% include fields/id.md %}                 |
| `redirectUrl` | `string` | The URL the user will be redirect to after a cancelled payment. |

## `onCheckoutLoaded`

{% include events/on-checkout-loaded.md %}

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
| {% f paymentOrder, 0 %}         | `string` | {% include fields/id.md %}                       |
| `bodyHeight` | `string` | The height of the client's iframe content.                            |

## `onCheckoutResized`

{% include events/on-checkout-resized.md %}

Subscribe to this event if you need total control over the height of Swedbank
Pay's payment frame. The payment instruments require individual heights when
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
| {% f paymentOrder, 0 %}     | `string` | {% include fields/id.md %}                           |
| `bodyHeight` | `string` | The height of the client's iframe content.                            |

## `onError`

{% include events/on-error.md %}

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
| {% f paymentOrder, 0 %}        | `string` | {% include fields/id.md %}                        |
| `details`   | `string` | A human readable and descriptive text of the error.                    |

## `onEventNotification`

{% include events/on-event-notification.md %}

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
| {% f paymentOrder, 0 %}        | `string` | {% include fields/id.md %}              |
| `sourceEvent` | `string` | A human readable and descriptive text with the event name. |

## `onInstrumentSelected`

{% include events/on-instrument-selected.md %}

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
| {% f paymentOrder, 0 %}        | `string` | {% include fields/id.md %}                        |
| `instrument` | `string` | `Creditcard`, `vipps`, `swish`, `invoice`. The instrument selected by
the user.                                                                                         |

## `onOutOfViewOpen`

{% include events/on-out-of-view-open.md %}

The event cannot be opened as a modal since the payer needs to see that this is
a link on Swedbank Pay's domain.

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
| {% f paymentOrder, 0 %}         | `string` | {% include fields/id.md %}                       |
| `openUrl`    | `string` | The external URL where the user will be redirected.                   |

## `onOutOfViewRedirect`

{% include events/on-out-of-view-redirect.md %}

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
| {% f paymentOrder, 0 %}         | `string` | {% include fields/id.md %}                       |
| `redirectUrl` | `string` | The external URL where the user will be redirected.                  |

## `onPaid`

{% include events/on-paid.md %}

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
| {% f paymentOrder, 0 %}          | `string` | {% include fields/id.md %}                     |
| `redirectUrl` | `string` | The URL the user will be redirect to after completing the payment.  |

## `onTermsOfServiceRequested`

{% include events/on-terms-of-service-requested.md %}

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
| {% f paymentOrder, 0 %}       | `string` | {% include fields/id.md %}               |
| `termsOfServiceUrl`  | `string` | The URL containing Terms of Service and conditions. |
