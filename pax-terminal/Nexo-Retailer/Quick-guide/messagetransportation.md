---
title: Message Transport
permalink: /:path/messagetransportation/
description: Messages are sent using HTTP/1.1 Post 
menu_order: 20
---

All messages are sent using HTTP/1.1 protocol, **Post** and the URL `/EPASSaleToPOI/3.1`.

```http
POST /EPASSaleToPOI/3.1 HTTP/1.1
Accept: */*
Content-type: application/xml; charset=utf-8
Host: 192.168.78.5:11000
Content-Length: 700

```

Make sure to only send one request at a time. The exception to that rule is AbortRequest, LoginRequest and TransactionStatusRequest, which may be sent when there is an unanswered request ongoing.

A nexo response is received in the Http Response for the request. Http status code is `200 - OK`, for any Http Response carrying a nexo Response message. Http status `204 - No Content`, is received when there is no nexo message response to a request.

{% include alert.html type="warning" icon="warning" header="warning"
body="Make sure to wait for the http response long enough. If the socket drops during a PaymentRequest, the terminal is still able to make a transaction but the response cannot be sent. In that perticular case you need to make TransactionStatusRequest. "
%}

{% include iterator.html next_href="/pax-terminal/Nexo-Retailer/Quick-guide/first-message" next_title="Next" %}
