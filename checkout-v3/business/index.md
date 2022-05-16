---
section: Business
title: Set Up
description: |
  **In this section we are going to guide you through setting up your test account
  and how to make an API request for your first test payment. After these steps,
  you're ready to build your integration!**
checkout_v3: true
menu_order: 200
---

## Step 1: Sign Up For A Test Account

A test account gives you access to our unified dashboard for managing your
account across different platforms. We call this dashboard the Ecom Admin.

Your test account request should be sent to:
[testaccount@swedbankpay.com](mailto:testaccount@swedbankpay.com) in order to
create an account for you, we need some specific information from your side:

*   **Company name:** Your company name.

*   **Services you prefer:** Full Checkout (Starter / Business / Enterprise) or Payments Only (Payments).

*   **Email address:** To a developer or the CTO.

## Step 2: Wait For Response

Within 8 working hours we will have created your account and sent you an email
containing the following information:

**Merchant name:** This represents your core business entity with us.

**Payer ID:** This is how we identify you.

**Services:** The payment options which are activated and ready for testing.

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

*   Your token will **only** be fully visible upon creation. For security
    purposes, we will mask it like this: `12a3**********bc4de56f` when it is
    displayed later. If you need to keep track of it, please copy and save it
    externally in a safe place. The token will not be visible unmasked in any of
    our systems, so a lost token must be replaced by a new one.

{% include alert.html type="warning" icon="warning" body="Please note that the
production and staging environment need separate tokens. " %}

{% include iterator.html prev_href="/checkout-v3/"
                         prev_title="Back to Get Started"
                         next_href="/checkout-v3/business/introduction"
                         next_title="Start Integration" %}
