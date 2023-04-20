---
title: Step by step guide
description: |
  Step by step.
menu_order: 500
---


## Step 1: Sign Up For A Test Account

A test account gives you access to our unified dashboard for managing your
account across different platforms. We call this dashboard the Merchant Portal.

Your test account request should be sent to:
[testaccount@swedbankpay.com](mailto:testaccount@swedbankpay.com) in order to
create an account for you, we need some specific information from your side:

*   **Company name:** Your company name.

*   **Email address:** To a developer or the CTO.

*   **Organization number**: Your organization number.

## Step 2: Wait For Response

Within 8 working hours we will have created your account and sent you an email
containing the following information:

**Merchant name:** This represents your core business entity with us.

**Payee ID:** This is how we identify you.

**Services:** The payment options which are activated and ready for testing.

**Login credentials:** You will receive a temporary password in a separate
email.

{% include alert.html type="warning" icon="warning" body="Please
check your spam folder if you haven't received this email. " %}

## Step 3: Get Your Access Tokens

To submit payments to us, you will be making API requests that are authenticated
with an access token.

How to generate your access token:

**Log in to:** https://merchantportal.externalintegration.swedbankpay.com - For
testing environment.

**Merchant details:** Here you will find information about your
account.

An access token is necessary since it will be used together with Payee ID to
validate transactions. The Payee ID will serve as the door and, your token is
the key.

*   Navigate to “Access Tokens” at the top of the page.

*   Choose "Add" and name the token. We suggest you name it according to what
    environment it is created in.

*   Your token will **only** be fully visible upon creation. For security
    purposes, we will mask it like this: `12a3**********bc4de56f` when it is
    displayed later. If you need to keep track of it, please copy and save it
    externally in a safe place. The token will not be visible unmasked in any of
    our systems, so a lost token must be replaced by a new one.

The integration consists of three main steps.
**Creating** the payment order, **redirecting** the payer to the paymentmenu, and
**capturing** the funds.

If you want to get an overview before proceeding, you can look at the [sequence
diagram][sequence-diagram]. It is also available in the sidebar if you want to
look at it later. Let´s get going with the two first steps of the integration.

## Step 1: Create Payment Order

When the purchase is initiated, you need to create a payment order.

Start by performing a `POST` request towards the `paymentorder` resource
with payer information and a `completeUrl`.

Sometimes you might need to abort purchases. An example could be if a payer does
not complete the purchase within a reasonable timeframe. For those instances we
have `abort`, which you can read about in the [core features][abort-feature].
You can only use `abort` if the payer **has not** completed an `authorize` or a
`sale`.

{% include payment-order-base.md integration_mode="redirect" %}

## Step 2: Display Payment Menu

Among the operations in the POST `paymentOrders` response, you will find the
`redirect-paymetnmenu`. This is the one you need to display payment menu.

{:.code-view-header}
**Response**

```json
{
    "paymentOrder": {
    "operations": [
        {
            "method": "GET",
            "href": "https://ecom.externalintegration.payex.com/payment/menu/b934d6f84a89a01852eea01190c2bbcc937ba29228ca7502df8592975ee3bb0d?_tc_tid=30f2168171e142d38bcd4af2c3721959",
            "rel": "redirect-checkout",
            "contentType": "text/html"
        },
    ]
}
```

## How It Looks

The redirect link opens the payment menu on a new page with the payer
information displayed above the menu. The payer can select their preferred
payment instrument and pay.

{:.text-center}
![screenshot of the merchant managed implementation redirect payment menu][redirect-payments-only-menu]

Once the payer has completed the purchase, they will be redirected to the url set in the `completeUrl` field. You can then perform a `GET` towards the
`paymentOrders` resource to see the purchase state.

You are now ready to capture the funds. Follow the link below to read more about
capture and the other options you have after the purchase.