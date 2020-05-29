{% assign api_resource = include.api_resource | default: true %}

## Payee Reference

{% if api_resource == "invoice" %}
The `payeeReference` is used as a receipt/invoice number when the payer chooses
to pay with Invoice Payments. Depending on the specifications in the contract,
it has some specific processing rules described below.

{% else %}

The `payeeReference` given when creating transactions and payments has some
specific processing rules depending on specifications in the contract.
{% endif %}

*   It must be **unique** for every operation, used to ensure exactly-once
    delivery of a transactional operation from the merchant system.
*   Its length and content validation is dependent on whether the
    `transaction.number` or the `payeeReference` is sent to the acquirer.
    1.  If you select *Option A* in the settlement process (Swedbank Pay will
        handle the settlement), Swedbank Pay will send the `transaction.number` to
        the acquirer and the `payeeReference` must be in the format of characters
        `A-Za-z0-9` (including `-`) and `string(30)`.
    2.  If you select *Option B* in the settlement process (you will handle the
        settlement yourself), Swedbank Pay will send the `payeeReference` to the
        acquirer and it will be limited to the format of `string(12)` and all
        characters **must be digits**.
