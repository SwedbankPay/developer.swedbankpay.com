---
section: Payments
title: Set Up
description: |
  **In this section we are going to guide you through setting up your test account
  and how to make an API request for your first test payment. After these steps,
  you're ready to build your integration!**
checkout_v3: true
menu_order: 100
---

## Step 1: Sign Up For A Test Account

A test account gives you access to our unified dashboard for managing your
account across different platforms. We call this dashboard the Ecom Admin.

Your test account request should be sent to:
[testaccount@swedbankpay.com](mailto:testaccount@swedbankpay.com) in order to
create an account for you, we need some specific information from your side:

*   **Company name:** Your company name.

*   **Services you prefer:** Full Checkout (Standard / Authenticated / Merchant
    Authenticated Consumer) or Payments Only (Payments).

*   **Email address:** To a developer or the CTO.

## Step 2: Wait For Response

Within 8 working hours we will have created your account and sent you an email
containing the following information:

**Merchant name:** This represents your core business entity with us.

**Merchant ID:** This is how we identify you.

**Services:** The services that are activated and ready for testing.

**Login credentials:** You will receive a temporary password in a separate
email.

{% include alert.html type="warning" icon="warning" body="Please
check your spam folder if you haven't received this email. " %}

## Step 3: Get Your Access Tokens

To submit payments to us, you will be making API requests that are authenticated
with an access token.

How to generate your access token:

**Log in to:** https://admin.externalintegration.payex.com/psp/beta/login/ - For
testing environment.

**Merchant details:** Here you will find information about your
account.

An access token is necessary since it will be used together with Payee ID to
validate transactions. The Payee ID will serve as the door and, your token is
the key.

*   Navigate to “Access Tokens” at the top of the page.

*   Choose "Add" and name the token. We suggest you name it according to what
  environment it is created in.

*   Your token will only be fully visible upon creation. For security purposes,
    we will mask it as shown in the example above. If you need to keep track
    of it, please save it externally in a safe place as it will remain
    encrypted.

If you were to add more payment methods later, a new token needs to be created.
This is because tokens are created with their current account settings in mind.

{% include alert.html type="warning" icon="warning" body="Please note that the
production and staging environment need separate tokens. " %}

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started"
                         next_href="/checkout-v3/payments/introduction"
                         next_title="Start Integration" %}
