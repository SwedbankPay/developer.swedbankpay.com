{% capture api_resource %}{% include api-resource.md %}{% endcapture %}
{% capture documentation_section %}{% include utils/documentation-section.md %}{% endcapture %}
{% assign header_level = include.header_level | default: 3 %}
{% assign next_header_level = header_level | plus: 1 %}
{% capture top_h %}{% for i in (1..header_level) %}#{% endfor %}{% endcapture %}
{% capture sub_h %}{% for i in (1..next_header_level) %}#{% endfor %}{% endcapture %}
{% capture features_url %}{% include utils/documentation-section-url.md href='/features' %}{% endcapture %}

{{ top_h }} Transaction

The `transaction` resource contains the generic details of a transaction on a
specific payment.

When a transaction is created it will have one of three states:

*   `Initialized` - if there is some error where the source is undeterminable
    (network failure, etc), the transaction will remain Initialized. The
    corresponding state of the payment order will in this case be set to
    pending.
    No further transactions can be created.
*   `Completed` - if everything went ok the transaction will follow through to
    completion.
*   `Failed` - if the transaction has failed (i.e. a denial from the acquiring
    bank) it is possible to retry (i.e the payer tries using another
    card) up to a maximum amount of retries (in that case which the payment
    order gets the state `failed` as well).

{% if documentation_section contains "checkout" or "payment-menu" %}

{% capture request_header %}GET /psp/paymentorders/{{ page.payment_id }}/currentpayment HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json;version=3.1/3.0/2.0     // Version optional for 3.0 and 2.0{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8; version=3.1/3.0/2.0
api-supported-versions: 3.1/3.0/2.0{% endcapture %}

{% capture response_content %}{
    "paymentorder": "/psp/paymentorders/{{ page.payment_id }}",
    "transaction": {
        "id": "/psp/paymentorders/{{ page.payment_id }}/currentpayment/{{ page.transaction_id }}",
        "created": "2016-09-14T01:01:01.01Z",
        "updated": "2016-09-14T01:01:01.03Z",
        "type": {% if documentation_section == "trustly" %} "Sale", {% else %} "Capture", {% endif %}
        "state": "Initialized",
        "number": 1234567890,
        "amount": 1000,
        "vatAmount": 250,
        "description": "Test transaction",
        "payeeReference": "AH123456",
        "failedReason": "",
        "isOperational": true,
        "operations": []
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% else %}

{% capture request_header %}GET /psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions HTTP/1.1
Host: {{ page.api_host }}
Authorization: Bearer <AccessToken>
Content-Type: application/json{% endcapture %}

{% include code-example.html
    title='Request'
    header=request_header
    json= request_content
    %}

{% capture response_header %}HTTP/1.1 200 OK
Content-Type: application/json{% endcapture %}

{% capture response_content %}{
    "payment": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}",
    "transaction": {
        "id": "/psp/{{ api_resource }}/payments/{{ page.payment_id }}/transactions/{{ page.transaction_id }}",
        "created": "2016-09-14T01:01:01.01Z",
        "updated": "2016-09-14T01:01:01.03Z",
        "type": {% if documentation_section == "trustly" %} "Sale", {% else %} "Capture", {% endif %}
        "state": "Initialized",
        "number": 1234567890,
        "amount": 1000,
        "vatAmount": 250,
        "description": "Test transaction",
        "payeeReference": "AH123456",
        "failedReason": "",
        "isOperational": true,
        "operations": []
    }
}{% endcapture %}

{% include code-example.html
    title='Response'
    header=response_header
    json= response_content
    %}

{% endif %}

{{ sub_h }} Transaction Problems

In the event that a transaction is `failed`, the `transaction` response will
contain a `problem` property as seen in the example below. To view all the
problems that can occur due to an unsuccessful transaction, head over to the
[problems section]({{ features_url }}/technical-reference/problems).

{% include transaction-response.md transaction="transaction" %}
