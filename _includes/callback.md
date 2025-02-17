{% capture api_resource %}{% include api-resource.md %}{% endcapture %}

{% include alert.html type="warning" icon="warning" body="While the callback
feature is mandatory, we would like to emphasize that it is mainly a fail-safe
feature. We strongly advice that it is not your primary mean of checking for
payment updates." %}

When a change or update from the back-end system are made on a payment or
transaction, Swedbank Pay will perform a callback to inform the payee (merchant)
about this update.

## Why Is The Callback Important?

Providing a `callbackUrl` in `POST` requests is **mandatory**. Below we provide
three example scenarios of why this is important:

1.  If the payer closes the payment window, the merchant will never know what
    happened to the payment if `callbackUrl` is not implemented.
2.  If the payer stops up in a payment app such as Vipps or Swish, the payer
    will never come back to the merchant. This means that the merchant won't
    know what happened to the payment unless `callbackUrl` is implemented.
3.  If a payer experiences a network error or something else happens that
    prevents the payer from being redirected from Swedbank Pay back to the
    merchant website, the `callbackUrl` is what ensures that you receive the
    information about what happened with the payment.

## Technical Information

*   When a change or update from the back-end system is made on a payment or
    transaction, Swedbank Pay will perform an asynchronous server-to-server
    callback to inform the payee (merchant) about this update.
*   It is important to know that the callback is asynchronous, and not
    real-time. As we can’t guarantee when you get the callback, there could be a
    delay between when the payer is returned back to the merchant and when the
    callback arrives. If the merchant chooses to wait for the callback, the
    payer might be left at the merchant’s page until the response comes.
*   Swedbank Pay will make an HTTP `POST` to the `callbackUrl` that was
    specified when the payee (merchant) created the payment.
*   When the `callbackUrl` receives such a callback, an HTTP `GET` request
    must be made on the payment or on the transaction. The retrieved payment or
    transaction resource will give you the necessary information about the
    recent change/update.
*   For unscheduled and recur transactions, no callback will be given for card
    transactions, only Trustly.
*   As it isn't scaled to be a primary source of updates, no given response time
    can be guaranteed, and a callback might fail. It will be retried if that
    should happen. Below are the retry timings, in seconds from the initial
    transaction time:
    *   30 seconds
    *   60 seconds
    *   360 seconds
    *   432 seconds
    *   864 seconds
    *   1265 seconds
*   A callback should return a `200 OK` response.

To understand the nature of the callback, the type of transaction, its status,
etc., you need to perform a `GET` request on the received URL and inspect the
response. The transaction type or any other information can not and should not
be inferred from the URL. See [URL usage][url-usage] for more information.

For `paymentOrder` implementations (Digital Payments, Checkout v2 and Payment
Menu v1), it is critical that you do **not** use the `paymentId` or
`transactionId` when performing a `GET` to retrieve the payment's status. Use
the `paymentOrderId`.

### Callback IP Addresses

The callbacks are currently sent from either `51.107.183.58` or `91.132.170.1`
in both the test and production environment.

{% include alert.html type="warning" icon="warning" body="Starting from March
12th 2025, callbacks will be sent from one of the IP addresses in this interval,
and we strongly advise you to whitelist them as soon as possible:

`20.91.170.120–127` (`20.91.170.120/29`)." %}

#### FAQ – Change of IP Addresses for Callbacks

{% capture acc-1 %}
We will be updating the IP addresses from which callbacks for eCommerce payments
are sent. This change will affect the external integration for both test and
production environments.

The current IP addresses are 91.132.170.1 and 51.107.183.58. The new IP range
will be 20.91.170.120 – 127, with the prefix (20.91.170.120/29).
{% endcapture %}
{% include accordion-table.html content=acc-1 button_expand_text='What is changing?' button_collapse_text='What is changing?' %}
{% capture acc-2 %}

*   Update your firewall rules to allow incoming traffic from the new IP
  addresses.

*   Ensure these changes are made by March 12, 2025, to avoid potential
disruptions in the callback functionality.
{% endcapture %}
{% include accordion-table.html content=acc-2 button_expand_text='What do you need to do?' button_collapse_text='What do you need to do?' %}
{% capture acc-3 %}
*   Date: March 12, 2025

*   Time: 12:00 CET – 13:00 CET

*   Grace period: See further details below.
{% endcapture %}
{% include accordion-table.html content=acc-3 button_expand_text='When will the change take place?' button_collapse_text='When will the change take place?' %}
{% capture acc-4 %}
We need to update and deploy new outbound IP addresses from our Azure Cloud
environment. To ensure uninterrupted communication between our system and your
systems, all merchants and partners must update their firewalls with the new IP
range and prefix.

This applies to all merchants, regardless of integration method. No technical
code changes are required, but firewall adjustments must be made in your
infrastructure, typically handled by your IT or infrastructure providers.
{% endcapture %}
{% include accordion-table.html content=acc-4 button_expand_text='Why are we making this change?' button_collapse_text='Why are we making this change?' %}
{% capture acc-5 %}
By migrating callbacks to the Azure Cloud, we are enhancing our ability to scale
and manage traffic dynamically.

This means:

*   Improved operational stability – We can handle more concurrent callback
requests without performance degradation.

*   Faster recovery from technical issues or incidents – We can automatically
redirect traffic in case of disruptions.

*   Better monitoring and proactive issue resolution – We now have more tools to
detect and address issues in real-time.
{% endcapture %}
{% include accordion-table.html content=acc-5 button_expand_text='How will this change affect the stability of callbacks?' button_collapse_text='How will this change affect the stability of callbacks?' %}
{% capture acc-6 %}
We understand that some merchants may not complete the update before March 12.
Therefore, we will continue to run callbacks from the current solution during a
grace period.

However, it is important to migrate as soon as possible, as we will gradually
phase out the old solution to reduce system maintenance and complexity.

We will:

*   Closely monitor traffic to ensure stable callbacks from the Azure Cloud.

*   Actively monitor merchants and partners to ensure a smooth transition.
{% endcapture %}
{% include accordion-table.html content=acc-6 button_expand_text='What happens if we don’t make the change in time?' button_collapse_text='What happens if we don’t make the change in time?' %}
{% capture acc-7 %}
We recommend that merchants allow both the old and new IP addresses during the
transition period. This ensures stable callback functionality, even if network
issues arise during the migration.
{% endcapture %}
{% include accordion-table.html content=acc-7 button_expand_text='Recommendations during the grace period' button_collapse_text='Recommendations during the grace period' %}
{% capture acc-8 %}
Merchants must implement IP blocking (IP allowlisting). FQDN (domain name
blocking) is not supported in this case, as we use fixed IP addresses.
{% endcapture %}
{% include accordion-table.html content=acc-8 button_expand_text='Do we need to implement IP blocking or FQDN blocking in our firewall?' button_collapse_text='Do we need to implement IP blocking or FQDN blocking in our firewall?' %}
{% capture acc-9 %}
If you have any questions or need support during implementation, please contact
your TOM/TAM or our support team.
{% endcapture %}
{% include accordion-table.html content=acc-9 button_expand_text='Who can we contact for assistance?' button_collapse_text='Who can we contact for assistance?' %}

## Callback Example

{% if api_resource == "paymentorders" %}

{% capture response_content %}{
    "paymentOrder": {
        "id": "/psp/{{ api_resource }}/{{ page.payment_id }}",
        "instrument": "{{ api_resource }}"
    },
    "payment": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}",
        "number": 222222222
    },
    "transaction": {
        "id": "/psp/creditcard/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id }}",
        "number": 333333333
    }
}{% endcapture %}

