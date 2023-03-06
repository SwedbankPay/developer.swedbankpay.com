{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{%- include utils/documentation-section.md -%}{% endcapture %}

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

## `onApplicationConfigured`

This event triggers whenever a reconfiguration leads to resizing of the payment
menu. No action will be done if callback is not set. The
`onApplicationConfigured` event is raised with the following event argument
object:

{:.code-view-header}
**onApplicationConfigured event object**

```json
{
    "details": "source: "PaymentMenuClient", bodyHeight: "[clientHeight of iframe content]""
}
```

{:.table .table-striped}
| Field     | Type     | Description                                                          |
| :-------- | :------- | :------------------------------------------------------------------- |
| `details` | `string` | The source of the reconfiguration, and the new height of the iframe. |

## `onBillingDetailsAvailable`

This event triggers when a consumer has been identified. The
`onBillingDetailsAvailable` event will be raised with the following event
argument object:

{:.code-view-header}
**onBillingDetailsAvailable event object**

```json
{
    "actionType": "OnBillingDetailsAvailable",
    "url": "/psp/consumers/{{ConsumerProfileRef}}/billing-details",
}
```

{:.table .table-striped}
| Field     | Type     | Description                                                                             |
| :-------- | :------- | :-------------------------------------------------------------------------------------- |
| `actionType`  | `string` | The type of event that was raised.                                                  |
| `url`         | `string` | The URL containing billing details.                                                 |

## `onError`

This event triggers during terminal errors or if the configuration fails
validation. The `onError` event will be raised with the following event argument
object:

{:.code-view-header}
**onError event object**

```json
{
    "origin": "{{ api_resource }}",
    "id": "/psp/paymentorders/{{ page.payment_id }}",
    "details": "English descriptive text of the error"
}
```

{:.table .table-striped}
| Field       | Type     | Description                                                    |
| :---------- | :------- | :------------------------------------------------------------- |
| `origin`    | `string` | `{{ api_resource }}`, identifies the system that originated the error. |
| `id`        | `string` | {% include fields/id.md %}                        |
| `details`   | `string` | A human readable and descriptive text of the error.
|

## `onExternalRedirect`

This event triggers when a user is redirected to a separate web page, like
3D-Secure or BankID signing.

Subscribe to this event if it's not possible to redirect the payer directly from
within Swedbank Pay's payment frame.

If no callback method is set, you will be redirected to the relevant url. It
will be raised with the following event argument object:

{:.code-view-header}
**onExternalRedirect event object**

```json
{
    "event": "OnExternalRedirect",
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

## `onPaymentAborted`

This event triggers when the user cancels the payment.
The `onPaymentAborted` event is raised with the following event argument
object:

{:.code-view-header}
**onPaymentAborted event object**

```json
{
    "id": "/psp/{{ api_resource }}payments/{{ page.payment_id }}",
    "redirectUrl": "https://example.com/cancelled"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                    |
| :------------ | :------- | :------------------------------------------------------------- |
| `id`          | `string` | {% include fields/id.md %}                          |
| `redirectUrl` | `string` | The URL the user will be redirect to after a cancelled payment. |

## `onPaymentCanceled`

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
**onPaymentCanceled event object**

```json
{
    "event": "OnPaymentCanceled",
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

## `onPaymentCompleted`

This event triggers when the payer successfully completes or cancels the
payment.

Subscribe to this event if actions are needed on you side other than the default
handling of redirecting the payer to your `completeUrl`. Call GET on the
`paymentOrder` to receive the actual payment status, and take appropriate
actions according to it.

It will be raised with the following event argument object:

{:.code-view-header}
**onPaymentCompleted event object**

```json
{
    "event": "OnPaymentCompleted",
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

## `onPaymentCreated`

{% include events/on-payment-created.md %}

The `onPaymentCreated` event is raised with the following event argument object:

{:.code-view-header}
**onPaymentCreated event object**

```json
{
    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "instrument": "creditcard",
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                                                     |
| :----------- | :------- | :---------------------------------------------------------------------------------------------- |
| `id`         | `string` | {% include fields/id.md %}                                                           |
| `instrument` | `string` | `Creditcard`, `vipps`, `swish`, `invoice`. The instrument selected when initiating the payment. |

## `onPaymentFailed`

{% include events/on-payment-failed.md %}

The `onPaymentFailed` event is raised with the following event argument object:

{:.code-view-header}
**onPaymentFailed event object**

```json
{
    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "redirectUrl": "https://example.com/failed"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                  |
| :------------ | :------- | :----------------------------------------------------------- |
| `id`          | `string` | {% include fields/id.md %}                        |
| `redirectUrl` | `string` | The URL the user will be redirect to after a failed payment. |

## `onPaymentInstrumentSelected`

This event triggers when a user actively changes payment instrument in the
Payment Menu.

Subscribe to this event if actions, e.g. showing an information text, are
required on your side if the payer changes payment instrument.

If no callback method is set, no handling action will be done. It
will be raised with the following event argument object:

{:.code-view-header}
**onPaymentInstrumentSelected event object**

```json
{
    "event": "OnPaymentInstrumentSelected",
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

## `onPaymentPaid`

This event triggers when a payment has completed successfully.
The `onPaymentPaid` event is raised with the following event argument
object:

{:.code-view-header}
**onPaymentPaid event object**

```json
{
    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "redirectUrl": "https://example.com/complete"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                     |
| :------------ | :------- | :-------------------------------------------------------------- |
| `id`          | `string` | {% include fields/id.md %}                           |
| `redirectUrl` | `string` | The URL the user will be redirect to after a completed payment. |

## `onPaymentPending`

{% include events/on-payment-pending.md %}

 Read more about
these events below.

{:.code-view-header}
**onPaymentPending event object**

```json
{
    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                     |
| :------------ | :------- | :-------------------------------------------------------------- |
| `id`          | `string` | {% include fields/id.md %}                           |

## `onPaymentToS`

This event triggers when the user clicks on the "Display terms and conditions"
link. The `onPaymentToS` event is raised with the following event
argument object:

{:.code-view-header}
**onPaymentToS event object**

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

## `onPaymentTransactionFailed`

{% include events/on-payment-transaction-failed.md %}

An error message will appear in the payment UI, and the payer will be able to
try again or choose another payment instrument. The `onPaymentTransactionFailed`
event is raised with the following event argument object:

{:.code-view-header}
**onPaymentTransactionFailed event object**

```json
{
    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "details": "[HttpCode ProblemTitle]"
}
```

{:.table .table-striped}
| Field     | Type     | Description                                         |
| :-------- | :------- | :-------------------------------------------------- |
| `id`      | `string` | {% include fields/id.md %}               |
| `details` | `string` | A human readable and descriptive text of the error. |

## `onShippingDetailsAvailable`

This event triggers when a consumer has been identified or their shipping
address has been updated. The `onShippingDetailsAvailable` event will be raised
with the following event argument object:

{:.code-view-header}
**onShippingDetailsAvailable event object**

```json
{
    "actionType": "OnShippingDetailsAvailable",
    "url": "/psp/consumers/{{ConsumerProfileRef}}/shipping-details",
}
```

{:.table .table-striped}
| Field     | Type     | Description                                                                             |
| :-------- | :------- | :-------------------------------------------------------------------------------------- |
| `actionType`  | `string` | The type of event that was raised.                                                  |
| `url`         | `string` | The URL containing shipping details.                                                |

## Updating Payment Menu

When the contents of the shopping cart changes or anything else that affects
the amount occurs, the `paymentorder` must be updated and the Payment Menu
must be `refresh`ed.
