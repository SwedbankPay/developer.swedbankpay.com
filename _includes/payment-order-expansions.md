## Expanding Resources

If you need to find specific information from one of the `paymentOrder`
resources, you can expand the resource(s) in your `GET` request. In this
example, the `paid` resource is first shown in it's collapsed default state,
then expanded by adding `$expand=paid` when you perform the `GET`. Expand other
resources by exchanging `paid` with whatever resource you wish. Expand several
resources at once by separating them with a comma.

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
        "paid": {
        "id": "/psp/paymentorders/8be318c1-1caa-4db1-e2c6-08d7bf41224d/paid"
        },
}
```

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
        "paid": {
            "id": "/psp/paymentorders/ca59fa8a-3423-40e5-0f77-08d9d133750b/paid",
            "instrument": "CreditCard",
            "number": 99101548603,
            "payeeReference": "1641542301",
            "amount": 1500,
            "details": {}
        },
}
```

If there e.g. is a recurrence or an unscheduled token connected to the payment,
it will appear like this.

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
        "paid": {
            "id": "/psp/paymentorders/91c3ca0d-3710-40f0-0f78-08d9d133750b/paid",
            "instrument": "CreditCard",
            "number": 99101548605,
            "payeeReference": "1641543637",
            "amount": 1500,
            "tokens": [
                {
                    "type": "recurrence",
                    "token": "48806524-6422-4db7-9fbd-c8b81611132f",
                    "name": "492500******0004",
                    "expiryDate": "02/2023"
                }
            ],
            "details": {}
        }
}
```

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
        "paid": {
            "id": "/psp/paymentorders/9f786139-3537-4a8b-0f79-08d9d133750b/paid",
            "instrument": "CreditCard",
            "number": 99101548607,
            "payeeReference": "1641543818",
            "amount": 1500,
            "tokens": [
                {
                    "type": "Unscheduled",
                    "token": "6d495aac-cb2b-4d94-a5f1-577baa143f2c",
                    "name": "492500******0004",
                    "expiryDate": "02/2023"
                }
            ],
            "details": {}
        }
}
```
