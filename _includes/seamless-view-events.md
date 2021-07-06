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
did. If you don’t, the behaviour of the event is going to be undefined.
Just adding an event handler for logging purposes is therefore not possible, the
event handler will have to perform some functionality similar to the
event handler you are overriding." %}

### `onPaymentPending`

This events triggers when a payment enters a paying state ( `Sale`, `Authorize`,
`Cancel`etc). The `onPaymentPending` event
will be followed by either `onPaymentPaid`, `onPaymentFailed` or
`onPaymentTransactionFailed` based on the result of the payment. Read more about
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
| `id`          | `string` | {% include field-description-id.md %}                           |

### `onPaymentPaid`

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
| `id`          | `string` | {% include field-description-id.md %}                           |
| `redirectUrl` | `string` | The URI the user will be redirect to after a completed payment. |

### `onPaymentAborted`

This event triggers when the user cancels the payment.
The `onPaymentAborted` event is raised with the following event argument
object:

{:.code-view-header}
**onPaymentAborted event object**

```json
{
    "id": "/psp/{{ api_resource }}payments/{{ page.payment_id }}",
    "redirectUrl": "https://example.com/canceled"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                    |
| :------------ | :------- | :------------------------------------------------------------- |
| `id`          | `string` | {% include field-description-id.md %}                          |
| `redirectUrl` | `string` | The URI the user will be redirect to after a canceled payment. |

### `onPaymentFailed`

This event triggers when a payment has failed, disabling further attempts to
perform a payment. The `onPaymentFailed` event is raised with the following
event argument object:

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
| `id`          | `string` | {% include field-description-id.md %}                        |
| `redirectUrl` | `string` | The URI the user will be redirect to after a failed payment. |

### `onTermsOfServiceRequested`

This event triggers when the user clicks on the "Display terms and conditions"
link. The `onTermsOfServiceRequested` event is raised with the following event
argument object:

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
| `openUrl` | `string` | The URI containing Terms of Service and conditions.                                     |

### `onError`

This event triggers during terminal errors or if the configuration fails
validation. The `onError` event will be raised with the following event argument
object:

{:.code-view-header}
**onError event object**

```json
{
    "origin": "{{ api_resource }}",
    "messageId": "{{ page.transaction_id }}",
    "details": "Descriptive text of the error"
}
```

{:.table .table-striped}
| Field       | Type     | Description                                                    |
| :---------- | :------- | :------------------------------------------------------------- |
| `origin`    | `string` | `{{ api_resource }}`, identifies the system that originated the error. |
| `messageId` | `string` | A unique identifier for the message.                           |
| `details`   | `string` | A human readable and descriptive text of the error.
|

{% if api_resource == "paymentorders" %}

### `onApplicationConfigured`

This event triggers whenever a reconfiguration leads to resizing of the payment
menu. No action will be done if callback is not set. The
`onApplicationConfigured` event is raised with the following event argument
object:

{:.code-view-header}
**onEventNotification event object**

```json
{
    "details": "source: "PaymentMenuClient", bodyHeight: "[clientHeight of iframe content]""
}
```

{:.table .table-striped}
| Field     | Type     | Description                                                          |
| :-------- | :------- | :------------------------------------------------------------------- |
| `details` | `string` | The source of the reconfiguration, and the new height of the iframe. |

### `onEventNotification`

This event triggers whenever any other public event is called. It does not
prevent their handling. The `onEventNotification` event is raised with the
following event argument object:

{:.code-view-header}
**onEventNotification event object**

```json
{
    "details": "Name of the event called"
}
```

{:.table .table-striped}
| Field     | Type     | Description                                                |
| :-------- | :------- | :--------------------------------------------------------- |
| `details` | `string` | A human readable and descriptive text with the event name. |

### `onInstrumentSelected`

This event triggers when a user actively changes payment instrument in the
Payment Menu. The `onInstrumentSelected` event is raised with the
following event argument object:

{:.code-view-header}
**onInstrumentSelected event object**

```json
{
    "name": "menu identifier",
    "instrument": "creditcard | vipps | swish | invoice",
}
```

{:.table .table-striped}
| Field        | Type     | Description                                                                                                                                                      |
| :----------- | :------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`       | `string` | The name and identifier of specific instrument instances - i.e. if you deploy more than one type of credit card payments, they would be distinguished by `name`. |
| `instrument` | `string` | `Creditcard`, `vipps`, `swish`, `invoice`. The instrument selected by the user.                                                                                  |

### `onPaymentCreated`

This event triggers when a user has selected a payment instrument and actively
attempts to perform a payment. The `onPaymentCreated` event is raised with the
following event argument object:

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
| `id`         | `string` | {% include field-description-id.md %}                                                           |
| `instrument` | `string` | `Creditcard`, `vipps`, `swish`, `invoice`. The instrument selected when initiating the payment. |

### `onPaymentTransactionFailed`

This event triggers when a payment attempt fails, further attempts can be made
for the payment. An error message will appear in the payment UI, and the
payer will be able to try again or choose another payment instrument. The
`onPaymentTransactionFailed` event is raised with the following event argument
object:

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
| `id`      | `string` | {% include field-description-id.md %}               |
| `details` | `string` | A human readable and descriptive text of the error. |

### `onOutOfViewRedirect`

This event triggers when a user is redirected to a separate web page, for
example 3-D Secure or Bank ID signing. The `onOutOfViewRedirect` event is raised
with the following event argument object:

{:.code-view-header}
**onOutOfViewRedirect event object**

```json
{
    "redirectUrl": "https://external.example.com/"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                                         |
| :------------ | :------- | :---------------------------------------------------------------------------------- |
| `redirectUrl` | `string` | The URI the user will be redirected to when a third party requires additional data. |

## Updating Payment Menu

When the contents of the shopping cart changes or anything else that affects
the amount occurs, the `paymentorder` must be updated and the Payment Menu
must be `refresh`ed.

{% endif %}
