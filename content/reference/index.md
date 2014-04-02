---
title: "App.net API Reference"
---
# App.net API Reference

These pages contain the complete specification of how the App.net API works. We try to follow standard practices to make our API easy to use from one of our [client libraries](/docs/libraries/) or from any normal HTTP client.

* TOC
{:toc}

## Authentication

We use the [OAuth 2.0 protocol](http://tools.ietf.org/html/rfc6749) to authenticate clients to the API. There are multiple ways to get a token to a user's account. Please read our [Authentication Overview](/reference/authentication/) to choose the right one for your app.

## Responses

Our [API responses](/reference/make-request/responses/) are always JSON encoded. We use HTTP status codes to indicate success or failures.

## Migrations

From time to time, we'll need to change the API. If we change the behavior of an endpoint or remove a field, we will provide a migration so clients can opt into the new behavior when their code is updated. [Migrations](/reference/make-request/migrations) are our way of versioning the App.net API.  They allow your app the flexibility to control which version of the API it uses on a per request or global basis.

## Rate Limits

In order to ensure a high quality of service and prevent abuse, our API is rate limited. We use standard HTTP headers and status codes to rate limit requests. For more information (and to view the current rate limits), please see the [Rate Limits documentation](/reference/make-request/rate-limits/).

## Errors

If there is an error, we return an [HTTP status code](/reference/make-request/responses/#possible-http-status-codes) and a JSON response describing it.