{% include code-example.html
    title='Payment Order Callback'
    header=response_header
    json= response_content
    %}

## Callback Example v3.1

If you have implemented v3.1, the callback will only contain the `paymentOrder`
node.

This response format will only be triggered if you used `version=3.1` in the
original `POST` when you created the `paymentOrder`.

{% capture response_content %}{
    "orderReference": "549213",
    "paymentOrder": {
        "id": "/psp/{{ api_resource }}/{{ page.payment_id }}",
        "instrument": "{{ api_resource }}"
        "number": 12345678
    }
}{% endcapture %}

{% include code-example.html
    title='Payment Order Callback v3.1'
    header=response_header
    json= response_content
    %}

{% capture table %}
{:.table .table-striped .mb-5}
| Field                    | Type         | Description                                                                                                                                                                                                               |
| :----------------------- | :----------- | :------------------- |
| {% f orderReference, 0 %}                | `string`     | The order reference found in the merchant's systems.  If included in the request, the orderReference will appear in the callback.                     |
| {% f paymentOrder, 0 %}           | `object`     | The payment order object.                      |
| {% f id %}  | `string`   | {% include fields/id.md resource="paymentorder" %} |
| {% f instrument %}                | `string`     | The payment method used in the payment.                     |
| {% f number %}                | `string`     | The attempt number which triggered the callback.                     |
{% endcapture %}
{% include accordion-table.html content=table %}

{% else %}

{% capture response_content %}{
    "payment": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
        "number": 222222222
    },
    "transaction": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/authorizations/{{ page.transaction_id }}",
        "number": 333333333
    }
}{% endcapture %}

{% include code-example.html
    title='Payment Method Callback'
    header=response_header
    json= response_content
    %}

{% endif %}

## GET Response

When performing an HTTP `GET` request towards the URL found in the
`transaction.id` field of the callback, the response is going to include the
abbreviated example provided below.

{% include transaction-response.md transaction="authorization" %}

## Sequence Diagram

The sequence diagram below shows the HTTP `POST` you will receive from Swedbank
Pay, and the two `GET` requests that you make to get the updated status.

```mermaid
sequenceDiagram
    Participant Merchant
    Participant SwedbankPay as Swedbank Pay

    activate SwedbankPay
    SwedbankPay->>+Merchant: POST <callbackUrl>
    deactivate SwedbankPay
    note left of Merchant: Callback by Swedbank Pay
    Merchant-->>+SwedbankPay: HTTP response
    Merchant->>+SwedbankPay: GET {{ api_resource }} payment
    deactivate Merchant
    note left of Merchant: First API request
    SwedbankPay-->>+Merchant: payment resource
    deactivate SwedbankPay
```

[url-usage]: /checkout-v3/get-started/fundamental-principles#url-usage
