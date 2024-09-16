## User-Agent

The term [user agent][user-agent]{:target="_blank"} is used for both the web
browser used by the payer as well as the system making HTTP requests towards
Swedbank Pay's APIs. The difference between these two and how they relate to
each other is illustrated in the below sequence diagram:

```plantuml
@startuml "User Agents"
    $participant("payer", "Payer") as Payer
    $participant("merchant", "Merchant") as Merchant
    $participant("server", "Swedbank Pay") as SwedbankPay

    Payer -> Merchant: $code("User-Agent: P") <b>①</b>
    activate Payer
        activate SwedbankPay
            Merchant -> SwedbankPay: $code('User-Agent: M { userAgent: "P" }') <b>②</b>
            activate Merchant
                SwedbankPay --> SwedbankPay: Store request data
                SwedbankPay --> Merchant: $code('{ "initiatingSystemUserAgent": "M" }') <b>③</b>
            deactivate Merchant
        deactivate SwedbankPay
        Merchant --> Payer
    deactivate Payer
@enduml
```

1.  First, the payer makes an HTTP request with their web browser towards the
    merchant's website. This HTTP request contains a `User-Agent` header, here
    given the value **`P`** (for "Payer").
2.  The merchant performs an HTTP request towards Swedbank Pay.
    1.  The merchant extracts the **`P`** value of the `User-Agent` header from
      the payer's browser and sends it to Swedbank Pay in the `userAgent` field
      in the JSON request body.
    2.  The merchant also composes its own user agent string and sends it to
      Swedbank Pay in the `User-Agent` HTTP request header, here represented as
      the value **`M`** (for "Merchant").
3.  Swedbank Pay receives `"userAgent": "P"` and `User-Agent: M`, stores the
    values and returns the **`M`** value in the `initiatingSystemUserAgent`
    response JSON field.

The user agent strings are used for statistical purposes by Swedbank Pay.

[user-agent]: https://en.wikipedia.org/wiki/User_agent
