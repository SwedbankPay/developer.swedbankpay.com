{% assign api_resource = include.api_resource default: "Authorization" %} 

## Payment State

The `state` field on the `payment` does not indicate whether a
given transaction was successful or not, it only tells whether the
`payment` resource itself is operational or not. To figure out
the `state` of i.e. {{ api_resource }} transactions, you have two options:

### Paid or Failed Operations

You can perform a `GET` request on the `payment`. As long as the
`payment` has been completed, successful or not, you will find the
`Paid` or `Failed` operation among the operations in the response. 

Please note that a `payment` where a `Failed` attempt has been made,
but the payer still has attempts left to complete the `payment`, you
won't see the `Failed` operation. It will only appear when all attempts have
been made.

### {{ api_resource }} Transaction

Find the `payment`’s list of `transactions` either by expanding
it when retrieving the `payment`, or by performing a `GET`
request towards the `transactions.id` URI.

If you find a `transaction` with `type` equal to {{ api_resource }}, with its
`state` equal to `Completed`, you can be sure that the amount of the `payment`
has been reserved or withdrawn and that the `payment` can be considered
successful.