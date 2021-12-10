---
title: Set Up
estimated_read: 5
description: |
  **In this section we are going to guide you through setting up your test account
  and how to make an API request for your first test payment.
  After these steps, you're ready to build your integration!**
menu_order: 400
checkout_v3: true
---

## Step 1: Sign up for a test account

A test account allows you to access our unified dashboard for managing your
accounts across different platforms. We call this dashboard the Ecom admin.

Your test account request should be sent to:
[testaccount@swedbankpay.com](mailto:testaccount@swedbankpay.com) in order to
create an account for you we will need some specific information from your side:

-   **Company name:** Your company name
-   **Services you prefer:** Full Chceckout (Standard/Authenticated/MAC) or
  Payments Only
-   **Email address:** To developer/CTO

## Step 2: Wait for response

Within 8 working hours we have created your account and sent you an email
containing the following information:

-   **Merchant Name:** This represents your core business entity with us.
-   **Merchant ID:** This is how we identify you.
-   **Services:** These are the services that are activated and ready to test.
-   **Login Credentials:** You will receive a temporary password in a seperate
  e-mail.

{% include alert.html type="warning" icon="warning" body="Please check your spam
folder if you have not received this email." %}

## Step 3: Get your access tokens

To submit payments to us, you'll be making API requests that are authenticated
with an Access Token.

To generate your Access Token:

-   **Log in to:** <https://admin.externalintegration.payex.com/psp/beta/login/>
  for testing environment.
-   **Merchant details:** Here you will find information about your account.

An Access Token is neccessary, since it will be used together with Payee ID to
validate transactions. The Payee ID will serve as the door and your token is the
key.

-   Navigate to "Access Tokens" at the top of the page.
-   Choose "Add" and name the Token. Suggestion is to name it according to what
  environment it is created in.
-   Your Token will only be fully visable upon creation. For security purposes, we
  will mask it like shown in the example above. If you need to keep track of it,
  please save it externally in a safe place as it will remain encrypted.

If you were to add more payments methods later, a new token needs to be created.
This is because tokens are created with their current account settings in mind.

{% include alert.html type="warning" icon="warning" body="Please note that the
production and staging environment need seperate tokens." %}

{% include iterator.html next_href="/checkout/v3/"
                         next_title="Start Integrate" %}
