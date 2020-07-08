{% assign api_resource = include.api_resource %}

{% if api_resource == "paymentorders" %}
    {% assign product="Payment Menu" %}
{% else %}
    {% assign product="Seamless View" %}
{% endif %}

## {{ product }} Events

During operation in the {{ product }}, several events can occur. They are
described below.

### `onPaymentPending`
This events triggers when a payment enters a paying state ( `Sale`, `Authorize`,
`Cancel`etc). The `onPaymentPending` event
will be followed by either `onPaymentCompleted`, `onPaymentFailed` or 
`onPaymentTransactionFailed` based on the result of the payment. Read more about
these events below. 

{:.code-header}
**`onPaymentPending` event object**

```js
{
    "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                     |
| :------------ | :------- | :-------------------------------------------------------------- |
| `id`          | `string` | {% include field-description-id.md %}                           |



### `onPaymentCompleted`

This event triggers when a payment has completed successfully.
The `onPaymentCompleted` event is raised with the following event argument
object:

{:.code-header}
**`onPaymentCompleted` event object**

```js
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

### `onPaymentCanceled`

This event triggers when the user cancels the payment.
The `onPaymentCanceled` event is raised with the following event argument
object:

{:.code-header}
**`onPaymentCanceled` event object**

```js
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

{:.code-header}
**`onPaymentFailed` event object**

```js
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

### `onPaymentTermsOfService`

This event triggers when the user clicks on the "Display terms and conditions"
link. The `onPaymentTermsOfService` event is raised with the following event
argument object:

{:.code-header}
**`onPaymentTermsOfService` event object**

```js
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

{:.code-header}
**`onError` event object**

```js
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

### `onPaymentMenuInstrumentSelected`

This event triggers when a user actively changes payment instrument in the
Payment Menu. The `onPaymentMenuInstrumentSelected` event is raised with the
following event argument object:

{:.code-header}
**`onPaymentMenuInstrumentSelected` event object**

```js
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

{:.code-header}
**`onPaymentCreated` event object**

```js
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
consumer will be able to try again or choose another payment instrument. The
`onPaymentTransactionFailed` event is raised with the following event argument
object:

{:.code-header}
**`onPaymentTransactionFailed` event object**

```js
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

### `onExternalRedirect`

This event triggers when a user is redirected to a separate web page, for
example 3-D Secure or Bank ID signing. The `onExternalRedirect` event is raised
with the following event argument object:

{:.code-header}
**`onExternalRedirect` event object**

```js
{
    "redirectUrl": "https://external.example.com/"
}
```

{:.table .table-striped}
| Field         | Type     | Description                                                                         |
| :------------ | :------- | :---------------------------------------------------------------------------------- |
| `redirectUrl` | `string` | The URI the user will be redirected to when a third party requires additional data. |

{% endif %}
